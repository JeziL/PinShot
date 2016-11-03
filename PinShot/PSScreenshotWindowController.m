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
    [self.window setLevel:kCGMaximumWindowLevel];
    [self.window setCollectionBehavior:NSWindowCollectionBehaviorCanJoinAllSpaces];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedImage:) name:@"ShowScreenshot" object:nil];
}

- (void)receivedImage: (NSNotification *)notification {
    NSImage *image = notification.object;
    NSDictionary *rectInfo = notification.userInfo;
    NSRect rect = NSMakeRect([[rectInfo objectForKey:@"x"] floatValue], [[rectInfo objectForKey:@"y"] floatValue], [[rectInfo objectForKey:@"w"] floatValue], [[rectInfo objectForKey:@"h"] floatValue]);
    [self.window setFrame:rect display:YES];
    self.window.contentViewController.view.frame = [self makeRectAtOrigin:NSMakePoint(0, 0) withSize:image.size];
}

- (CGRect)makeRectAtOrigin: (NSPoint)origin withSize: (NSSize)size {
    return NSMakeRect(origin.x, origin.y, size.width, size.height);
}

@end
