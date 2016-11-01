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

- (IBAction)save:(NSMenuItem *)sender {
    NSSavePanel *savePanel = [NSSavePanel savePanel];
    [savePanel setNameFieldStringValue:@"NewScreenshot.png"];
    [savePanel beginSheetModalForWindow:[self.view window] completionHandler:^(NSInteger result){
        if (result == NSFileHandlingPanelOKButton) {
            NSURL *fileUrl = [savePanel URL];
            NSData *data = self.screenshotView.image.TIFFRepresentation;
            NSBitmapImageRep *imgRep = [[NSBitmapImageRep alloc] initWithData:data];
            NSData *imgData = [imgRep representationUsingType:NSPNGFileType properties:@{}];
            [imgData writeToURL:fileUrl atomically:NO];
        }
    }];
}

@end
