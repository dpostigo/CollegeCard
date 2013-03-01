//
// Created by dpostigo on 3/1/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <CoreLocation/CoreLocation.h>
#import "BasicLocationViewController.h"
#import "SearchPlacesOperation.h"


@implementation BasicLocationViewController {
}


@synthesize locationManager;


- (void) startStandardUpdates {
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    locationManager.distanceFilter = 500;
    [locationManager startUpdatingLocation];
}


- (void) locationManager: (CLLocationManager *) manager didUpdateLocations: (NSArray *) locations {
    CLLocation *location = [locations lastObject];
    NSDate *eventDate = location.timestamp;
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
    if (abs(howRecent) < 15.0) {
        [self didUpdateLocations: locations];
    }
}


- (void) didUpdateLocations: (NSArray *) locations {
}

@end