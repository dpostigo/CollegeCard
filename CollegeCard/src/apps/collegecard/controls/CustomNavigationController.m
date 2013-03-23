//
// Created by dpostigo on 3/11/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "CustomNavigationController.h"
#import "CustomNavigationBar.h"


@implementation CustomNavigationController {
}


@synthesize customNavigationBar;


- (void) loadView {
    [super loadView];

    customNavigationBar = (CustomNavigationBar *) self.navigationBar;
    [customNavigationBar setBackgroundWith: [UIImage imageNamed: @"black-navbar-bg.png"]];
//
//    UIButton *backButton = [customNavigationBar backButtonWith: [UIImage imageNamed: @"back_button_alpha.png"] highlight: nil leftCapWidth: 14.0];
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView: backButton];

}



@end