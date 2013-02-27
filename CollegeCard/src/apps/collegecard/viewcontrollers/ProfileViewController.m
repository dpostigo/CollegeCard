//
// Created by dpostigo on 2/26/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "ProfileViewController.h"
#import "PictureOperation.h"
#import "BasicTextFieldCell.h"
#import "DDProgressView.h"
#import "CCPhoto.h"
#import "SVProgressHUD.h"
#import "LogoutOperation.h"
#import <SDWebImage/UIImageView+WebCache.h>


#define PHOTO_FROM_LIBRARY @"Add Photo from Library"
#define PHOTO_FROM_CAMERA @"Take Photo with Camera"


@implementation ProfileViewController {
    UIView *containerProgress;
}


- (void) loadView {
    [super loadView];
    [self populateUserView];

    [self subscribeTextField: collegeTextField];
    [self subscribeTextField: majorTextField];
}


- (void) populateUserView {

    NSString *string = _model.currentUser.photo.thumbURL;
    [imageView setImageWithURL: [NSURL URLWithString: string]];

    displayNameLabel.text = _model.currentUser.displayName;
    if ([_model.currentUser.major isEqualToString: NO_MAJOR_KEY]) {
        majorTextField.placeholder = _model.currentUser.major;
    } else {

        majorTextField.text = _model.currentUser.major;
    }

    if ([_model.currentUser.college isEqualToString: NO_COLLEGE_KEY]) {
        collegeTextField.placeholder = _model.currentUser.college;
    } else {

        collegeTextField.text = _model.currentUser.college;
    }
}


- (IBAction) handleProfilePicture: (id) sender {
    [self handleChoosePicture];
}



#pragma mark UITableView


- (void) prepareDataSource {
    TableSection *tableSection;
    tableSection = [[TableSection alloc] initWithTitle: @""];
    [tableSection.rows addObject: [[TableRowObject alloc] initWithTextLabel: USERVIEW_KEY detailTextLabel: _model.currentUser.email cellIdentifier: @"UserCell"]];
    [tableSection.rows addObject: [[TableRowObject alloc] initWithTextLabel: EMAIL_KEY detailTextLabel: _model.currentUser.email]];
    [tableSection.rows addObject: [[TableRowObject alloc] initWithTextLabel: @"First Name" detailTextLabel: _model.currentUser.firstName]];
    [tableSection.rows addObject: [[TableRowObject alloc] initWithTextLabel: @"Last Name" detailTextLabel: _model.currentUser.lastName]];
    [tableSection.rows addObject: [[TableRowObject alloc] initWithTextLabel: @"Graduation Date" detailTextLabel: _model.currentUser.graduationDate]];
    [tableSection.rows addObject: [[TableRowObject alloc] initWithTextLabel: @"Major" detailTextLabel: _model.currentUser.major]];
    [tableSection.rows addObject: [[TableRowObject alloc] initWithTextLabel: @"Birth Date" detailTextLabel: _model.currentUser.birthDate]];
    [tableSection.rows addObject: [[TableRowObject alloc] initWithTextLabel: @"Gender" detailTextLabel: _model.currentUser.gender]];
    [dataSource addObject: tableSection];
}


- (CGFloat) heightForRowAtIndexPath: (NSIndexPath *) indexPath {
    if (indexPath.row == 0) return 120;
    return [super heightForRowAtIndexPath: indexPath];
}


- (void) configureCell: (UITableViewCell *) tableCell forTableSection: (TableSection *) tableSection rowObject: (TableRowObject *) rowObject {
    [super configureCell: tableCell forTableSection: tableSection rowObject: rowObject];

    BasicTextFieldCell *cell = (BasicTextFieldCell *) tableCell;

    cell.textLabel.text = rowObject.textLabel;
    cell.detailTextLabel.text = rowObject.detailTextLabel;
    cell.textField.placeholder = rowObject.detailTextLabel;
    cell.selectedBackgroundView = [[UIView alloc] init];

    [self subscribeTextField: cell.textField];

    if ([rowObject.textLabel isEqualToString: EMAIL_KEY]) {
        cell.textField.userInteractionEnabled = NO;
        cell.textField.text = rowObject.detailTextLabel;
    }

    else if ([rowObject.textLabel isEqualToString: USERVIEW_KEY]) {

        cell.textLabel.text = _model.currentUser.displayName;

        if ([_model.currentUser.college isEqualToString: NO_COLLEGE_KEY]) {
            cell.textField.placeholder = _model.currentUser.college;
        } else {
            cell.textField.text = _model.currentUser.college;
        }

        if ([_model.currentUser.major isEqualToString: NO_MAJOR_KEY]) {
            cell.detailTextField.placeholder = _model.currentUser.major;
        } else {
            cell.detailTextField.text = _model.currentUser.major;
        }

        NSString *string = _model.currentUser.photo.smallURL;
        if (string) {
            [cell.imageView setImageWithURL: [NSURL URLWithString: string]];
        }

        return;
    }
}






#pragma mark Choose picture


- (void) handleChoosePicture {
    UIActionSheet *actionSheet;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        actionSheet = [[UIActionSheet alloc] initWithTitle: @"" delegate: self cancelButtonTitle: @"Cancel" destructiveButtonTitle: nil otherButtonTitles: PHOTO_FROM_LIBRARY, PHOTO_FROM_CAMERA, nil];
    } else {
        actionSheet = [[UIActionSheet alloc] initWithTitle: @"" delegate: self cancelButtonTitle: @"Cancel" destructiveButtonTitle: nil otherButtonTitles: PHOTO_FROM_LIBRARY, nil];
    }
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    [actionSheet showInView: self.view];
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
        //        [self.navigationController presentModalViewController: controller animated: YES];
    }
}


- (void) imagePickerController: (UIImagePickerController *) picker didFinishPickingImage: (UIImage *) image editingInfo: (NSDictionary *) editingInfo {

    NSLog(@"%s", __PRETTY_FUNCTION__);

    containerProgress = [[UIView alloc] initWithFrame: imageView.frame];
    containerProgress.backgroundColor = [UIColor blackColor];
    containerProgress.alpha = 0;
    [[imageView superview] addSubview: containerProgress];

    DDProgressView *progressView = [[DDProgressView alloc] initWithFrame: imageView.bounds];
    [containerProgress addSubview: progressView];
    progressView.innerColor = [UIColor whiteColor];
    progressView.outerColor = [UIColor whiteColor];
    progressView.centerY = containerProgress.height / 2;
    progressView.width = imageView.width * 0.75;
    progressView.left = (imageView.width - progressView.width) / 2;

    [picker dismissViewControllerAnimated: YES completion: ^{

        [UIView animateWithDuration: 0.5 animations: ^{
            containerProgress.alpha = 1;
        }                completion: ^(BOOL completion) {

            [progressView startAnimating];
            [_queue addOperation: [[PictureOperation alloc] initWithImage: image]];
        }];
    }];
}


#pragma mark IBActions

- (IBAction) handleSignout: (id) sender {
    [SVProgressHUD showWithStatus: @"Signing out..."];
    [_queue addOperation: [[LogoutOperation alloc] initWithDefault]];
}



#pragma mark Callbacks

- (void) logoutSucceeded {
    [SVProgressHUD dismiss];
    [self.navigationController popToRootViewControllerAnimated: YES];
}


- (void) pictureOperationSucceeded {
    NSString *string = _model.currentUser.photo.squareURL;
    [imageView setImageWithURL: [NSURL URLWithString: string]];

    [UIView animateWithDuration: 1.0 animations: ^{
        containerProgress.alpha = 0;
    }                completion: ^(BOOL completion) {
    }];
}

@end