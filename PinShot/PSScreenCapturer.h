//
//  PSScreenCapturer.h
//  PinShot
//
//  Created by Wang Jinli on 2016/11/1.
//  Copyright © 2016 Wang Jinli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PSOverlayWindowController.h"
#import "PSOverlayView.h"

@protocol PSScreenCapturerDelegate;

@interface PSScreenCapturer : NSObject<PSOverlayViewDelegate>

@property (assign) id<PSScreenCapturerDelegate> delegate;

@property (strong) PSOverlayWindowController *overlayWindowController;

- (void)startCapture;

@end


@protocol PSScreenCapturerDelegate <NSObject>

- (void)screenCapturer: (PSScreenCapturer *)capturer didFinishCapturingWithImage: (NSImage *)image atRect: (NSRect)rect;

@end
