//
//  PSScreenshotViewController.h
//  PinShot
//
//  Created by Wang Jinli on 2016/11/1.
//  Copyright © 2016 Wang Jinli. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface PSScreenshotImageView: NSImageView

- (BOOL)mouseDownCanMoveWindow;

@end

@interface PSScreenshotViewController : NSViewController

@property (assign) IBOutlet PSScreenshotImageView *screenshotView;

- (IBAction)save:(NSMenuItem *)sender;

@end
