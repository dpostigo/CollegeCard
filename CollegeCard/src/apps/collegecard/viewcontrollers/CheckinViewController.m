//
// Created by dpostigo on 2/25/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <CoreLocation/CoreLocation.h>
#import "CheckinViewController.h"
#import "SearchPlacesOperation.h"


@implementation CheckinViewController {
    CLLocationManager *locationManager;
}


- (void) viewDidLoad {
    [super viewDidLoad];

    NSLog(@"%s", __PRETTY_FUNCTION__);
    self.title = @"Check In";

    [self startStandardUpdates];
}


- (void) startStandardUpdates {

    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    locationManager.distanceFilter = 500;
    [locationManager startUpdatingLocation];
}


- (void) locationManager: (CLLocationManager *) manager didUpdateLocations: (NSArray *) locations {

    NSLog(@"%s", __PRETTY_FUNCTION__);
    CLLocation *location = [locations lastObject];
    NSDate *eventDate = location.timestamp;
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
    if (abs(howRecent) < 15.0) {
        // If the event is recent, do something with it.
        NSLog(@"latitude %+.6f, longitude %+.6f\n",
                location.coordinate.latitude,
                location.coordinate.longitude);

        [_queue addOperation: [[SearchPlacesOperation alloc] initWithLocation: location]];
    }
}


- (void) prepareDataSource {
    TableSection *tableSection = [[TableSection alloc] initWithTitle: @""];
    [tableSection.rows addObject: [[TableRowObject alloc] initWithTextLabel: @"Searching..."]];
    [dataSource addObject: tableSection];
}



@end