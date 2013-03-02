//
// Created by dpostigo on 9/19/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "BasicViewController.h"
#import "DeviceUtils.h"
#import "UIImage+Utils.h"


@implementation BasicViewController {
}


@synthesize backgroundView;
@synthesize activityView;


- (void) loadView {
    [super loadView];

    self.view.backgroundColor = [UIColor blackColor];

    if (backgroundView == nil) {
        //        NSString *string = [DeviceUtils isPad] ? @"background-texture-ipad.png": @"background-texture.png";
        NSString *string = @"background-texture.png";

        self.backgroundView = [[UIView alloc] init];
        [backgroundView addSubview: [[UIImageView alloc] initWithImage: [UIImage newImageFromResource: string]]];
        [self.view insertSubview: backgroundView atIndex: 0];
    }
}


- (BOOL) shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation) toInterfaceOrientation {
    return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
}



@end