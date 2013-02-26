//
// Created by dpostigo on 9/18/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <QuartzCore/QuartzCore.h>
#import "UIView+DrawingApp.h"

@implementation UIView (DrawingApp)




+ (UIView *) newBasicView {
    return [self newBasicViewWithFrame: CGRectZero];
}

+ (UIView *) newBasicViewWithFrame: (CGRect) frame {

    UIView *basicView = [[UIView alloc] initWithFrame: frame];
    basicView.backgroundColor = [UIColor colorWithString: @"f5f4f0"];
    //basicView.backgroundColor = [UIColor lightGrayColor];
    basicView.clipsToBounds = NO;
    basicView.layer.shadowColor = [UIColor blackColor].CGColor;
    basicView.layer.shadowOffset = CGSizeMake(0, 1);
    basicView.layer.shadowOpacity = 1.0;
    basicView.layer.shadowRadius = 15.0;
    basicView.layer.masksToBounds = NO;
    basicView.layer.borderColor = [UIColor whiteColor].CGColor;
    basicView.layer.borderWidth = 1.0;
    return basicView;
}

+ (void) formatView: (UIView *) basicView {
    basicView.clipsToBounds = NO;
    basicView.layer.shadowColor = [UIColor blackColor].CGColor;
    basicView.layer.shadowOffset = CGSizeMake(0, 1);
    basicView.layer.shadowOpacity = 0.5;
    basicView.layer.shadowRadius = 1.0;
    basicView.layer.masksToBounds = NO;
    basicView.layer.borderColor = [UIColor whiteColor].CGColor;
    basicView.layer.borderWidth = 1.0;

}

@end