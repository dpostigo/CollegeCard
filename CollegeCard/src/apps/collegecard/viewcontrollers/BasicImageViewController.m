//
// Created by dpostigo on 3/2/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <SDWebImage/SDWebImageManager.h>
#import <SDWebImage/UIButton+WebCache.h>
#import "BasicImageViewController.h"
#import "CCPhoto.h"
#import "PictureOperation.h"


#define PHOTO_FROM_LIBRARY @"Add Photo from Library"
#define PHOTO_FROM_CAMERA @"Take Photo with Camera"


@implementation BasicImageViewController {
    UIView *containerProgress;
    DDProgressView *progressView;
    UIImage *selectedImage;
}


@synthesize imageButton;




#pragma mark Getters / Setters

- (void) setImageButton: (UIButton *) imageButton1 {
    if (imageButton != nil) {
        [imageButton removeTarget: self action: @selector(handleChoosePicture:) forControlEvents: UIControlEventTouchUpInside];
    }
    imageButton = imageButton1;
    [imageButton addTarget: self action: @selector(handleChoosePicture:) forControlEvents: UIControlEventTouchUpInside];
}



- (IBAction) handleChoosePicture: (id) sender {
    UIActionSheet *actionSheet = [self actionSheetForImagePicker];
    [actionSheet showInView: self.view];
}


- (UIActionSheet *) actionSheetForImagePicker {
    UIActionSheet *actionSheet;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        actionSheet = [[UIActionSheet alloc] initWithTitle: @"" delegate: self cancelButtonTitle: @"Cancel" destructiveButtonTitle: nil otherButtonTitles: PHOTO_FROM_LIBRARY, PHOTO_FROM_CAMERA, nil];
    } else {
        actionSheet = [[UIActionSheet alloc] initWithTitle: @"" delegate: self cancelButtonTitle: @"Cancel" destructiveButtonTitle: nil otherButtonTitles: PHOTO_FROM_LIBRARY, nil];
    }
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    return actionSheet;
}


- (void) actionSheet: (UIActionSheet *) actionSheet clickedButtonAtIndex: (NSInteger) buttonIndex {

    NSString *buttonTitle = [actionSheet buttonTitleAtIndex: buttonIndex];

    if ([buttonTitle isEqualToString: @"Cancel"]) {
        [table deselectRowAtIndexPath: [table indexPathForSelectedRow] animated: YES];
    } else {
        UIImagePickerController *controller = [[UIImagePickerController alloc] init];
        controller.delegate = self;
        if ([buttonTitle isEqualToString: PHOTO_FROM_LIBRARY]) {
            controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        } else if ([buttonTitle isEqualToString: PHOTO_FROM_CAMERA]) {
            controller.sourceType = UIImagePickerControllerSourceTypeCamera;
        }

        [self.navigationController presentViewController: controller animated: YES completion: nil];
    }
}



- (void) imagePickerController: (UIImagePickerController *) picker didFinishPickingImage: (UIImage *) image editingInfo: (NSDictionary *) editingInfo {

    NSLog(@"%s", __PRETTY_FUNCTION__);

    containerProgress = [[UIView alloc] initWithFrame: imageButton.frame];
    containerProgress.backgroundColor = [UIColor blackColor];
    containerProgress.alpha = 0;
    [[imageButton superview] addSubview: containerProgress];

    progressView = [[DDProgressView alloc] initWithFrame: imageButton.bounds];
    [containerProgress addSubview: progressView];
    progressView.innerColor = [UIColor whiteColor];
    progressView.outerColor = [UIColor whiteColor];
    progressView.centerY = containerProgress.height / 2;
    progressView.width = imageButton.width * 0.75;
    progressView.left = (imageButton.width - progressView.width) / 2;

    [picker dismissViewControllerAnimated: YES completion: ^{

        [UIView animateWithDuration: 0.5 animations: ^{
            containerProgress.alpha = 1;
        }                completion: ^(BOOL completion) {

            NSLog(@"_model.currentUser.photo.smallURL = %@", _model.currentUser.photo.smallURL);
            [self imagePickerSelectedImage: image];
            [progressView startAnimating];
        }];
    }];
}


- (void) imagePickerSelectedImage: (UIImage *) image {
    [_queue addOperation: [[PictureOperation alloc] initWithImage: image]];
}
@end