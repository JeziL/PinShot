//
//  PSPreferenceViewController.m
//  PinShot
//
//  Created by Wang Jinli on 2016/11/1.
//  Copyright © 2016 Wang Jinli. All rights reserved.
//

#import "PSPreferenceViewController.h"

static NSString * const kPSNewCaptureShortcut = @"NewCaptureShortcut";

@interface PSPreferenceViewController ()

@end

@implementation PSPreferenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    self.shortcutView.associatedUserDefaultsKey = kPSNewCaptureShortcut;
    
}

@end
