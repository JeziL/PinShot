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
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

@end
