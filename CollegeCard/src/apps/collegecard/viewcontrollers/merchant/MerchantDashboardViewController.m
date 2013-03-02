//
// Created by dpostigo on 2/26/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <QuartzCore/QuartzCore.h>
#import "MerchantDashboardViewController.h"
#import "SVProgressHUD.h"
#import "LogoutOperation.h"
#import "GetPlaceOperation.h"


#define DEALS_KEY @"Your Limited Deals"

#define DISCOUNTS_KEY @"Your Discounts"

#define STORE_DETAILS_KEY @"Your Store Profile"


@implementation MerchantDashboardViewController {
}


- (void) loadView {
    [super loadView];
    self.navigationItem.hidesBackButton = YES;
    [_queue addOperation: [[GetPlaceOperation alloc] initWithPlaceId: _model.currentUser.placeId]];
}


- (void) populateMerchantView {
    displayNameLabel.text = _model.currentPlace.name;
    addressLabel.text = _model.currentPlace.fullAddress;
}


#pragma mark Image Handling -

//- (void) imagePickerSelectedImage: (UIImage *) image {
//    [super imagePickerSelectedImage: image];
//
//}


#pragma mark IBActions

- (IBAction) handleSignOut: (id) sender {
    [SVProgressHUD showWithStatus: @"Signing out..."];
    [_queue addOperation: [[LogoutOperation alloc] initWithDefault]];
}




#pragma mark Callbacks


- (void) logoutSucceeded {
    [SVProgressHUD dismiss];
    [self.navigationController popToRootViewControllerAnimated: YES];
}


- (void) getPlaceOperationSucceeded {
    [self populateMerchantView];
}


#pragma mark UITableView -

- (void) prepareDataSource {

    TableSection *tableSection = [[TableSection alloc] initWithTitle: @""];
    [tableSection.rows addObject: [[TableRowObject alloc] initWithTextLabel: DISCOUNTS_KEY detailTextLabel: @"Set your preferences for student discounts"]];
    [tableSection.rows addObject: [[TableRowObject alloc] initWithTextLabel: DEALS_KEY detailTextLabel: @"Broadcast news of limited-time offers to customers"]];
    [tableSection.rows addObject: [[TableRowObject alloc] initWithTextLabel: STORE_DETAILS_KEY detailTextLabel: @"Modify your store information"]];

    [dataSource addObject: tableSection];
}


- (UITableViewCell *) tableView: (UITableView *) tableView cellForRowAtIndexPath: (NSIndexPath *) indexPath {
    TableSection *tableSection = [dataSource objectAtIndex: indexPath.section];
    TableRowObject *rowObject = [tableSection.rows objectAtIndex: indexPath.row];
    UITableViewCell *cell = [super tableView: tableView cellForRowAtIndexPath: indexPath];
    cell.detailTextLabel.text = rowObject.detailTextLabel;
    cell.accessoryView = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"arrow-right-dark.png"]];

    cell.selectedBackgroundView.layer.cornerRadius = 3.0;
    cell.selectedBackgroundView.layer.masksToBounds = YES;
    cell.selectedBackgroundView.clipsToBounds = YES;
    return cell;
}


- (void) didSelectRowObject: (TableRowObject *) rowObject inSection: (TableSection *) tableSection {
    [super didSelectRowObject: rowObject inSection: tableSection];

    if ([rowObject.textLabel isEqualToString: DEALS_KEY]) {

        [self performSegueWithIdentifier: @"MerchantDealsSegue" sender: self];
    }
}

@end