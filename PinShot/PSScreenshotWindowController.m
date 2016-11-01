//
//  PSScreenshotWindowController.m
//  PinShot
//
//  Created by Wang Jinli on 2016/11/1.
//  Copyright © 2016 Wang Jinli. All rights reserved.
//

#import "PSScreenshotWindowController.h"

@interface PSScreenshotWindowController ()

@end

@implementation PSScreenshotWindowController

- (void)windowDidLoad {
    [super windowDidLoad];
    self.window.titlebarAppearsTransparent = YES;
    self.window.titleVisibility = NSWindowTitleHidden;
    [[self.window standardWindowButton:NSWindowMiniaturizeButton] setHidden:YES];
    [[self.window standardWindowButton:NSWindowZoomButton] setHidden:YES];
    self.window.movableByWindowBackground = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedImage:) name:@"ShowScreenshot" object:nil];
}

- (void)receivedImage: (NSNotification *)notification {
    NSImage *image = notification.object;
    NSPoint mouseLocation = [NSEvent mouseLocation];
    NSPoint origin = NSMakePoint(mouseLocation.x - image.size.width, mouseLocation.y);
    [self.window setFrame:[self makeRectAtOrigin:origin withSize:image.size] display:YES];
    self.window.contentViewController.view.frame = [self makeRectAtOrigin:NSMakePoint(0, 0) withSize:image.size];
}

- (CGRect)makeRectAtOrigin: (NSPoint)origin withSize: (NSSize)size {
    return NSMakeRect(origin.x, origin.y, size.width, size.height);
}

@end
