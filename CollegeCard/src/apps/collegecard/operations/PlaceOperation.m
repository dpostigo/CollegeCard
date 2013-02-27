//
// Created by dpostigo on 2/25/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "PlaceOperation.h"
#import "CCResponse.h"


@implementation PlaceOperation {
}


@synthesize paramDict;


- (id) initWithParamDict: (NSMutableDictionary *) aParamDict {
    self = [super initWithDelegate: nil httpMethod: @"POST" baseUrl: @"places/create.json" paramDict: aParamDict];
    if (self) {
        paramDict = aParamDict;
    }

    return self;
}


- (void) requestDoneWithResponse: (CCResponse *) response {
    [super requestDoneWithResponse: response];

    NSArray *places = [response getObjectsOfType: [CCPlaceCocoafish class]];
    _model.currentPlace = [places objectAtIndex: 0];

    if ([response.meta.status isEqualToString: @"ok"]) {
        [_model notifyDelegates: @selector(merchantSignupSucceeded) object: nil];
    }
}

@end