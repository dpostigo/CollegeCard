//
// Created by dpostigo on 2/25/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <CoreLocation/CoreLocation.h>
#import "CheckinViewController.h"
#import "SearchPlacesOperation.h"


@implementation CheckinViewController


- (void) viewDidLoad {
    [super viewDidLoad];

    self.title = @"Check In";
    [self startStandardUpdates];
}


- (void) didUpdateLocations: (NSArray *) locations {
    [super didUpdateLocations: locations];

    CLLocation *location = [locations lastObject];
    [_queue addOperation: [[SearchPlacesOperation alloc] initWithLocation: location]];
}


- (void) prepareDataSource {
    TableSection *tableSection = [[TableSection alloc] initWithTitle: @""];
    [tableSection.rows addObject: [[TableRowObject alloc] initWithTextLabel: @"Searching..."]];
    [dataSource addObject: tableSection];
}

@end