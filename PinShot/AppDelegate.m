//
//  AppDelegate.m
//  PinShot
//
//  Created by Wang Jinli on 2016/11/1.
//  Copyright © 2016 Wang Jinli. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (nonatomic, retain) PSScreenCapturer *capturer;

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
    [self.capturer startCapture];
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
