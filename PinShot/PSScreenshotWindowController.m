//
//  PSScreenshotWindowController.m
//  PinShot
//
//  Created by Wang Jinli on 2016/11/1.
//  Copyright © 2016 Wang Jinli. All rights reserved.
//

#import "PSScreenshotWindowController.h"
#import "PSScreenshotViewController.h"

@interface PSScreenshotWindow : NSWindow

@end

@implementation PSScreenshotWindow

- (BOOL)canBecomeKeyWindow {
    return YES;
}

@end

@interface PSScreenshotWindowController ()

@end

@implementation PSScreenshotWindowController

- (void)windowDidLoad {
    [super windowDidLoad];
    self.window.delegate = self;
    self.window.titlebarAppearsTransparent = YES;
    self.window.titleVisibility = NSWindowTitleHidden;
    [[self.window standardWindowButton:NSWindowMiniaturizeButton] setHidden:YES];
    [[self.window standardWindowButton:NSWindowZoomButton] setHidden:YES];
    self.window.movableByWindowBackground = YES;
    [self.window setLevel:kCGMaximumWindowLevel];
    [self.window setCollectionBehavior:NSWindowCollectionBehaviorCanJoinAllSpaces];
    [self.window setStyleMask:[self.window styleMask] | NSResizableWindowMask];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedImage:) name:@"ShowScreenshot" object:nil];
}

- (void)windowDidResize:(NSNotification *)notification {
    PSScreenshotViewController *contentVc = (PSScreenshotViewController *)self.contentViewController;
    contentVc.view.frame = NSMakeRect(0, 0, self.window.frame.size.width, self.window.frame.size.height);
    contentVc.screenshotView.frame = NSMakeRect(0, 0, self.window.frame.size.width, self.window.frame.size.height);
}

- (void)receivedImage: (NSNotification *)notification {
    NSImage *image = notification.object;
    NSDictionary *rectInfo = notification.userInfo;
    NSRect rect = NSMakeRect([[rectInfo objectForKey:@"x"] floatValue], [[rectInfo objectForKey:@"y"] floatValue], [[rectInfo objectForKey:@"w"] floatValue], [[rectInfo objectForKey:@"h"] floatValue]);
    [self.window setFrame:rect display:YES];
    self.window.contentViewController.view.frame = [self makeRectAtOrigin:NSMakePoint(0, 0) withSize:image.size];
    [self.window setContentMinSize:NSMakeSize(0, 0)];
    [self.window setContentAspectRatio:rect.size];
}

- (CGRect)makeRectAtOrigin: (NSPoint)origin withSize: (NSSize)size {
    return NSMakeRect(origin.x, origin.y, size.width, size.height);
}

@end
