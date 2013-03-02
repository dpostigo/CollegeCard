//
// Created by dpostigo on 3/2/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "BasicTableViewController.h"
#import "DDProgressView.h"


#define PHOTO_FROM_LIBRARY @"Add Photo from Library"
#define PHOTO_FROM_CAMERA @"Take Photo with Camera"

@interface BasicImageViewController : BasicTableViewController <UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate> {

    UIButton *imageButton;
}


@property(nonatomic, strong) UIButton *imageButton;
- (IBAction) handleChoosePicture: (id) sender;
- (UIActionSheet *) actionSheetForImagePicker;

@end