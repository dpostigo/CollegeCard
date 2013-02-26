//
// Created by dpostigo on 1/14/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "IrregularButton.h"
#import "UIImage+Alpha.h"


@implementation IrregularButton {
}


- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    if (!CGRectContainsPoint([self bounds], point))
        return nil;
    else
    {
        UIImage *displayedImage = [self imageForState:[self state]];
        if (displayedImage == nil) // No image found, try for background image
            displayedImage = [self backgroundImageForState:[self state]];
        if (displayedImage == nil) // No image could be found, fall back to
            return self;
        BOOL isTransparent = [displayedImage isPointTransparent:point];
        if (isTransparent)
            return nil;

    }

    return self;
}

@end