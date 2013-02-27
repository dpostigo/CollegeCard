//
// Created by dpostigo on 2/25/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "DPProgressHUD.h"
#import "BasicWhiteView.h"


@implementation DPProgressHUD {
    UIWindow *overlayWindow;
    BasicWhiteView *hudView;
}


- (UIWindow *) overlayWindow {
    if (!overlayWindow) {
        overlayWindow = [[UIWindow alloc] initWithFrame: [UIScreen mainScreen].bounds];
        overlayWindow.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        overlayWindow.backgroundColor = [UIColor colorWithWhite: 0 alpha: 0.5];
        overlayWindow.userInteractionEnabled = NO;
        overlayWindow.windowLevel = UIWindowLevelStatusBar;
    }
    return overlayWindow;
}


- (UIView *) hudView {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    if (!hudView) {

        hudView = [[BasicWhiteView alloc] initWithFrame: CGRectZero];

        //        hudView.layer.cornerRadius = 10;
        //        hudView.backgroundColor = [UIColor colorWithWhite: 0 alpha: 0.8];
        hudView.autoresizingMask = (UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin);

        [self addSubview: hudView];
    }
    return hudView;
}

@end