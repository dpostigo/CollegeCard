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
        //  NSString *string = [DeviceUtils isPad] ? @"background-texture-ipad.png": @"background-texture.png";
        NSString *string = @"background-texture.png";

        self.backgroundView = [[UIView alloc] init];
        [backgroundView addSubview: [[UIImageView alloc] initWithImage: [UIImage newImageFromResource: string]]];
        [self.view insertSubview: backgroundView atIndex: 0];
    }

    [self customizeAppearance];
}


- (BOOL) shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation) toInterfaceOrientation {
    return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
}


- (void) customizeAppearance {

    NSLog(@"self.navigationItem.leftBarButtonItem = %@", self.navigationItem.leftBarButtonItem);
//    self.navigationItem.leftBarButtonItem = [self customizeBarButtonItem: self.navigationItem.leftBarButtonItem];
}


- (UIBarButtonItem *) customizeBarButtonItem: (UIBarButtonItem *) item {
    if (item != nil) {
        UIButton *button = [UIButton buttonWithType: UIButtonTypeCustom];

        if (item.image != nil) {
            [button setImage: item.image forState: UIControlStateNormal];
        }

        //        if (item.action != nil) {
        ////            [button addTarget: self action: item.action forControlEvents: UIControlEventTouchUpInside];
        //        }

        button.width = button.height = 30;

        item.customView = button;
    }
    return item;
}

@end