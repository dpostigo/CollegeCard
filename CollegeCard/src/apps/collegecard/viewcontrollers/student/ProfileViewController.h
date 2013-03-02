//
// Created by dpostigo on 2/28/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "BasicTableViewController.h"
#import "BasicImageViewController.h"


@interface ProfileViewController : BasicImageViewController <UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate> {

    UIView *containerProgress;
    IBOutlet UIImageView *imageView;

    IBOutlet UILabel *displayNameLabel;
    IBOutlet UITextField *majorTextField;
    IBOutlet UITextField *collegeTextField;


}



@end