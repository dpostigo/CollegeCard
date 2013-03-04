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
@synthesize setAsCurrentPlace;


- (id) initWithPlaceId: (NSString *) aPlaceId {
    return [self initWithPlaceId: aPlaceId setAsCurrentPlace: YES];
}


- (id) initWithPlaceId: (NSString *) aPlaceId setAsCurrentPlace: (BOOL) aBoolean {
    NSDictionary *paramDict = [NSDictionary dictionaryWithObjectsAndKeys: aPlaceId, @"place_id", nil];
    self = [super initWithDelegate: nil httpMethod: @"GET" baseUrl: @"places/show.json" paramDict: paramDict];
    if (self) {
        placeId = aPlaceId;
        setAsCurrentPlace = aBoolean;
    }

    return self;
}


- (void) requestDoneWithResponse: (CCResponse *) response {
    [super requestDoneWithResponse: response];

    NSLog(@"response = %@", response);
    NSArray *places = [response getObjectsOfType: [CCPlace class]];
    CCPlace *place = [places objectAtIndex: 0];
    if (setAsCurrentPlace) {
        _model.currentPlace = place;
    }

    if ([response.meta.status isEqualToString: @"ok"]) {
        [_model notifyDelegates: @selector(getPlaceOperationSucceeded) object: nil];
        [_model notifyDelegates: @selector(getPlaceOperationSucceededWithPlace:) object: place];
    }
}

@end