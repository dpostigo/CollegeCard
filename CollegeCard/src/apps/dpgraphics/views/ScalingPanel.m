//
// Created by dpostigo on 9/21/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <QuartzCore/QuartzCore.h>
#import "ScalingPanel.h"

@implementation ScalingPanel {

    CGFloat lastScale;
    CGFloat maximumHeight;
    CGFloat minimumHeight;
}

@synthesize panel;
@synthesize autoRemove;
@synthesize maximumScale;
@synthesize minimumScale;
@synthesize shouldScale;

- (id) initWithFrame: (CGRect) frame {
    self = [super initWithFrame: frame];
    if (self) {

        shouldScale = YES;
        autoRemove = YES;
        self.panel = [[Panel alloc] initWithFrame: CGRectMake(0, 0, self.width, self.height)];
        panel.centerX = self.width / 2;
        panel.centerY = self.height / 2;
        [self addSubview: panel];

        maximumScale = 1.1;
        minimumScale = MIN_PANEL_SCALE;

        [panel.backgroundView rasterize];

        UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget: self action: @selector(handlePinch:)];
        [self addGestureRecognizer: pinchGestureRecognizer];
    }

    return self;
}

- (void) handlePinch: (UIPinchGestureRecognizer *) pinchGestureRecognizer {

    if (shouldScale) {
        if ([pinchGestureRecognizer state] == UIGestureRecognizerStateBegan) {

            [self rasterize];
            lastScale = [pinchGestureRecognizer scale];
            [self didBeginScaling];
        }

        if ([pinchGestureRecognizer state] == UIGestureRecognizerStateBegan || [pinchGestureRecognizer state] == UIGestureRecognizerStateChanged) {
            [self handlePinchChanged: pinchGestureRecognizer];
        }

        if ([pinchGestureRecognizer state] == UIGestureRecognizerStateEnded) {
            [self handlePinchEnded: pinchGestureRecognizer];
            [self unrasterize];
        }
    }
}

- (void) handlePinchChanged: (UIPinchGestureRecognizer *) pinchGestureRecognizer {
    CGFloat currentScale = [[panel.layer valueForKeyPath: @"transform.scale"] floatValue];
    CGFloat newScale = 1 - (lastScale - [pinchGestureRecognizer scale]); // new scale is in the range (0-1)
    newScale = MIN(newScale, maximumScale / currentScale);
    newScale = MAX(newScale, minimumScale / currentScale);

    CGAffineTransform currentTransform = panel.transform;
    CGAffineTransform newTransform = CGAffineTransformScale(currentTransform, newScale, newScale);
    panel.transform = newTransform;

    lastScale = [pinchGestureRecognizer scale];  // Store the previous scale factor for the next pinch gesture call

}

- (void) handlePinchEnded: (UIPinchGestureRecognizer *) pinchGestureRecognizer {

    CGFloat newScale;
    CGAffineTransform newTransform;
    CGAffineTransform currentTransform = panel.transform;
    BOOL isMaximum = NO;

    if (panel.width > self.width) {
        newScale = self.width / panel.width;
        isMaximum = YES;
        [self willScaleToMaximum];
    } else {
        newScale = PANEL_WIDTH / panel.width;
        if ([delegate respondsToSelector: @selector(scalingPanelWillScaleToMinimum:)]) {
            [delegate performSelector: @selector(scalingPanelWillScaleToMinimum:) withObject: self];
        }
    }

    newTransform = CGAffineTransformScale(currentTransform, newScale, newScale);

    [self rasterize];

    CGFloat duration = (isMaximum ? 0.5: 0.25);


    [UIView animateWithDuration: duration delay: 0.0 options: UIViewAnimationOptionCurveEaseOut animations: ^{

        if (isMaximum) {
            [self scaleToMaximum];
        }
        else [self scaleToMinimum];
    }

                     completion: ^(BOOL completion) {

                         [self unrasterize];

                         if (isMaximum) {
                             [self didScaleToMaximum];
                         } else {
                             [self didScaleToMinimum];
                             if (autoRemove) [self removeFromSuperview];
                         }
                     }];
}

- (void) scaleToMinimum {
    CGFloat newScale = PANEL_WIDTH/ panel.width;
    CGAffineTransform newTransform = CGAffineTransformScale(panel.transform, newScale, newScale);
    panel.transform = newTransform;
}

- (void) scaleToMinimum: (BOOL) isAnimated {
    if (isAnimated) {

        UIViewAnimationOptions options = UIViewAnimationOptionCurveEaseInOut;

        [UIView animateWithDuration: 0.5 delay: 0.0 options: options animations: ^{
            [self scaleToMinimum];
        }                completion: ^(BOOL completion) {
            [self didScaleToMinimum];
        }];
    }

    else {
        [self scaleToMinimum];
    }
}

- (void) scaleToMaximum {
    CGFloat newScale = self.width / panel.width;
    CGAffineTransform newTransform = CGAffineTransformScale(panel.transform, newScale, newScale);
    panel.transform = newTransform;
}

- (void) scaleToMaximum: (BOOL) isAnimated {
    if (isAnimated) {

        UIViewAnimationOptions options = UIViewAnimationOptionCurveEaseOut;

        [UIView animateWithDuration: 0.5 delay: 0.0 options: options animations: ^{
            [self scaleToMaximum];
        }                completion: ^(BOOL completion) {
            [self didScaleToMaximum];
        }];
    }

    else {
        [self scaleToMaximum];
    }
}

- (void) didScaleToMaximum {

    if ([delegate respondsToSelector: @selector(scalingPanelDidScaleToMaximum:)]) {
        [delegate performSelector: @selector(scalingPanelDidScaleToMaximum:) withObject: self];
    }
}

- (void) didScaleToMinimum {

    if ([delegate respondsToSelector: @selector(scalingPanelDidScaleToMinimum:)]) {
        [delegate performSelector: @selector(scalingPanelDidScaleToMinimum:) withObject: self];
    }
}

- (void) didBeginScaling {
    if ([delegate respondsToSelector: @selector(scalingPanelDidBeginScaling)]) {
        [delegate performSelector: @selector(scalingPanelDidBeginScaling)];
    }
}

- (void) willScaleToMaximum {
    if ([delegate respondsToSelector: @selector(scalingPanelWillScaleToMaximum:)]) {
        [delegate performSelector: @selector(scalingPanelWillScaleToMaximum:) withObject: self];
    }
}

@end