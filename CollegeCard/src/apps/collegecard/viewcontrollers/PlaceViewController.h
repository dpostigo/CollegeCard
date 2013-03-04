//
// Created by dpostigo on 2/25/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "BasicViewController.h"
#import "BasicImageViewController.h"


@interface PlaceViewController : BasicImageViewController {

    IBOutlet UILabel *textLabel;
    IBOutlet UILabel *detailTextLabel;
    IBOutlet UIButton *checkinButton;
    IBOutlet UIButton *saveButton;

    IBOutlet UIButton *profileImageButton;
}


@end