//
// Created by dpostigo on 2/26/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "GetMerchantEventsOperation.h"
#import "CCWhere.h"
#import "CCResponse.h"
#import "CCEvent.h"


@implementation GetMerchantEventsOperation {
}


@synthesize placeId;


- (id) initWithPlaceId: (NSString *) aPlaceId {

    CCWhere *where = [[CCWhere alloc] init];
    [where fieldName: aPlaceId equalTo: @"place_id"];
    NSDictionary *paramDict = [NSDictionary dictionaryWithObjectsAndKeys: where, @"where", nil];

    self = [super initWithDelegate: self httpMethod: @"GET" baseUrl: @"events/search.json" paramDict: paramDict];
    if (self) {
        placeId = aPlaceId;
    }

    return self;
}


- (void) requestDoneWithResponse: (CCResponse *) response {
    [super requestDoneWithResponse: response];

    NSArray *events = [response getObjectsOfType: [CCEvent class]];
    if ([response.meta.status isEqualToString: @"ok"]) {
        [_model notifyDelegates: @selector(getMerchantEventsSucceededWithEvents:) object: events];
    }
}

@end