//
//  PSOverlayView.m
//  PinShot
//
//  Created by Wang Jinli on 2016/11/3.
//  Copyright © 2016 Wang Jinli. All rights reserved.
//

#import "PSOverlayView.h"

@implementation PSOverlayView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
}

- (BOOL)acceptsFirstResponder {
    return YES;
}

#pragma mark - Keyboard Events

- (void)keyDown:(NSEvent *)event {
    if ([event keyCode] == 0x35 /* Escape */) {
        [self.shapeLayer removeFromSuperlayer];
        self.shapeLayer = nil;
        if ([_delegate respondsToSelector:@selector(overlayViewDidEscapeSelecting:)]) {
            [_delegate overlayViewDidEscapeSelecting:self];
        }
    }
}

#pragma mark - Mouse Events

- (void)mouseDown:(NSEvent *)event {
    self.startPoint = [self convertPoint:[event locationInWindow] fromView:nil];
    self.shapeLayer = [CAShapeLayer layer];
    self.shapeLayer.strokeColor = [[NSColor whiteColor] CGColor];
    self.shapeLayer.fillColor = [[NSColor grayColor] CGColor];
    [self setWantsLayer:YES];
    [self.layer addSublayer:self.shapeLayer];
}

- (void)mouseDragged:(NSEvent *)event {
    NSPoint point = [self convertPoint:[event locationInWindow] fromView:nil];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, self.startPoint.x, self.startPoint.y);
    CGPathAddLineToPoint(path, NULL, self.startPoint.x, point.y);
    CGPathAddLineToPoint(path, NULL, point.x, point.y);
    CGPathAddLineToPoint(path, NULL, point.x, self.startPoint.y);
    CGPathCloseSubpath(path);
    self.shapeLayer.path = path;
    CGPathRelease(path);
}

- (void)mouseUp:(NSEvent *)event {
    [self.shapeLayer removeFromSuperlayer];
    self.shapeLayer = nil;
    if ([_delegate respondsToSelector:@selector(overlayView:didFinishSelectingWithRect:)]) {
        NSPoint endPoint = [self convertPoint:[event locationInWindow] fromView:nil];
        NSRect rect = NSMakeRect(MIN(self.startPoint.x, endPoint.x), MIN(self.startPoint.y, endPoint.y), ABS(self.startPoint.x - endPoint.x), ABS(self.startPoint.y - endPoint.y));
        [_delegate overlayView:self didFinishSelectingWithRect:rect];
    }
}

@end
