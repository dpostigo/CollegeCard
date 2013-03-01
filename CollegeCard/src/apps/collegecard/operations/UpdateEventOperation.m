//
// Created by dpostigo on 2/27/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "UpdateEventOperation.h"
#import "CCResponse.h"


@implementation UpdateEventOperation {
}


@synthesize paramDict;


- (id) initWithParamDict: (NSDictionary *) aParamDict {
    self = [super initWithDelegate: nil httpMethod: @"PUT" baseUrl: @"events/update.json" paramDict: aParamDict];
    if (self) {
        paramDict = aParamDict;
    }

    return self;
}


- (void) requestDoneWithResponse: (CCResponse *) response {
    [super requestDoneWithResponse: response];

    if ([response.meta.status isEqualToString: @"ok"]) {

        NSArray *events = [response getObjectsOfType: [CCEvent class]];
        CCEvent *event = [events objectAtIndex: 0];
        [_model notifyDelegates: @selector(eventDidUpdate:) object: event];
    } else {

        NSLog(@"Problem.");
    }
}

@end