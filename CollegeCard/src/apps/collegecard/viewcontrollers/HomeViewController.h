//
// Created by dpostigo on 2/24/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "CBLayer.h"
#import "CBBezier.h"
#import "BasicTableViewController.h"


@interface HomeViewController : BasicTableViewController {

    IBOutlet CBBezier *placesButton;
    IBOutlet UILabel *nameLabel;
    IBOutlet UILabel *collegeLabel;
    IBOutlet UILabel *majorLabel;

    IBOutlet UIImageView *imageView;

}


- (IBAction) handleSettingsButton: (id) sender;

@end