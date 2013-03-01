//
// Created by dpostigo on 2/26/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "UserSettingsViewController.h"
#import "PictureOperation.h"
#import "BasicTextFieldCell.h"
#import "DDProgressView.h"
#import "CCPhoto.h"
#import "SVProgressHUD.h"
#import "LogoutOperation.h"
#import "BasicWhiteView.h"
#import <SDWebImage/UIImageView+WebCache.h>


#define MY_CHECKINS_KEY @"My Checkins"
#define MY_PROFILE_KEY @"My Profile"

#define MY_SAVED_PLACES_KEY @"My Saved Places"


@implementation UserSettingsViewController


- (void) loadView {
    self.rowSpacing = 10;
    [super loadView];

    [self sizeTableToFit];
}


#pragma mark UITableView


- (void) prepareDataSource {
    TableSection *tableSection;
    tableSection = [[TableSection alloc] initWithTitle: @""];
    [tableSection.rows addObject: [[TableRowObject alloc] initWithTextLabel: USERVIEW_KEY detailTextLabel: _model.currentUser.email cellIdentifier: @"UserCell"]];
    [tableSection.rows addObject: [[TableRowObject alloc] initWithTextLabel: MY_CHECKINS_KEY detailTextLabel: @"" cellIdentifier: @"NavCell"]];
    [tableSection.rows addObject: [[TableRowObject alloc] initWithTextLabel: MY_PROFILE_KEY detailTextLabel: @"" cellIdentifier: @"NavCell"]];
    [tableSection.rows addObject: [[TableRowObject alloc] initWithTextLabel: MY_SAVED_PLACES_KEY detailTextLabel: @"" cellIdentifier: @"NavCell"]];
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
    return [super heightForRowAtIndexPath: indexPath];
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

    if ([rowObject.textLabel isEqualToString: EMAIL_KEY]) {
        cell.textField.userInteractionEnabled = NO;
        cell.textField.text = rowObject.detailTextLabel;
    }

    else if ([rowObject.textLabel isEqualToString: USERVIEW_KEY]) {
        [self handleUserCell: cell forTableSection: tableSection rowObject: rowObject];
    } else if ([rowObject.cellIdentifier isEqualToString: @"NavCell"]) {
        cell.accessoryView = _model.nextImageView;
    }
}


- (void) handleUserCell: (UITableViewCell *) tableCell forTableSection: (TableSection *) tableSection rowObject: (TableRowObject *) rowObject {
    BasicTextFieldCell *cell = (BasicTextFieldCell *) tableCell;
    cell.textLabel.text = _model.currentUser.displayName;

    NSInteger numCheckins = [_model.currentUser.checkins count];
    NSString *numCheckinString = [NSString stringWithFormat: @"%u Check-Ins", numCheckins];
    if (numCheckins == 1) numCheckinString = [NSString stringWithFormat: @"%i Check-In", numCheckins];

    NSInteger numPlaces = [_model.currentUser.savedPlaces count];
    NSString *numPlacesString = [NSString stringWithFormat: @"%i Saved Place%@", numPlaces, (numPlaces == 1 ? @"": @"s")];

    cell.textField.text = numCheckinString;
    cell.textField.userInteractionEnabled = NO;

    cell.detailTextField.text = numPlacesString;
    cell.detailTextField.userInteractionEnabled = NO;

    NSString *string = _model.currentUser.photo.smallURL;
    if (string) {
        [cell.imageView setImageWithURL: [NSURL URLWithString: string]];
    }
}


- (void) didSelectRowObject: (TableRowObject *) rowObject inSection: (TableSection *) tableSection {
    [super didSelectRowObject: rowObject inSection: tableSection];

    if ([rowObject.textLabel isEqualToString: MY_CHECKINS_KEY]) {
        [self performSegueWithIdentifier: @"CheckinHistorySegue" sender: self];
    } else if ([rowObject.textLabel isEqualToString: MY_PROFILE_KEY]) {
        [self performSegueWithIdentifier: @"ProfileSegue" sender: self];
    } else if ([rowObject.textLabel isEqualToString: MY_SAVED_PLACES_KEY]) {
        [self performSegueWithIdentifier: @"SavedPlacesSegue" sender: self];
    }
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


- (void) userPictureUpdated {
    [table reloadData];
}
@end