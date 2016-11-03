//
//  PSOverlayWindowController.m
//  PinShot
//
//  Created by Wang Jinli on 2016/11/3.
//  Copyright © 2016 Wang Jinli. All rights reserved.
//

#import "PSOverlayWindowController.h"

@interface PSOverlayWindow: NSWindow

@end

@implementation PSOverlayWindow

- (id)initWithContentRect:(NSRect)contentRect styleMask:(NSWindowStyleMask)style backing:(NSBackingStoreType)bufferingType defer:(BOOL)flag {
    if (self = [super initWithContentRect:contentRect styleMask:NSWindowStyleMaskBorderless backing:bufferingType defer:flag]) {
        [self setOpaque:NO];
        [self setHasShadow:NO];
        [self setBackgroundColor:[NSColor clearColor]];
        [self setIgnoresMouseEvents:NO];
        [self setAlphaValue:0.2];
    }
    return self;
}

- (BOOL)canBecomeKeyWindow {
    return YES;
}

@end

@interface PSOverlayWindowController ()

@end

@implementation PSOverlayWindowController

- (void)windowDidLoad {
    [super windowDidLoad];
    [[[NSWorkspace sharedWorkspace] notificationCenter] addObserver:self selector:@selector(activeSpaceDidChange:) name:NSWorkspaceActiveSpaceDidChangeNotification object:nil];
    //self.window.movableByWindowBackground = YES;
    [self.window setLevel:kCGMaximumWindowLevel];
    NSRect frame = [[NSScreen mainScreen] frame];
    frame.size.height = frame.size.height;
    [self.window setFrame:frame display:YES];
    [self.window setCollectionBehavior:NSWindowCollectionBehaviorCanJoinAllSpaces];
    [NSApp activateIgnoringOtherApps:YES];
    [self.window becomeKeyWindow];
}

- (void)activeSpaceDidChange: (NSNotification *)notification {
    [NSApp activateIgnoringOtherApps:YES];
    [self.window becomeKeyWindow];
}

@end
