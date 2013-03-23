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


- (void) loadView {
    self.rowSpacing = 10;
    [super loadView];

    [self addTopSpacing];
}


#pragma mark UITableView


- (void) prepareDataSource {

    TableSection *tableSection;

//    tableSection = [[TableSection alloc] initWithTitle: @"Account Info"];
//    [tableSection.rows addObject: [[TableRowObject alloc] initWithTextLabel: @"Places Visited (0)"]];
//    [tableSection.rows addObject: [[TableRowObject alloc] initWithTextLabel: @"Edit Account Info"]];
//    [tableSection.rows addObject: [[TableRowObject alloc] initWithTextLabel: LOGOUT_KEY]];
//    [dataSource addObject: tableSection];

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


- (UIView *) viewForHeaderInTableSection: (TableSection *) tableSection {
    BasicTableCell *cell = [table dequeueReusableCellWithIdentifier: @"HeaderCell"];

    //    [cell.textLabel prettify];
    //    cell.textLabel.backgroundColor = [UIColor colorWithString: @"e7913c"];
    //    cell.textLabel.layer.outerBorderColor = [UIColor colorWithString: @"ffa44a"].CGColor;

    cell.textLabel.text = [tableSection.title uppercaseString];

    return cell;
}


- (CGFloat) heightForHeaderInTableSection: (TableSection *) tableSection {
    return 40;
}


- (void) configureCell: (UITableViewCell *) tableCell forTableSection: (TableSection *) tableSection rowObject: (TableRowObject *) rowObject {
    [super configureCell: tableCell forTableSection: tableSection rowObject: rowObject];

    UITableViewCell *cell = tableCell;

    cell.textLabel.text = rowObject.textLabel;
    cell.backgroundView = [[BasicWhiteView alloc] init];

    cell.textLabel.textColor = [UIColor blackColor];

    cell.accessoryView = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"arrow-right-dark.png"]];
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