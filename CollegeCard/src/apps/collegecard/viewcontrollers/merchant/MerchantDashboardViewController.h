//
// Created by dpostigo on 2/26/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "BasicImageViewController.h"


@interface MerchantDashboardViewController : BasicImageViewController  {

    IBOutlet UILabel *displayNameLabel;
    IBOutlet UILabel *addressLabel;

    IBOutlet UIImageView *profileImageView;


}


- (IBAction) handleSignOut: (id) sender;

@end