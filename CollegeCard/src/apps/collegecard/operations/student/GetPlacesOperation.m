//
// Created by dpostigo on 3/3/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "GetPlacesOperation.h"


@implementation GetPlacesOperation {
}


@synthesize placeIds;


- (id) initWithPlaceIds: (NSArray *) aPlaceIds {
    NSDictionary *paramDict = [NSDictionary dictionaryWithObjectsAndKeys: aPlaceIds, @"place_ids[]", nil];
    self = [super initWithDelegate: nil httpMethod: @"GET" baseUrl: @"places/show.json" paramDict: paramDict];
    if (self) {
        placeIds = aPlaceIds;
    }

    return self;
}


- (void) requestDoneWithResponse: (CCResponse *) response {
    [super requestDoneWithResponse: response];
    NSLog(@"%s", __PRETTY_FUNCTION__);

    NSLog(@"response.meta.status = %@", response.meta.status);

    NSArray *places = [response getObjectsOfType: [CCPlace class]];

    if ([response.meta.status isEqualToString: @"ok"]) {
        [_model notifyDelegates: @selector(getPlacesSucceeded:) object: places];
    }
}

@end