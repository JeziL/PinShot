//
//  PSOverlayView.h
//  PinShot
//
//  Created by Wang Jinli on 2016/11/3.
//  Copyright © 2016 Wang Jinli. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <QuartzCore/QuartzCore.h>

@protocol PSOverlayViewDelegate;

@interface PSOverlayView : NSView

@property (nonatomic) NSPoint startPoint;
@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@property (assign) id<PSOverlayViewDelegate> delegate;

@end

@protocol PSOverlayViewDelegate <NSObject>

- (void)overlayView: (PSOverlayView *)overlayView didFinishSelectingWithRect: (NSRect)rect;
- (void)overlayViewDidEscapeSelecting: (PSOverlayView *)overlayView;

@end
