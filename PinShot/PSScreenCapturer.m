//
//  PSScreenCapturer.m
//  PinShot
//
//  Created by Wang Jinli on 2016/11/1.
//  Copyright © 2016 Wang Jinli. All rights reserved.
//

#import "PSScreenCapturer.h"
#import <AppKit/AppKit.h>

#define kScreenCaptureLaunchPath @"/usr/sbin/screencapture"

@interface PSScreenCapturer()

@property (nonatomic, assign) NSUInteger initialPasteboardChangeCount;
@property (nonatomic, assign) NSRect rect;

@end

@implementation PSScreenCapturer

- (void)startCapture {
    self.rect = NSZeroRect;
    self.initialPasteboardChangeCount = [[NSPasteboard generalPasteboard] changeCount];
    NSStoryboard *storyboard = [NSStoryboard storyboardWithName:@"Main" bundle:nil];
    self.overlayWindowController = [storyboard instantiateControllerWithIdentifier:@"OverlayWindow"];
    PSOverlayView *overlayView = (PSOverlayView *)self.overlayWindowController.window.contentViewController.view;
    overlayView.delegate = self;
    [self.overlayWindowController showWindow:self];
    [NSApp activateIgnoringOtherApps:YES];
}

- (void)checkCaptureTaskStatus: (NSNotification *)notification {
    NSTask *captureTask = notification.object;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NSTaskDidTerminateNotification object:captureTask];
    if ([[captureTask launchPath] isEqualToString:kScreenCaptureLaunchPath] && ![captureTask isRunning]) {
        int status = [captureTask terminationStatus];
        if (status == 0) {
            if ([[NSPasteboard generalPasteboard] changeCount] == self.initialPasteboardChangeCount) {
                NSLog(@"Capture Cancelled.");
            }
            else {
                [self captureFinished];
            }
        }
        else {
            NSLog(@"Capture Failed (Code: %d).", status);
        }
    }
}

- (void)captureFinished {
    NSPasteboard *pasteboard = [NSPasteboard generalPasteboard];
    NSString *desiredType = [pasteboard availableTypeFromArray:@[NSPasteboardTypePNG]];
    if ([desiredType isEqualToString:NSPasteboardTypePNG]) {
        NSData *imageData = [pasteboard dataForType:desiredType];
        if (!imageData) {
            NSLog(@"Capture Failed (Nil Data).");
            return;
        }
        if ([_delegate respondsToSelector:@selector(screenCapturer:didFinishCapturingWithImage:atRect:)]) {
            NSImage *image = [[[NSImage alloc] initWithData:imageData] autorelease];
            [_delegate screenCapturer:self didFinishCapturingWithImage:image atRect:self.rect];
        }
    }
}

#pragma mark - PSOverlayViewDelegate Methods

- (void)overlayView:(PSOverlayView *)overlayView didFinishSelectingWithRect:(NSRect)rect {
    NSTask *captureTask = [[NSTask alloc] init];
    captureTask.launchPath = kScreenCaptureLaunchPath;
    NSString *arg = [NSString stringWithFormat:@"-cR%f,%f,%f,%f", rect.origin.x,
                     [[NSScreen mainScreen] frame].size.height - rect.origin.y - rect.size.height,
                     rect.size.width, rect.size.height];
    captureTask.arguments = @[arg];
    [captureTask launch];
    [captureTask autorelease];
    self.rect = rect;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkCaptureTaskStatus:) name:NSTaskDidTerminateNotification object:captureTask];
    [self.overlayWindowController.window close];
}

- (void)overlayViewDidEscapeSelecting:(PSOverlayView *)overlayView {
    NSLog(@"Capture Cancelled by the User.");
    [self.overlayWindowController.window close];
}

@end
