//
// Created by dpostigo on 3/1/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "BasicTableViewController.h"


@interface BasicLocationViewController : BasicTableViewController <CLLocationManagerDelegate> {

    CLLocationManager *locationManager;
}


@property(nonatomic, strong) CLLocationManager *locationManager;
- (void) startStandardUpdates;
- (void) didUpdateLocations: (NSArray *) locations;

@end