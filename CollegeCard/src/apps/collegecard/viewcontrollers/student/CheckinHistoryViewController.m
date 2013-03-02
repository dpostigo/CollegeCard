//
// Created by dpostigo on 2/28/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "CheckinHistoryViewController.h"
#import "GetCheckinsOperation.h"
#import "CCCheckin.h"
#import "CheckinRowObject.h"
#import "BasicTextFieldCell.h"
#import "BasicWhiteView.h"
#import "CheckinCell.h"
#import "TTTTimeIntervalFormatter.h"


#define NO_CHECKINS_FOUND @"No check-ins found."


@implementation CheckinHistoryViewController {
    TTTTimeIntervalFormatter *dateFormatter;
}


- (TTTTimeIntervalFormatter *) dateFormatter {
    if (dateFormatter == nil) {
        dateFormatter = [[TTTTimeIntervalFormatter alloc] init];
    }
    return dateFormatter;
}


- (void) loadView {
    self.rowSpacing = 10;
    [super loadView];
}


- (void) prepareDataSource {

    TableSection *tableSection = [[TableSection alloc] initWithTitle: @""];
    [tableSection.rows addObject: [[TableRowObject alloc] initWithTextLabel: @"Getting your check-ins..."]];
    [dataSource addObject: tableSection];

    [_queue addOperation: [[GetCheckinsOperation alloc] initWithUserId: _model.currentUser.objectId]];
}


- (void) configureCell: (UITableViewCell *) tableCell forTableSection: (TableSection *) tableSection rowObject: (TableRowObject *) rowObject {
    [super configureCell: tableCell forTableSection: tableSection rowObject: rowObject];

    if ([rowObject isKindOfClass: [CheckinRowObject class]]) {
        CheckinCell *cell = (CheckinCell *) tableCell;
        CheckinRowObject *checkRowObject = (CheckinRowObject *) rowObject;
        CCCheckin *checkin = checkRowObject.checkIn;

        cell.textLabel.text = checkin.place.name;
        cell.detailTextLabel.text = checkin.place.fullAddress;

        //        cell.accessoryView = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"arrow-right-dark.png"]];
        cell.backgroundView = [[BasicWhiteView alloc] initWithFrame: cell.bounds];
        cell.textLabel.textAlignment = NSTextAlignmentLeft;

        cell.timeLabel.text = [self.dateFormatter stringForTimeIntervalFromDate: checkin.createdAt toDate: [NSDate date]];
    } else {
        BasicTextFieldCell *cell = (BasicTextFieldCell *) tableCell;
        cell.textLabel.text = rowObject.textLabel;
        cell.detailTextLabel.text = rowObject.detailTextLabel;
        cell.textLabel.textAlignment = NSTextAlignmentCenter;

        if ([rowObject.textLabel isEqualToString: NO_CHECKINS_FOUND]) {
            cell.textLabel.font = [UIFont fontWithName: @"HelveticaNeue-Italic" size: cell.textLabel.font.pointSize];
        }
    }
}


- (void) didSelectRowAtIndexPath: (NSIndexPath *) indexPath {
    [super didSelectRowAtIndexPath: indexPath];
    [table deselectRowAtIndexPath: indexPath animated: YES];
}




#pragma mark UITableView

//
//- (CGFloat) heightForRowAtIndexPath: (NSIndexPath *) indexPath {
//    return [super heightForRowAtIndexPath: indexPath];
//}
//
//
//- (CGFloat) heightForTableRow: (TableRowObject *) rowObject inSection: (TableSection *) section {
//    if ([rowObject.cellIdentifier isEqualToString: @"CheckinCell"]) {
//        return
//    }
//}


#pragma mark IBActions


#pragma mark Callbacks

- (void) getCheckinsSucceeded: (NSArray *) checkins {

    [dataSource removeAllObjects];
    TableSection *tableSection = [[TableSection alloc] initWithTitle: @""];

    if ([checkins count] == 0) {
        tableSection.title = NO_CHECKINS_FOUND;
        [tableSection.rows addObject: [[TableRowObject alloc] initWithTextLabel: NO_CHECKINS_FOUND]];
    } else {
        for (CCCheckin *checkin in checkins) {
            CheckinRowObject *rowObject = [[CheckinRowObject alloc] initWithCheckIn: checkin];
            rowObject.cellIdentifier = @"CheckinCell";
            [tableSection.rows addObject: rowObject];
        }
    }

    [dataSource addObject: tableSection];
    [table reloadSections: [NSIndexSet indexSetWithIndex: 0] withRowAnimation: UITableViewRowAnimationFade];
}

@end