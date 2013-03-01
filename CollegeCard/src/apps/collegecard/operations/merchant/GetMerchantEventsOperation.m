//
// Created by dpostigo on 2/26/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <CoreLocation/CoreLocation.h>
#import "GetMerchantEventsOperation.h"


@implementation GetMerchantEventsOperation


@synthesize placeId;
@synthesize location;
@synthesize distance;


- (id) initWithPlaceId: (NSString *) aPlaceId {

    //    CCWhere *where = [[CCWhere alloc] init];
    //    [where fieldName: aPlaceId equalTo: @"place_id"];
    //
    //    NSDictionary *paramDict = [NSDictionary dictionaryWithObjectsAndKeys: where, @"where", nil];

    NSMutableDictionary *paramDict = [NSMutableDictionary dictionaryWithCapacity: 2];
    [paramDict setObject: aPlaceId forKey: @"place_id"];
    self = [super initWithDelegate: self httpMethod: @"GET" baseUrl: @"events/search.json" paramDict: paramDict];
    if (self) {
        placeId = aPlaceId;
    }

    return self;
}


- (id) initWithLocation: (CLLocation *) aLocation distance: (float) aDistance {
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionaryWithCapacity: 2];
    [paramDict setObject: [NSNumber numberWithFloat: (float) location.coordinate.longitude] forKey: @"latitude"];
    [paramDict setObject: [NSNumber numberWithFloat: (float) location.coordinate.latitude] forKey: @"longitude"];
    [paramDict setObject: [NSNumber numberWithFloat: aDistance] forKey: @"distance"];

    self = [super initWithDelegate: self httpMethod: @"GET" baseUrl: @"events/search.json" paramDict: paramDict];
    if (self) {
        location = aLocation;
        distance = aDistance;
    }

    return self;
}


- (void) requestDoneWithResponse: (CCResponse *) response {
    [super requestDoneWithResponse: response];

    NSLog(@"%s", __PRETTY_FUNCTION__);

    NSLog(@"MerchantEventsSearch = %@", (placeId != nil ? @"Search by placeId": @"Search by Location"));

    NSArray *events = [response getObjectsOfType: [CCEvent class]];
    if ([response.meta.status isEqualToString: @"ok"]) {

        NSLog(@"events = %@", events);
        if (events == nil) events = [NSArray array];

        if (placeId != nil) {
            [_model notifyDelegates: @selector(getMerchantEventsSucceededWithEvents:forPlaceId:) object: events andObject: placeId];
        } else if (location != nil) {
            [_model notifyDelegates: @selector(getMerchantEventsSucceededWithEvents:forLocation:) object: events andObject: location];
        }
        [_model notifyDelegates: @selector(getMerchantEventsSucceededWithEvents:) object: events];
    }
}

@end