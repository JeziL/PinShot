//
//  AppDelegate.m
//  PinShot
//
//  Created by Wang Jinli on 2016/11/1.
//  Copyright © 2016 Wang Jinli. All rights reserved.
//

#import <MASShortcut/Shortcut.h>
#import "AppDelegate.h"

static NSString * const kPSNewCaptureShortcut = @"NewCaptureShortcut";

@interface AppDelegate ()

@property (nonatomic, retain) PSScreenCapturer *capturer;
@property (strong) NSStatusItem *statusItem;

@end

@implementation AppDelegate

@synthesize windowController;
@synthesize viewController;

- (void)dealloc {
    [_capturer release];
    _capturer = nil;
    [super dealloc];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    [NSApp setActivationPolicy:NSApplicationActivationPolicyAccessory];
    [self initStatusMenu];
    if (![[NSUserDefaults standardUserDefaults] objectForKey:kPSNewCaptureShortcut]) {
        [self registerDefaultShortcut];
    }
    [[MASShortcutBinder sharedBinder] bindShortcutWithDefaultsKey:kPSNewCaptureShortcut toAction:^{
        [self.capturer startCapture];
    }];
}

- (void)registerDefaultShortcut {
    MASShortcut *shortcut = [MASShortcut shortcutWithKeyCode:kVK_ANSI_4 modifierFlags:NSEventModifierFlagShift|NSEventModifierFlagOption|NSEventModifierFlagCommand];
    NSData *shortcutData = [NSKeyedArchiver archivedDataWithRootObject:shortcut];
    [[NSUserDefaults standardUserDefaults] setObject:shortcutData forKey:kPSNewCaptureShortcut];
}

- (void)initStatusMenu {
    self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    self.statusItem.title = @"PinShot";
    self.statusItem.menu = self.statusMenu;
}

- (IBAction)newCapture:(NSMenuItem *)sender {
    [self.capturer startCapture];
}

- (IBAction)showPreference:(NSMenuItem *)sender {
    NSStoryboard *storyboard = [NSStoryboard storyboardWithName:@"Main" bundle:nil];
    self.prefWindowController = [storyboard instantiateControllerWithIdentifier:@"PreferenceWindow"];
    [self.prefWindowController showWindow:self];
}

- (PSScreenCapturer *)capturer {
    if (!_capturer) {
        _capturer = [[PSScreenCapturer alloc] init];
        _capturer.delegate = self;
    }
    return _capturer;
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


#pragma mark - PSScreenCapturerDelegate Methods

- (void)screenCapturer:(PSScreenCapturer *)capturer didFinishCapturingWithImage:(NSImage *)image {
    NSStoryboard *storyboard = [NSStoryboard storyboardWithName:@"Main" bundle:nil];
    self.windowController = [storyboard instantiateControllerWithIdentifier:@"ScreenShotWindow"];
    [self.windowController showWindow:self];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ShowScreenshot" object:image];
}

@end
