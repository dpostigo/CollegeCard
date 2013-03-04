//
// Created by dpostigo on 2/25/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "PlaceRowObject.h"


@implementation PlaceRowObject {
}


@synthesize place;


- (id) initWithPlace: (CCPlace *) aPlace {
    self = [super init];
    if (self) {
        place = aPlace;
    }

    return self;
}

@end