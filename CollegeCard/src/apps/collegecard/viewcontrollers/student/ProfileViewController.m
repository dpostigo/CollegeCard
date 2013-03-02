//
// Created by dpostigo on 2/28/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/UIButton+WebCache.h>
#import "ProfileViewController.h"
#import "SVProgressHUD.h"
#import "BasicTextFieldCell.h"
#import "BasicWhiteView.h"
#import "CCPhoto.h"
#import "PictureOperation.h"
#import "DDProgressView.h"
#import "LogoutOperation.h"
#import "UpdateUserOperation.h"
#import "UserDetailRowObject.h"
#import "TableSection+Utils.h"


@implementation ProfileViewController


- (void) loadView {
    self.rowSpacing = 10;
    [super loadView];
    table.tableHeaderView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, table.width, 10)];
}


#pragma mark UITableView

- (void) prepareDataSource {
    TableSection *tableSection;
    tableSection = [[TableSection alloc] initWithTitle: @""];
    [tableSection.rows addObject: [[TableRowObject alloc] initWithTextLabel: USERVIEW_KEY detailTextLabel: _model.currentUser.email cellIdentifier: @"UserCell"]];
    [tableSection.rows addObject: [[TableRowObject alloc] initWithTextLabel: EMAIL_KEY detailTextLabel: _model.currentUser.email]];
    [tableSection.rows addObject: [[UserDetailRowObject alloc] initWithTextLabel: [_model slugForProperty: @"first_name"] detailTextLabel: _model.currentUser.firstName]];
    [tableSection.rows addObject: [[UserDetailRowObject alloc] initWithTextLabel: [_model slugForProperty: @"last_name"] detailTextLabel: _model.currentUser.lastName]];
    [tableSection.rows addObject: [[UserDetailRowObject alloc] initWithTextLabel: [_model slugForProperty: @"graduationDate"] detailTextLabel: _model.currentUser.graduationDate isCustomField: YES]];
    [tableSection.rows addObject: [[UserDetailRowObject alloc] initWithTextLabel: [_model slugForProperty: @"major"] detailTextLabel: _model.currentUser.major isCustomField: YES]];
    [tableSection.rows addObject: [[UserDetailRowObject alloc] initWithTextLabel: [_model slugForProperty: @"birthDate"] detailTextLabel: _model.currentUser.birthDate isCustomField: YES]];
    [tableSection.rows addObject: [[UserDetailRowObject alloc] initWithTextLabel: [_model slugForProperty: @"gender"] detailTextLabel: _model.currentUser.gender isCustomField: YES]];
    [dataSource addObject: tableSection];
}


- (CGFloat) heightForRowAtIndexPath: (NSIndexPath *) indexPath {

    if (indexPath.row == 0) return 110;
    else if (indexPath.row % 2 == 0) {

        TableSection *tableSection = [dataSource objectAtIndex: indexPath.section];
        TableRowObject *rowObject = [tableSection.rows objectAtIndex: indexPath.row / 2];
        if ([rowObject.cellIdentifier isEqualToString: @"NavCell"]) {
            return 44;
        }
    }

    return [super heightForRowAtIndexPath:
            indexPath];
}


- (void) configureCell: (UITableViewCell *) tableCell forTableSection: (TableSection *) tableSection rowObject: (TableRowObject *) rowObject {
    [super configureCell: tableCell forTableSection: tableSection rowObject: rowObject];

    BasicTextFieldCell *cell = (BasicTextFieldCell *) tableCell;

    cell.textLabel.text = rowObject.textLabel;
    cell.detailTextLabel.text = rowObject.detailTextLabel;
    cell.textField.placeholder = rowObject.detailTextLabel;
    cell.selectedBackgroundView = [[UIView alloc] init];
    cell.backgroundView = [[BasicWhiteView alloc] init];

    [self subscribeTextField: cell.textField];

    if ([cell.textField isKindOfClass: [TableTextField class]]) {
        TableTextField *tableTextField = (TableTextField *) cell.textField;
        tableTextField.rowObject = rowObject;
    }

    if ([rowObject.textLabel isEqualToString: EMAIL_KEY]) {
        cell.textField.userInteractionEnabled = NO;
        cell.textField.text = rowObject.detailTextLabel;
    } else if ([rowObject.textLabel isEqualToString: USERVIEW_KEY]) {
        [self handleUserCell: cell forTableSection: tableSection rowObject: rowObject];
    } else if ([rowObject.cellIdentifier isEqualToString: @"NavCell"]) {
        cell.accessoryView = _model.nextImageView;
    }
}


