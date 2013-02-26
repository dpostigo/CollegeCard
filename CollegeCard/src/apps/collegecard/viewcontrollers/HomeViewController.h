//
// Created by dpostigo on 2/24/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "BasicViewController.h"
#import "CBLayer.h"
#import "CBBezier.h"


@interface HomeViewController : BasicViewController {

    IBOutlet CBBezier *placesButton;
    IBOutlet UILabel *nameLabel;
    IBOutlet UILabel *collegeLabel;
    IBOutlet UILabel *majorLabel;

}


- (IBAction) handleSettingsButton: (id) sender;

@end