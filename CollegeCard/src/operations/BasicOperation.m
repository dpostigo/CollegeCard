//
// Created by dpostigo on 7/18/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "BasicOperation.h"
#import "Model.h"


@implementation BasicOperation {
}

@synthesize delegate;

- (id) init {
    self = [super init];
    if (self) {
        _model = [Model sharedModel];
    }

    return self;
}

- (void) main {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}



@end