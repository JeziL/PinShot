//
//  PSScreenCapturer.h
//  PinShot
//
//  Created by Wang Jinli on 2016/11/1.
//  Copyright © 2016年 Wang Jinli. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PSScreenCapturerDelegate;


@interface PSScreenCapturer : NSObject

@property (assign) id<PSScreenCapturerDelegate> delegate;

- (void)startCapture;

@end


@protocol PSScreenCapturerDelegate <NSObject>

- (void)screenCapturer: (PSScreenCapturer *)capturer didFinishCapturingWithImage: (NSImage *)image;

@end