- (void) handleUserCell: (UITableViewCell *) tableCell forTableSection: (TableSection *) tableSection rowObject: (TableRowObject *) rowObject {

    BasicTextFieldCell *cell = (BasicTextFieldCell *) tableCell;
    cell.textLabel.text = _model.currentUser.displayName;
    self.imageButton = cell.button;

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
        [imageButton setImageWithURL: [NSURL URLWithString: string] forState: UIControlStateNormal];
    }
}


- (void) didSelectRowObject: (TableRowObject *) rowObject inSection: (TableSection *) tableSection {
    [super didSelectRowObject: rowObject inSection: tableSection];

    [self resignAllTextFields];;
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

    [[SDWebImageManager sharedManager].imageCache clearMemory];

    NSString *string = _model.currentUser.photo.smallURL;
    [imageButton setImageWithURL: [NSURL URLWithString: string] forState: UIControlStateNormal];
    [UIView animateWithDuration: 1.0 animations: ^{
        containerProgress.alpha = 0;
    }                completion: ^(BOOL completion) {
    }];
}


- (void) tableTextFieldEndedEditing: (TableTextField *) tableTextField {
    [super tableTextFieldEndedEditing: tableTextField];

    NSLog(@"%s", __PRETTY_FUNCTION__);

    if (tableTextField.text == nil || [tableTextField.text isEqualToString: @""]) {
        return;
    }

    tableTextField.rowObject.stringContent = tableTextField.text;

    if ([tableTextField.rowObject isKindOfClass: [UserDetailRowObject class]]) {

        UserDetailRowObject *rowObject = (UserDetailRowObject *) tableTextField.rowObject;
        NSDictionary *paramDict;
        if (rowObject.isCustomField) {
            NSDictionary *customFields = [NSDictionary dictionaryWithObject: rowObject.stringContent forKey: [_model propertyForSlug: rowObject.textLabel]];
            paramDict = [NSDictionary dictionaryWithObject: customFields forKey: @"custom_fields"];
        } else {
            paramDict = [NSDictionary dictionaryWithObject: rowObject.stringContent forKey: [_model propertyForSlug: rowObject.textLabel]];
        }
        [_queue addOperation: [[UpdateUserOperation alloc] initWithParamDict: paramDict]];
    }
}


- (void) updatedUserForKey: (NSString *) key string: (NSString *) string {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    NSLog(@"key = %@", key);
    TableSection *tableSection = [dataSource objectAtIndex: 0];
    TableRowObject *rowObject = [tableSection tableRowObjectForString: [_model slugForProperty: key]];
    NSInteger row = [tableSection.rows indexOfObject: rowObject];

    if (rowSpacing > 0) row = row * 2;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow: row inSection: 0];
    BasicTextFieldCell *cell = (BasicTextFieldCell *) [table cellForRowAtIndexPath: indexPath];

    cell.textField.placeholder = string;
    cell.textField.text = nil;

    NSArray *indexPaths = [NSArray arrayWithObject: [NSIndexPath indexPathForRow: 0 inSection: 0]];
    [table reloadRowsAtIndexPaths: indexPaths withRowAnimation: UITableViewRowAnimationFade];
}







#pragma mark Image Handling



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

    DDProgressView *progressView = [[DDProgressView alloc] initWithFrame: imageButton.bounds];
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
            [_queue addOperation: [[PictureOperation alloc] initWithImage: image]];

            [progressView startAnimating];
        }];
    }];
}

@end