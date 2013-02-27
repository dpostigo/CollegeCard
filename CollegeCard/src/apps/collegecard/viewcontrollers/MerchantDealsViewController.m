//
// Created by dpostigo on 2/26/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "MerchantDealsViewController.h"
#import "GetMerchantEventsOperation.h"
#import "CCEvent.h"
#import "EventRowObject.h"
#import "BasicWhiteView.h"
#import "BasicTextFieldCell.h"
#import "TempEvent.h"
#import "CreateEventOperation.h"


#define NO_DEALS_FOUND @"You don't have any deals. \nTap the + sign on the right to create a limited-time offer."

#define SEARCHING_DEALS_KEY @"Searching for your deals..."


@implementation MerchantDealsViewController {
    int newEventsCount;
}


#pragma mark UITableView

- (void) loadView {
    self.rowSpacing = 10;
    [super loadView];
}


- (void) prepareDataSource {

    if (_model.merchantEvents == nil) {
        [_queue addOperation: [[GetMerchantEventsOperation alloc] initWithPlaceId: _model.currentUser.placeId]];
    }

    TableSection *tableSection = [[TableSection alloc] initWithTitle: @""];
    [tableSection.rows addObject: [[TableRowObject alloc] initWithTextLabel: SEARCHING_DEALS_KEY]];
    [dataSource addObject: tableSection];
}


- (void) configureCell: (UITableViewCell *) tableCell forTableSection: (TableSection *) tableSection rowObject: (TableRowObject *) rowObject {
    [super configureCell: tableCell forTableSection: tableSection rowObject: rowObject];

    BasicTextFieldCell *cell = tableCell;
    if ([rowObject isKindOfClass: [EventRowObject class]]) {
        EventRowObject *eventObject = (EventRowObject *) rowObject;
        CCEvent *event = eventObject.event;

        cell.textLabel.text = event.name;
        //        tableCell.detailTextLabel.text = place.fullAddress;
        cell.accessoryView = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"arrow-right-dark.png"]];
        cell.backgroundView = [[BasicWhiteView alloc] initWithFrame: cell.bounds];
        cell.textLabel.textAlignment = NSTextAlignmentLeft;
    } else {

        cell.textLabel.text = rowObject.textLabel;
        cell.detailTextLabel.text = rowObject.detailTextLabel;
        cell.textLabel.textAlignment = NSTextAlignmentCenter;

        if ([rowObject.textLabel isEqualToString: NO_DEALS_FOUND]) {
            cell.textLabel.font = [UIFont fontWithName: @"HelveticaNeue-Italic" size: cell.textLabel.font.pointSize];
        }
    }
}


- (void) didSelectRowObject: (TableRowObject *) rowObject inSection: (TableSection *) tableSection {
    [super didSelectRowObject: rowObject inSection: tableSection];

    if ([tableSection.title isEqualToString: NO_DEALS_FOUND]) {
    } else {

        EventRowObject *eventObject = (EventRowObject *) rowObject;

        _model.currentEvent = eventObject.event;

        [self performSegueWithIdentifier: @"EventEditSegue" sender: self];
    }
}



#pragma mark IBActions

- (IBAction) createEvent: (id) sender {

    newEventsCount++;
    TempEvent *newEvent = [[TempEvent alloc] init];

    newEvent.name = @"New Event";
    if (newEventsCount > 1) {
        newEvent.name = [NSString stringWithFormat: @"New Event %i", newEventsCount];
    }

    TableSection *tableSection = [dataSource objectAtIndex: 0];

    if ([tableSection.title isEqualToString: NO_DEALS_FOUND]) {
        tableSection.title = @"";
        [tableSection.rows removeAllObjects];;
        [tableSection.rows addObject: [[EventRowObject alloc] initWithEvent: newEvent]];
        [table reloadSections: [NSIndexSet indexSetWithIndex: 0] withRowAnimation: UITableViewRowAnimationFade];
        newEventsCount = 1;
    } else {

        [tableSection.rows insertObject: [[EventRowObject alloc] initWithEvent: newEvent] atIndex: 0];
        NSArray *indexPaths = [NSArray arrayWithObjects: [NSIndexPath indexPathForRow: 0 inSection: 0], [NSIndexPath indexPathForRow: 1 inSection: 0], nil];
        [table insertRowsAtIndexPaths: indexPaths withRowAnimation: UITableViewRowAnimationTop];
    }

    [_queue addOperation: [[CreateEventOperation alloc] initWithTempEvent: newEvent]];
}

#pragma mark Callbacks

- (void) getMerchantEventsSucceededWithEvents: (NSArray *) events {

    [dataSource removeAllObjects];
    TableSection *tableSection = [[TableSection alloc] initWithTitle: @""];

    if ([events count] == 0) {
        tableSection.title = NO_DEALS_FOUND;
        [tableSection.rows addObject: [[TableRowObject alloc] initWithTextLabel: NO_DEALS_FOUND]];
    } else {
        for (CCEvent *event in events) {
            [tableSection.rows addObject: [[EventRowObject alloc] initWithEvent: event]];
        }
    }

    [dataSource addObject: tableSection];
    [table reloadSections: [NSIndexSet indexSetWithIndex: 0] withRowAnimation: UITableViewRowAnimationFade];
}


- (void) createEventSucceeded: (CCEvent *) event forTempEvent: (TempEvent *) tempEvent {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    TableSection *tableSection = [dataSource objectAtIndex: 0];
    for (EventRowObject *rowObject in tableSection.rows) {
        if (rowObject.event == tempEvent) {
            rowObject.event = event;
        }
    }
}
@end