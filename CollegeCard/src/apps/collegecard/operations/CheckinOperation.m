//
// Created by dpostigo on 2/25/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "CheckinOperation.h"
#import "CCResponse.h"


@implementation CheckinOperation {
}


@synthesize place;


- (id) initWithPlace: (CCPlaceCocoafish *) aPlace {
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionaryWithCapacity: 3];
    [paramDict setObject: aPlace.objectId forKey: @"place_id"]; // or event_id
    self = [super initWithDelegate: nil httpMethod: @"POST" baseUrl: @"checkins/create.json" paramDict: paramDict];
    if (self) {
        place = aPlace;
    }

    return self;
}


- (void) requestDoneWithResponse: (CCResponse *) response {
    [super requestDoneWithResponse: response];

    [_model notifyDelegates: @selector(checkinSucceeded) object: nil];
}

@end