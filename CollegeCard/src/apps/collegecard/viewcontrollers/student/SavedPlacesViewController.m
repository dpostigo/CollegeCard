//
// Created by dpostigo on 3/1/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <SDWebImage/UIImageView+WebCache.h>
#import "SavedPlacesViewController.h"
#import "SearchPlacesOperation.h"
#import "GetPlacesOperation.h"
#import "GetPlaceOperation.h"
#import "PlaceRowObject.h"
#import "CCPhoto.h"


#define SEARCHING_SAVED_PLACES_KEY @"Searching saved places..."


@implementation SavedPlacesViewController {
}


- (void) loadView {
    [super loadView];

    for (NSString *placeId in _model.currentUser.savedPlaces) {
        NSLog(@"placeId = %@", placeId);
        [_queue addOperation: [[GetPlaceOperation alloc] initWithPlaceId: placeId setAsCurrentPlace: NO]];
    }
}


#pragma mark UITableView

- (void) prepareDataSource {
    TableSection *tableSection = [[TableSection alloc] initWithTitle: SEARCHING_SAVED_PLACES_KEY];
    [tableSection.rows addObject: [[TableRowObject alloc] initWithTextLabel: @"Getting your saved places."]];
    [dataSource addObject: tableSection];
}


- (CGFloat) heightForRowAtIndexPath: (NSIndexPath *) indexPath {
    return 200;
}


- (void) configureCell: (UITableViewCell *) tableCell forTableSection: (TableSection *) tableSection rowObject: (TableRowObject *) rowObject {
    [super configureCell: tableCell forTableSection: tableSection rowObject: rowObject];

    if ([rowObject isKindOfClass: [PlaceRowObject class]]) {
        PlaceRowObject *placeRowObject = (PlaceRowObject *) rowObject;
        [tableCell.imageView setImageWithURL: [NSURL URLWithString: placeRowObject.place.photo.largeURL]];
    }

    tableCell.accessoryView = nil;
}



#pragma mark IBActions


#pragma mark Callbacks

- (void) getPlacesSucceeded: (NSArray *) places {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    [self searchSucceededWithPlaces: places];
}


- (void) getPlaceOperationSucceededWithPlace: (CCPlace *) place {
    if (self.navigationController.visibleViewController != self) {
        return;
    }

    NSLog(@"%s", __PRETTY_FUNCTION__);

    TableSection *tableSection = [dataSource objectAtIndex: 0];

    if ([tableSection.title isEqualToString: SEARCHING_SAVED_PLACES_KEY]) {
        tableSection.title = @"Actual places.";
        [tableSection.rows removeAllObjects];
        [tableSection.rows addObject: [[PlaceRowObject alloc] initWithPlace: place]];
        [table reloadSections: [NSIndexSet indexSetWithIndex: 0] withRowAnimation: UITableViewRowAnimationFade];
    } else if ([tableSection.title isEqualToString: @"Actual places"]) {

        NSInteger row = [tableSection.rows count];
        NSLog(@"row = %i", row);
        NSArray *indexPaths = [NSArray arrayWithObject: [NSIndexPath indexPathForRow: row inSection: 0]];
        [tableSection.rows addObject: [[PlaceRowObject alloc] initWithPlace: place]];
        [table insertRowsAtIndexPaths: indexPaths withRowAnimation: UITableViewRowAnimationTop];
    }
}

@end