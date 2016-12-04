//
//  PSPreferenceViewController.m
//  PinShot
//
//  Created by Wang Jinli on 2016/11/1.
//  Copyright © 2016 Wang Jinli. All rights reserved.
//

#import "PSPreferenceViewController.h"
#import "PSUserDefaults.h"

@interface PSPreferenceViewController ()

@end

@implementation PSPreferenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.shortcutView.associatedUserDefaultsKey = kPSNewCaptureShortcutKey;
}
    
- (void)viewWillDisappear {
    [self.shortcutView retain];
}

@end
