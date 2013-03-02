//
// Created by dpostigo on 3/2/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <SDWebImage/SDWebImageManager.h>
#import <SDWebImage/UIButton+WebCache.h>
#import "BasicImageViewController.h"
#import "CCPhoto.h"


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


//
//#pragma mark Choose picture
//
//- (void) imagePickerSelectedImage: (UIImage *) image {
//    //    [_queue addOperation: [[PictureOperation alloc] initWithImage: image]];
//}
//
//
//
//
//#pragma mark Choose picture -
//#pragma mark Private
//
//- (void) handleChoosePicture: (id) sender {
//    UIActionSheet *actionSheet = [self actionSheetForImagePicker];
//    [actionSheet showInView: self.view];
//}
//
//
//- (void) actionSheet: (UIActionSheet *) actionSheet clickedButtonAtIndex: (NSInteger) buttonIndex {
//    NSString *buttonTitle = [actionSheet buttonTitleAtIndex: buttonIndex];
//    if ([buttonTitle isEqualToString: @"Cancel"]) {
//        [table deselectRowAtIndexPath: [table indexPathForSelectedRow] animated: YES];
//    } else {
//        UIImagePickerController *controller = [[UIImagePickerController alloc] init];
//        controller.delegate = self;
//        if ([buttonTitle isEqualToString: PHOTO_FROM_LIBRARY]) {
//            controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//        } else if ([buttonTitle isEqualToString: PHOTO_FROM_CAMERA]) {
//            controller.sourceType = UIImagePickerControllerSourceTypeCamera;
//        }
//
//        [self.navigationController presentViewController: controller animated: YES completion: nil];
//    }
//}
//
//
//- (void) imagePickerController: (UIImagePickerController *) picker didFinishPickingImage: (UIImage *) image editingInfo: (NSDictionary *) editingInfo {
//    [self showProgressInView: imageButton];
//    [picker dismissViewControllerAnimated: YES completion: ^{
//        [self showProgressForImage: image];
//    }];
//}
//
//
//- (void) showProgressInView: (UIView *) view {
//    containerProgress = [[UIView alloc] initWithFrame: view.frame];
//    containerProgress.backgroundColor = [UIColor blackColor];
//    containerProgress.alpha = 0;
//    [[view superview] addSubview: containerProgress];
//
//    progressView = [[DDProgressView alloc] initWithFrame: view.bounds];
//    [containerProgress addSubview: progressView];
//    progressView.innerColor = [UIColor whiteColor];
//    progressView.outerColor = [UIColor whiteColor];
//    progressView.centerY = containerProgress.height / 2;
//    progressView.width = view.width * 0.75;
//    progressView.left = (view.width - progressView.width) / 2;
//}
//
//
//- (void) showProgressForImage: (UIImage *) image {
//    [UIView animateWithDuration: 0.5 animations: ^{
//        containerProgress.alpha = 1;
//    }                completion: ^(BOOL completion) {
//        [self imagePickerSelectedImage: image];
//        [progressView startAnimating];
//    }];
//}
//
//
//
//
//#pragma mark Callbacks
//
//- (void) pictureOperationSucceeded {
//
//    NSLog(@"%s", __PRETTY_FUNCTION__);
//
//
//    [[SDWebImageManager sharedManager].imageCache clearMemory];
//    [[SDWebImageManager sharedManager].imageCache clearDisk];
//
//    NSString *string = _model.currentUser.photo.smallURL;
//    [imageButton setImageWithURL: [NSURL URLWithString: string] forState: UIControlStateNormal];
//    [UIView animateWithDuration: 1.0 animations: ^{
//        containerProgress.alpha = 0;
//    }                completion: ^(BOOL completion) {
//    }];
//}
//
//
//
//#pragma mark Convenience
//
//- (UIActionSheet *) actionSheetForImagePicker {
//    UIActionSheet *actionSheet;
//    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
//        actionSheet = [[UIActionSheet alloc] initWithTitle: @"" delegate: self cancelButtonTitle: @"Cancel" destructiveButtonTitle: nil otherButtonTitles: PHOTO_FROM_LIBRARY, PHOTO_FROM_CAMERA, nil];
//    } else {
//        actionSheet = [[UIActionSheet alloc] initWithTitle: @"" delegate: self cancelButtonTitle: @"Cancel" destructiveButtonTitle: nil otherButtonTitles: PHOTO_FROM_LIBRARY, nil];
//    }
//    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
//    return actionSheet;
//}

@end