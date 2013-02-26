//
// Created by dpostigo on 9/21/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "Panel.h"
#import "BasicView.h"


@class ScalingPanel;

@protocol ScalingPanelDelegate <NSObject>


@optional

- (void) scalingPanelDidScaleToMinimum: (ScalingPanel *) panel;
- (void) scalingPanelDidScaleToMaximum: (ScalingPanel *) panel;
- (void) scalingPanelWillScaleToMinimum: (ScalingPanel *) panel;
- (void) scalingPanelWillScaleToMaximum: (ScalingPanel *) panel;

@end



@interface ScalingPanel : BasicView {

    BOOL shouldScale;
    BOOL autoRemove;
    Panel *panel;


    CGFloat maximumScale;
    CGFloat minimumScale;
}

@property(nonatomic, strong) Panel *panel;
@property(nonatomic) BOOL autoRemove;
@property(nonatomic) CGFloat maximumScale;
@property(nonatomic) CGFloat minimumScale;
@property(nonatomic) BOOL shouldScale;
- (void) handlePinch: (UIPinchGestureRecognizer *) pinchGestureRecognizer;
- (void) scaleToMinimum;
- (void) scaleToMinimum: (BOOL) isAnimated;
- (void) scaleToMaximum;
- (void) scaleToMaximum: (BOOL) isAnimated;

@end