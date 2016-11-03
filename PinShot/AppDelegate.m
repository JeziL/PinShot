//
//  AppDelegate.m
//  PinShot
//
//  Created by Wang Jinli on 2016/11/1.
//  Copyright © 2016 Wang Jinli. All rights reserved.
//

#import <MASShortcut/Shortcut.h>
#import "AppDelegate.h"
#import "PSUserDefaults.h"

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
    if (![[NSUserDefaults standardUserDefaults] objectForKey:kPSNewCaptureShortcutKey]) {
        [self registerDefaultShortcut];
    }
    [[MASShortcutBinder sharedBinder] bindShortcutWithDefaultsKey:kPSNewCaptureShortcutKey toAction:^{
        [self.capturer startCapture];
    }];
}

- (void)registerDefaultShortcut {
    MASShortcut *shortcut = [MASShortcut shortcutWithKeyCode:kPSDefaultNewCaptureShortcutKeyCode modifierFlags:kPSDefaultNewCaptureShortcutModifierFlags];
    NSData *shortcutData = [NSKeyedArchiver archivedDataWithRootObject:shortcut];
    [[NSUserDefaults standardUserDefaults] setObject:shortcutData forKey:kPSNewCaptureShortcutKey];
}

- (void)initStatusMenu {
    self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    self.statusItem.image = [NSImage imageNamed:@"StatusItemImage"];
    self.statusItem.alternateImage = [NSImage imageNamed:@"StatusItemImageHighlighted"];
    self.statusItem.menu = self.statusMenu;
}

- (IBAction)newCapture:(NSMenuItem *)sender {
    [self.capturer startCapture];
}

- (IBAction)showPreference:(NSMenuItem *)sender {
    NSStoryboard *storyboard = [NSStoryboard storyboardWithName:@"Main" bundle:nil];
    self.prefWindowController = [storyboard instantiateControllerWithIdentifier:@"PreferenceWindow"];
    [NSApp activateIgnoringOtherApps:YES];
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

- (void)screenCapturer:(PSScreenCapturer *)capturer didFinishCapturingWithImage:(NSImage *)image atRect:(NSRect)rect {
    NSStoryboard *storyboard = [NSStoryboard storyboardWithName:@"Main" bundle:nil];
    self.windowController = [storyboard instantiateControllerWithIdentifier:@"ScreenShotWindow"];
    [self.windowController showWindow:self];
    NSDictionary *rectInfo = @{@"x": [NSNumber numberWithDouble:rect.origin.x],
                               @"y": [NSNumber numberWithDouble:rect.origin.y],
                               @"w": [NSNumber numberWithDouble:rect.size.width],
                               @"h": [NSNumber numberWithDouble:rect.size.height]};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ShowScreenshot" object:image userInfo:rectInfo];
}

@end
