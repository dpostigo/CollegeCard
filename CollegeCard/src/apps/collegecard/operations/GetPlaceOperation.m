//
// Created by dpostigo on 2/26/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "GetPlaceOperation.h"
#import "CCResponse.h"


@implementation GetPlaceOperation {
}


@synthesize placeId;


- (id) initWithPlaceId: (NSString *) aPlaceId {

    NSDictionary *paramDict = [NSDictionary dictionaryWithObjectsAndKeys: aPlaceId, @"place_id", nil];
    self = [super initWithDelegate: nil httpMethod: @"GET" baseUrl: @"places/show.json" paramDict: paramDict];
    if (self) {
        placeId = aPlaceId;
    }

    return self;
}


- (void) requestDoneWithResponse: (CCResponse *) response {
    [super requestDoneWithResponse: response];

    NSLog(@"response = %@", response);
    NSArray *places = [response getObjectsOfType: [CCPlaceCocoafish class]];
    _model.currentPlace = [places objectAtIndex: 0];

    if ([response.meta.status isEqualToString: @"ok"]) {
        [_model notifyDelegates: @selector(getPlaceOperationSucceeded) object: nil];
    } else {
    }
}

@end