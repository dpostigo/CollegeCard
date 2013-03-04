//
// Created by dpostigo on 2/28/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "BasicTableViewController.h"


@interface ProfileViewController : BasicTableViewController <UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate> {

    UIView *containerProgress;
    IBOutlet UIImageView *imageView;

    IBOutlet UILabel *displayNameLabel;
    IBOutlet UITextField *majorTextField;
    IBOutlet UITextField *collegeTextField;


    UIButton *imageButton;
}


@property(nonatomic, strong) UIButton *imageButton;
- (void) handleUserCell: (UITableViewCell *) tableCell forTableSection: (TableSection *) tableSection rowObject: (TableRowObject *) rowObject;

@end