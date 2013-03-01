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
#import "NSDate+JMSimpleDate.h"
#import "DeleteEventOperation.h"




@implementation MerchantDealsViewController {
    int newEventsCount;
}


#pragma mark UITableView

- (void) loadView {
    self.rowSpacing = 10;
    self.editingEnabled = YES;
    [super loadView];
}


- (void) prepareDataSource {

    if (_model.merchantEvents == nil) {
        NSLog(@"_model.currentUser.placeId = %@", _model.currentUser.placeId);
        [_queue addOperation: [[GetMerchantEventsOperation alloc] initWithPlaceId: _model.currentUser.placeId]];
    }

    TableSection *tableSection = [[TableSection alloc] initWithTitle: @""];
    [tableSection.rows addObject: [[TableRowObject alloc] initWithTextLabel: SEARCHING_DEALS_KEY]];
    [dataSource addObject: tableSection];
}


- (void) configureCell: (UITableViewCell *) tableCell forTableSection: (TableSection *) tableSection rowObject: (TableRowObject *) rowObject {
    [super configureCell: tableCell forTableSection: tableSection rowObject: rowObject];


    //    _model.dateFormatter.dateFormat = @""

    BasicTextFieldCell *cell = (BasicTextFieldCell *) tableCell;
    cell.textLabel.numberOfLines = 1;


    if ([rowObject isKindOfClass: [EventRowObject class]]) {
        EventRowObject *eventObject = (EventRowObject *) rowObject;
        CCEvent *event = eventObject.event;

        cell.textLabel.text = event.name;
        cell.detailTextLabel.text = [_model timeStringForEvent: event];
        cell.accessoryView = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"arrow-right-dark.png"]];
        cell.backgroundView = [[BasicWhiteView alloc] initWithFrame: cell.bounds];
        cell.textLabel.textAlignment = NSTextAlignmentLeft;
    } else {

        cell.textLabel.text = rowObject.textLabel;
        cell.detailTextLabel.text = rowObject.detailTextLabel;
        cell.textLabel.textAlignment = NSTextAlignmentCenter;

        if ([rowObject.textLabel isEqualToString: NO_DEALS_FOUND]) {
            cell.textLabel.font = [UIFont fontWithName: @"HelveticaNeue-Italic" size: cell.textLabel.font.pointSize];
            cell.textLabel.numberOfLines = 0;
        }
    }
}


- (void) didSelectRowObject: (TableRowObject *) rowObject inSection: (TableSection *) tableSection {
    [super didSelectRowObject: rowObject inSection: tableSection];

    if ([tableSection.title isEqualToString: NO_DEALS_FOUND] || [tableSection.title isEqualToString: SEARCHING_DEALS_KEY]) {
    } else {

        EventRowObject *eventObject = (EventRowObject *) rowObject;
        _model.currentEvent = eventObject.event;
        [self performSegueWithIdentifier: @"EventEditSegue" sender: self];
    }
}


- (void) shouldDeleteRow: (TableRowObject *) rowObject inSection: (TableSection *) tableSection {
    [super shouldDeleteRow: rowObject inSection: tableSection];

    EventRowObject *eventRowObject = (EventRowObject *) rowObject;
    CCEvent *event = eventRowObject.event;

    if ([event isKindOfClass: [TempEvent class]]) {
        return;
    }

    [self deleteRowObject: rowObject inSection: tableSection animation: UITableViewRowAnimationFade];
    [_queue addOperation: [[DeleteEventOperation alloc] initWithEventId: event.objectId]];
}





#pragma mark IBActions

- (IBAction) createEvent: (id) sender {

    newEventsCount++;
    TempEvent *newEvent = [[TempEvent alloc] init];
    newEvent.name = @"New Event";
    newEvent.startTime = [NSDate date];
    newEvent.endTime = [[NSDate date] dateByAddingHours: 1];

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


- (void) eventDidUpdate: (CCEvent *) event {
    TableSection *tableSection = [dataSource objectAtIndex: 0];
    for (EventRowObject *rowObject in tableSection.rows) {
        if ([rowObject.event.objectId isEqualToString: event.objectId]) {
            rowObject.event = event;
        }
    }
    [table reloadData];
}

@end