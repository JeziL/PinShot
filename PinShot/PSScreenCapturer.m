//
//  PSScreenCapturer.m
//  PinShot
//
//  Created by Wang Jinli on 2016/11/1.
//  Copyright © 2016 Wang Jinli. All rights reserved.
//

#import "PSScreenCapturer.h"
#import <AppKit/AppKit.h>

#define kScreenCaptureLaunchPath @"/usr/sbin/screencapture"

@interface PSScreenCapturer()

@property (nonatomic, assign) NSUInteger initialPasteboardChangeCount;

@end

@implementation PSScreenCapturer

- (void)startCapture {
    self.initialPasteboardChangeCount = [[NSPasteboard generalPasteboard] changeCount];
    NSTask *captureTask = [[NSTask alloc] init];
    captureTask.launchPath = kScreenCaptureLaunchPath;
    captureTask.arguments = @[@"-sci"];
    [captureTask launch];
    [captureTask autorelease];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkCaptureTaskStatus:) name:NSTaskDidTerminateNotification object:captureTask];
}

- (void)checkCaptureTaskStatus: (NSNotification *)notification {
    NSTask *captureTask = notification.object;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NSTaskDidTerminateNotification object:captureTask];
    if ([[captureTask launchPath] isEqualToString:kScreenCaptureLaunchPath] && ![captureTask isRunning]) {
        int status = [captureTask terminationStatus];
        if (status == 0) {
            if ([[NSPasteboard generalPasteboard] changeCount] == self.initialPasteboardChangeCount) {
                NSLog(@"Capture Cancelled.");
            }
            else {
                [self captureFinished];
            }
        }
        else {
            NSLog(@"Capture Failed (Code: %d).", status);
        }
    }
}

- (void)captureFinished {
    NSPasteboard *pasteboard = [NSPasteboard generalPasteboard];
    NSString *desiredType = [pasteboard availableTypeFromArray:@[NSPasteboardTypePNG]];
    if ([desiredType isEqualToString:NSPasteboardTypePNG]) {
        NSData *imageData = [pasteboard dataForType:desiredType];
        if (!imageData) {
            NSLog(@"Capture Failed (Nil Data).");
            return;
        }
        if ([_delegate respondsToSelector:@selector(screenCapturer:didFinishCapturingWithImage:)]) {
            NSImage *image = [[[NSImage alloc] initWithData:imageData] autorelease];
            [_delegate screenCapturer:self didFinishCapturingWithImage:image];
        }
    }
}

@end
