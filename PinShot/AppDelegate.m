//
//  AppDelegate.m
//  PinShot
//
//  Created by Wang Jinli on 2016/11/1.
//  Copyright © 2016 Wang Jinli. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

@synthesize windowController;
@synthesize viewController;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    PSScreenCapturer *cap = [[PSScreenCapturer alloc] init];
    cap.delegate = self;
    [cap startCapture];
}

- (void)screenCapturer:(PSScreenCapturer *)capturer didFinishCapturingWithImage:(NSImage *)image {
    NSStoryboard *storyboard = [NSStoryboard storyboardWithName:@"Main" bundle:nil];
    self.windowController = [storyboard instantiateControllerWithIdentifier:@"ScreenShotWindow"];
    [self.windowController showWindow:self];
    [self.windowController.window setFrame:NSMakeRect(0, 0, image.size.width, image.size.height) display:YES];
    self.viewController = (PSScreenshotViewController *)self.windowController.window.contentViewController;
    self.viewController.view.frame = NSMakeRect(0, 0, image.size.width, image.size.height);
    self.viewController.screenshotView.image = image;
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


@end
