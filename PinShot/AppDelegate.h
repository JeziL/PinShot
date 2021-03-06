//
//  AppDelegate.h
//  PinShot
//
//  Created by Wang Jinli on 2016/11/1.
//  Copyright © 2016 Wang Jinli. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "PSScreenCapturer.h"
#import "PSScreenshotWindowController.h"
#import "PSScreenshotViewController.h"

@interface AppDelegate : NSObject <NSApplicationDelegate, PSScreenCapturerDelegate>

@property (strong) PSScreenshotWindowController *windowController;
@property (strong) PSScreenshotViewController *viewController;
@property (strong) NSWindowController *prefWindowController;
@property (strong) IBOutlet NSMenu *statusMenu;

- (IBAction)newCapture:(NSMenuItem *)sender;
- (IBAction)showPreference:(NSMenuItem *)sender;
- (IBAction)showAbout:(NSMenuItem *)sender;

@end

