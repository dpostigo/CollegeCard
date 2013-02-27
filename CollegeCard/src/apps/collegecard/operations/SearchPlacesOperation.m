//
// Created by dpostigo on 2/25/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <CoreLocation/CoreLocation.h>
#import "SearchPlacesOperation.h"
#import "CCResponse.h"
#import "CCPlaceCocoafish.h"


@implementation SearchPlacesOperation {
}


@synthesize location;
@synthesize placeName;


- (id) initWithLocation: (CLLocation *) aLocation {
    CGFloat latitude = (CGFloat) aLocation.coordinate.latitude;
    CGFloat longitude = (CGFloat) aLocation.coordinate.longitude;
    CGFloat distance = 20;
    NSMutableDictionary *paramDict = [[NSMutableDictionary alloc] init];
    [paramDict setObject: [NSNumber numberWithFloat: latitude] forKey: @"latitude"];
    [paramDict setObject: [NSNumber numberWithFloat: longitude] forKey: @"longitude"];
    [paramDict setObject: [NSNumber numberWithFloat: distance] forKey: @"distance"];

    self = [super initWithDelegate: nil httpMethod: @"GET" baseUrl: @"places/search.json" paramDict: paramDict];
    if (self) {
        location = aLocation;
    }

    return self;
}


- (id) initWithPlaceName: (NSString *) aPlaceName {
    NSMutableDictionary *paramDict = [[NSMutableDictionary alloc] init];
    [paramDict setObject: aPlaceName forKey: @"q"];

    self = [super initWithDelegate: nil httpMethod: @"GET" baseUrl: @"places/search.json" paramDict: paramDict];
    if (self) {
        placeName = aPlaceName;
    }
    return self;
}


- (void) main {
    [super main];
}


- (void) requestDoneWithResponse: (CCResponse *) response {
    [super requestDoneWithResponse: response];

    NSArray *places = [response getObjectsOfType: [CCPlaceCocoafish class]];
    [_model notifyDelegates: @selector(searchSucceededWithPlaces:) object: places];
}

@end