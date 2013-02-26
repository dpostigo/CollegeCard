//
// Created by dpostigo on 8/30/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "BasicLibrary.h"


@implementation BasicLibrary {
}


@synthesize delegates;


- (id) init {
    self = [super init];
    if (self) {
        self.delegates = [[NSMutableArray alloc] init];
    }

    return self;
}


- (void) subscribeDelegate: (id) aDelegate {
    [delegates addObject: aDelegate];
}


- (void) unsubscribeDelegate: (id) aDelegate {
    [delegates removeObject: aDelegate];
}


- (void) notifyDelegates: (SEL) aSelector object: (id) obj {
    for (id delegate in delegates) {
        if ([delegate respondsToSelector: aSelector]) {
            [delegate performSelectorOnMainThread: aSelector withObject: obj waitUntilDone: NO];
        }
    }
}


- (void) notifyDelegates: (SEL) aSelector object: (id) obj andObject: (id) obj2 {
    for (id delegate in delegates) {
        if ([delegate respondsToSelector: aSelector]) {
            [delegate performSelector: aSelector withObject: obj withObject: obj2];
        }
    }
}

@end