//
// Created by dpostigo on 2/24/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "BasicTableViewController.h"
#import "BasicTableViewControllerProtocol.h"
#import "CBLayer.h"


@interface LoginViewController : BasicTableViewController <BasicTableViewControllerProtocol> {

    IBOutlet UIView *footerView;

    IBOutlet CBLayer *loginButton;
    IBOutlet CBLayer *signUpButton;
}


@property(nonatomic, strong) CBLayer *signUpButton;
- (IBAction) handleLogin: (id) sender;
- (IBAction) handleSignup: (id) sender;

@end