//
// Created by dpostigo on 2/26/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "EventRowObject.h"


@implementation EventRowObject {
}


@synthesize event;


- (id) initWithEvent: (CCEvent *) anEvent {
    self = [super init];
    if (self) {
        event = anEvent;
    }

    return self;
}


- (id) initWithEvent: (CCEvent *) anEvent cellIdentifier: (NSString *) aCellIdentifier {
    self = [super init];
    if (self) {
        event = anEvent;
        cellIdentifier = aCellIdentifier;
    }

    return self;
}

@end