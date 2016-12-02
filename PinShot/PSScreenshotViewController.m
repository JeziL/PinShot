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

- (void)scrollWheel:(NSEvent *)event {
    if ([event deltaY]) {
        CGFloat deltaY = [event deltaY];
        if (deltaY > 0 && self.window.alphaValue <= 1) {
            self.window.alphaValue = self.window.alphaValue + 0.05;
        }
        else if (deltaY < 0 && self.window.alphaValue > 0.1) {
            self.window.alphaValue = self.window.alphaValue - 0.05;
        }
    }
}

- (void)mouseUp:(NSEvent *)event {
    if ([event clickCount] == 2) {
        [self.window close];
    }
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
    self.view.frame = NSMakeRect(0, 0, image.size.width, image.size.height);
    self.screenshotView.frame = NSMakeRect(0, 0, image.size.width, image.size.height);
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
