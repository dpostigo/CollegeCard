//
//  PuttyView.m
//
//  Created by Tyler Neylon on 6/16/10.
//  Copyleft Bynomial 2010.
//

#import "PuttyView.h"


#define kResizeThumbSize 15


@implementation PuttyView


@synthesize contentView;
@synthesize resizable;
@synthesize touchStart;


- (void) setContentView: (UIView *) newContentView {
    [contentView removeFromSuperview];
    contentView = newContentView;
    contentView.frame = self.bounds;
    [self addSubview: contentView];
}


- (void) setFrame: (CGRect) newFrame {
    [super setFrame: newFrame];
    contentView.frame = self.bounds;
}


- (void) touchesBegan: (NSSet *) touches withEvent: (UIEvent *) event {
    touchStart = [[touches anyObject] locationInView: self];


    isResizing = (self.bounds.size.width - touchStart.x < kResizeThumbSize && self.bounds.size.height - touchStart.y < kResizeThumbSize);
    isResizing = isResizing && resizable;
    if (isResizing) {
        touchStart = CGPointMake(touchStart.x - self.bounds.size.width,
                touchStart.y - self.bounds.size.height);
    }
}


- (void) touchesMoved: (NSSet *) touches withEvent: (UIEvent *) event {
    CGPoint touchPoint = [[touches anyObject] locationInView: self];

    if (isResizing) {
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y,
                touchPoint.x - touchStart.x, touchPoint.y - touchStart.y);
    } else {
        self.center = CGPointMake(self.center.x + touchPoint.x - touchStart.x, self.center.y + touchPoint.y - touchStart.y);
    }
}

@end
