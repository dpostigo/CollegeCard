//
// Created by dpostigo on 2/25/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <CoreLocation/CoreLocation.h>
#import "CheckinViewController.h"
#import "SearchPlacesOperation.h"
#import "BasicTextFieldCell.h"
#import "TableTextField.h"
#import "CCPlaceCocoafish.h"
#import "PlaceRowObject.h"


@implementation CheckinViewController {
    CLLocationManager *locationManager;
}


- (void) viewDidLoad {
    [super viewDidLoad];

    NSLog(@"%s", __PRETTY_FUNCTION__);

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
    [dataSource addObject: [[TableSection alloc] initWithTitle: @""]];
}




#pragma mark Callbacks -

- (void) searchSucceededWithPlaces: (NSArray *) places {

    [dataSource removeAllObjects];
    TableSection *tableSection = [[TableSection alloc] initWithTitle: @""];

    if ([places count] == 0) {
        [tableSection.rows addObject: [[TableRowObject alloc] initWithTextLabel: @"No places found."]];
    } else {
        for (CCPlaceCocoafish *place in places) {
            [tableSection.rows addObject: [[PlaceRowObject alloc] initWithPlace: place]];
        }
    }

    [dataSource addObject: tableSection];
    [table reloadData];
}


#pragma mark UITableView -


- (UITableViewCell *) tableView: (UITableView *) tableView cellForRowAtIndexPath: (NSIndexPath *) indexPath {

    TableSection *tableSection = [dataSource objectAtIndex: indexPath.section];
    TableRowObject *rowObject = [tableSection.rows objectAtIndex: indexPath.row];
    BasicTextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier: @"TableCell" forIndexPath: indexPath];

    if ([rowObject isKindOfClass: [PlaceRowObject class]]) {

        PlaceRowObject *placeObject = (PlaceRowObject *) rowObject;
        CCPlaceCocoafish *place = placeObject.place;
        cell.textLabel.text = place.name;
        cell.detailTextLabel.text = place.address;
    } else {

        cell.textLabel.text = rowObject.textLabel;
        cell.detailTextLabel.text = rowObject.detailTextLabel;
    }

    return cell;
}


- (void) didSelectRowObject: (TableRowObject *) rowObject inSection: (TableSection *) tableSection {
    [super didSelectRowObject: rowObject inSection: tableSection];

    if ([rowObject isKindOfClass: [PlaceRowObject class]]) {
        PlaceRowObject *placeRowObject = (PlaceRowObject *) rowObject;
        CCPlaceCocoafish *place = placeRowObject.place;
        _model.currentPlace = place;

        [self performSegueWithIdentifier: @"PlaceSegue" sender: self];
    }
}

@end