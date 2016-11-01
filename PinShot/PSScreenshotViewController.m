//
//  PSScreenshotViewController.m
//  PinShot
//
//  Created by Wang Jinli on 2016/11/1.
//  Copyright © 2016 Wang Jinli. All rights reserved.
//

#import "PSScreenshotViewController.h"

@interface PSScreenshotImageView()
@end

@implementation PSScreenshotImageView

- (BOOL)mouseDownCanMoveWindow {
    return YES;
}

@end

@interface PSScreenshotViewController ()

@end

@implementation PSScreenshotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedImage:) name:@"ShowScreenshot" object:nil];
}

- (void)receivedImage: (NSNotification *)notification {
    NSImage *image = notification.object;
    self.screenshotView.image = image;
}

@end
