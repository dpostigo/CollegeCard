//
// Created by dpostigo on 2/25/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "BasicViewController.h"
#import "BasicTableViewController.h"


@interface MerchantSignupViewController : BasicTableViewController <UIAlertViewDelegate> {

    IBOutlet UIButton *submitButton;
}


- (IBAction) switchSections: (id) sender;

@end