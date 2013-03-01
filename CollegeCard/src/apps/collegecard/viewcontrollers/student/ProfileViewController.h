//
// Created by dpostigo on 2/28/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "BasicTableViewController.h"


@interface ProfileViewController : BasicTableViewController <UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate> {

    IBOutlet UIImageView *imageView;
    IBOutlet UIButton *button;

    IBOutlet UILabel *displayNameLabel;
    IBOutlet UITextField *majorTextField;
    IBOutlet UITextField *collegeTextField;
}


@end