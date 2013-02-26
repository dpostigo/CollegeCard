//
// Created by dpostigo on 2/24/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "BasicCocoafishOperation.h"


@implementation BasicCocoafishOperation {
}


- (void) main {
    _model = [Model sharedModel];
    [super main];
}


- (void) requestDone: (CCRequest *) origRequest {
    [super requestDone: origRequest];
}

@end