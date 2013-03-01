//
// Created by dpostigo on 2/24/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "BasicCocoafishOperation.h"
#import "CCResponse.h"


@implementation BasicCocoafishOperation {
}


- (void) main {
    _model = [Model sharedModel];
    [super main];
}


- (void) requestDoneWithResponse: (CCResponse *) response {
    [super requestDoneWithResponse: response];

    if (![response.meta.status isEqualToString: @"ok"]) {
        NSLog(@"%s - PROBLEM!", __PRETTY_FUNCTION__);
        return;
    }
}


- (void) requestFailedWithResponse: (CCResponse *) response {
    [super requestFailedWithResponse: response];
    NSLog(@"%s", __PRETTY_FUNCTION__);

    NSLog(@"response.meta.status = %@", response.meta.status);
    NSLog(@"response.meta.message = %@", response.meta.message);
}

@end