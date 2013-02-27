//
// Created by dpostigo on 2/26/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "UpdateUserOperation.h"
#import "CCResponse.h"


@implementation UpdateUserOperation {
}


@synthesize paramDict;



- (id) initWithParamDict: (NSMutableDictionary *) aParamDict {
    self = [super initWithDelegate: nil httpMethod: @"PUT" baseUrl: @"users/update.json" paramDict: aParamDict];
    if (self) {
        paramDict = aParamDict;
    }

    return self;
}


- (void) requestDoneWithResponse: (CCResponse *) response {
    [super requestDoneWithResponse: response];

    if ([response.meta.status isEqualToString: @"ok"]) {
        [_model notifyDelegates: @selector(userDidUpdate) object: nil];
    } else {
        NSLog(@"UpdateUserOperation failed.");
    }
}

@end