//
// Created by dpostigo on 2/24/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <QuartzCore/QuartzCore.h>
#import "SettingsViewController.h"
#import "TableSection.h"
#import "TableRowObject.h"
#import "BasicWhiteView.h"
#import "BasicTableCell.h"
#import "UIColor+Utils.h"
#import "LogoutOperation.h"
#import "SVProgressHUD.h"


#define LOGOUT_KEY @"Log out"


@implementation SettingsViewController {
}


- (void) prepareDataSource {

    TableSection *tableSection;

    tableSection = [[TableSection alloc] initWithTitle: @"Account Info"];
    [tableSection.rows addObject: [[TableRowObject alloc] initWithTextLabel: @"Places Visited (0)"]];
    [tableSection.rows addObject: [[TableRowObject alloc] initWithTextLabel: @"Edit Account Info"]];
    [tableSection.rows addObject: [[TableRowObject alloc] initWithTextLabel: LOGOUT_KEY]];
    [dataSource addObject: tableSection];

    tableSection = [[TableSection alloc] initWithTitle: @"Get Help"];
    [tableSection.rows addObject: [[TableRowObject alloc] initWithTextLabel: @"How it works"]];
    [tableSection.rows addObject: [[TableRowObject alloc] initWithTextLabel: @"For Merchants"]];
    [tableSection.rows addObject: [[TableRowObject alloc] initWithTextLabel: @"Having issues at a business?"]];
    [dataSource addObject: tableSection];

    tableSection = [[TableSection alloc] initWithTitle: @"Social"];
    [tableSection.rows addObject: [[TableRowObject alloc] initWithTextLabel: @"Facebook"]];
    [tableSection.rows addObject: [[TableRowObject alloc] initWithTextLabel: @"Share the love, rate our app"]];
    [dataSource addObject: tableSection];
}


- (NSString *) tableView: (UITableView *) tableView titleForHeaderInSection: (NSInteger) section {
    TableSection *tableSection = [dataSource objectAtIndex: section];
    return tableSection.title;
}


- (UIView *) viewForHeaderInSection: (NSInteger) section {

    TableSection *tableSection = [dataSource objectAtIndex: section];
    BasicTableCell *cell = [table dequeueReusableCellWithIdentifier: @"HeaderCell"];

    [cell.textLabel makeWhiteView];
    cell.textLabel.backgroundColor = [UIColor colorWithString: @"e7913c"];
    cell.textLabel.layer.borderColor = [UIColor colorWithString: @"ffa44a"].CGColor;

    cell.textLabel.text = [NSString stringWithFormat: @"  %@", tableSection.title];

    return cell;
}


- (CGFloat) heightForHeaderInSection: (NSInteger) section {
    return 25;
}


- (UITableViewCell *) tableView: (UITableView *) tableView cellForRowAtIndexPath: (NSIndexPath *) indexPath {

    TableSection *tableSection = [dataSource objectAtIndex: indexPath.section];
    TableRowObject *rowObject = [tableSection.rows objectAtIndex: indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"SettingsTableCell" forIndexPath: indexPath];

    cell.textLabel.text = rowObject.textLabel;
    cell.backgroundView = [[BasicWhiteView alloc] init];

    cell.textLabel.textColor = [UIColor blackColor];

    cell.accessoryView = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"arrow-right-dark.png"]];
    return cell;
}


- (void) didSelectRowObject: (TableRowObject *) rowObject inSection: (TableSection *) tableSection {
    [super didSelectRowObject: rowObject inSection: tableSection];

    if ([rowObject.textLabel isEqualToString: @"Edit Account Info"]) {
        [self performSegueWithIdentifier: @"AccountSegue" sender: self];
    } else if ([rowObject.textLabel isEqualToString: LOGOUT_KEY]) {

        [self handleSignout: nil];
    } else if ([rowObject.textLabel isEqualToString: @"For Merchants"]) {

        [self performSegueWithIdentifier: @"MerchantSegue" sender: self];
    }
}


- (IBAction) handleSignout: (id) sender {
    [SVProgressHUD showWithStatus: @"Signing out..."];
    [_queue addOperation: [[LogoutOperation alloc] initWithDefault]];
}

#pragma mark Callbacks

- (void) logoutSucceeded {

    [SVProgressHUD dismiss];
    [self.navigationController popToRootViewControllerAnimated: YES];
}

@end