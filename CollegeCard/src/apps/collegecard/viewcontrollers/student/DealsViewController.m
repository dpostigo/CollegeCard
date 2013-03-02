//
// Created by dpostigo on 2/28/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "DealsViewController.h"
#import "GetMerchantEventsOperation.h"
#import "EventRowObject.h"
#import "BasicTableCell.h"
#import "BasicWhiteView.h"


#define NEARBY_DEALS_KEY @"Deals Nearby"

#define SAVED_STORES_DEALS_KEY @"Deals From Your Saved Stores"

#define NO_NEARBY_DEALS_FOUND @"No deals found nearby."


@implementation DealsViewController {
}


- (void) loadView {
    self.rowSpacing = 10;
    [super loadView];
    [self startStandardUpdates];

    if ([_model.currentUser.savedPlaces count] == 0) {
        TableSection *tableSection = [self tableSectionForTitle: SAVED_STORES_DEALS_KEY];
        NSInteger sectionIndex = [dataSource indexOfObject: tableSection];
        [tableSection.rows removeAllObjects];
        [tableSection.rows addObject: [[TableRowObject alloc] initWithTextLabel: @"You don't have any saved places."]];
        [table reloadSections: [NSIndexSet indexSetWithIndex: sectionIndex] withRowAnimation: UITableViewRowAnimationFade];
    } else {
        for (NSString *placeId in _model.currentUser.savedPlaces) {
            [_queue addOperation: [[GetMerchantEventsOperation alloc] initWithPlaceId: placeId]];
        }
    }
}


#pragma mark UITableView

- (void) prepareDataSource {
    TableSection *tableSection;
    tableSection = [[TableSection alloc] initWithTitle: SAVED_STORES_DEALS_KEY];
    [tableSection.rows addObject: [[TableRowObject alloc] initWithTextLabel: @"Searching"]];
    [dataSource addObject: tableSection];

    tableSection = [[TableSection alloc] initWithTitle: NEARBY_DEALS_KEY];
    [tableSection.rows addObject: [[TableRowObject alloc] initWithTextLabel: @"Searching"]];
    [dataSource addObject: tableSection];
}


- (void) configureCell: (UITableViewCell *) tableCell forTableSection: (TableSection *) tableSection rowObject: (TableRowObject *) rowObject {
    [super configureCell: tableCell forTableSection: tableSection rowObject: rowObject];

    BasicTableCell *cell = (BasicTableCell *) tableCell;
    cell.detailTextLabel.text = @"";

    if ([rowObject isKindOfClass: [EventRowObject class]]) {

        EventRowObject *eventObject = (EventRowObject *) rowObject;
        CCEvent *event = eventObject.event;

        cell.textLabel.text = event.name;
        cell.detailTextLabel.text = [_model timeStringForEvent: event];
        cell.captionLabel.text = event.place.name;

        cell.accessoryView = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"arrow-right-dark.png"]];
        cell.backgroundView = [[BasicWhiteView alloc] initWithFrame: cell.bounds];
        cell.textLabel.textAlignment = NSTextAlignmentLeft;

        return;
    }

    if ([rowObject.textLabel isEqualToString: NO_NEARBY_DEALS_FOUND])  {
        cell.textLabel.font = [UIFont fontWithName: @"HelveticaNeue-Italic" size: cell.textLabel.font.pointSize];
    }
}


- (CGFloat) heightForHeaderInTableSection: (TableSection *) tableSection {
    return 40;
}


- (UIView *) viewForHeaderInTableSection: (TableSection *) tableSection {

    BasicTableCell *cell = [table dequeueReusableCellWithIdentifier: @"HeaderCell"];
    cell.textLabel.text = [tableSection.title uppercaseString];
    return cell;
}


- (CGFloat) heightForTableRow: (TableRowObject *) rowObject inSection: (TableSection *) section {
    if ([rowObject.cellIdentifier isEqualToString: @"EventCell"])
        return 80;
    return [super heightForTableRow: rowObject inSection: section];
}



#pragma mark IBActions


#pragma mark Callbacks

- (void) didUpdateLocations: (NSArray *) locations {
    [super didUpdateLocations: locations];

    CLLocation *location = [locations lastObject];
    [_queue addOperation: [[GetMerchantEventsOperation alloc] initWithLocation: location distance: 20]];
}


- (void) getMerchantEventsSucceededWithEvents: (NSArray *) events forPlaceId: (NSString *) placeId {
    NSLog(@"%s", __PRETTY_FUNCTION__);

    TableSection *tableSection = [self tableSectionForTitle: SAVED_STORES_DEALS_KEY];

    if (tableSection == nil) {
        return;
    }

    NSInteger section = [dataSource indexOfObject: tableSection];
    [self updateEvents: events inSection: section];
}


- (void) getMerchantEventsSucceededWithEvents: (NSArray *) events forLocation: (CLLocation *) location {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    TableSection *tableSection = [self tableSectionForTitle: NEARBY_DEALS_KEY];

    if (tableSection == nil) {
        return;
    }

    NSInteger section = [dataSource indexOfObject: tableSection];
    [self updateEvents: events inSection: section];
}


- (void) updateEvents: (NSArray *) events inSection: (NSInteger) sectionIndex {

    NSLog(@"events = %@", events);
    TableSection *tableSection = [dataSource objectAtIndex: sectionIndex];
    NSLog(@"tableSection = %@", tableSection);

    //    [dataSource removeObject: tableSection];
    //    [table deleteSections: [NSIndexSet indexSetWithIndex: sectionIndex] withRowAnimation: UITableViewRowAnimationFade];

    [tableSection.rows removeAllObjects];

    if ([events count] == 0) {
        [tableSection.rows addObject: [[TableRowObject alloc] initWithTextLabel: NO_NEARBY_DEALS_FOUND]];
    } else {
        for (CCEvent *event in events) {
            NSLog(@"event.name = %@", event.name);
            [tableSection.rows addObject: [[EventRowObject alloc] initWithEvent: event cellIdentifier: @"EventCell"]];
        }
    }

    //    [dataSource addObject: tableSection];
    //    [table insertSections: [NSIndexSet indexSetWithIndex: sectionIndex] withRowAnimation: UITableViewRowAnimationFade];

    [table reloadSections: [NSIndexSet indexSetWithIndex: sectionIndex] withRowAnimation: UITableViewRowAnimationFade];
}

@end