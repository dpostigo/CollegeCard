//
// Created by dpostigo on 9/20/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "Model.h"
#import "Cocoafish.h"


@implementation Model {
}


@synthesize currentPlace;


+ (Model *) sharedModel {
    static Model *_instance = nil;

    @synchronized (self) {
        if (_instance == nil) {
            _instance = [[self alloc] init];
        }
    }

    return _instance;
}


- (id) init {
    self = [super init];
    if (self) {
    }

    return self;
}


- (BOOL) isLoggedIn {
    CCUser *user = [[Cocoafish defaultCocoafish] getCurrentUser];
    return (user != nil);
}


- (CCUser *) currentUser {
    return [[Cocoafish defaultCocoafish] getCurrentUser];
}
@end