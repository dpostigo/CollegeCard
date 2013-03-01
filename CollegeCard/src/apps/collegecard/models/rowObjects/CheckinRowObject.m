//
// Created by dpostigo on 2/28/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "CheckinRowObject.h"


@implementation CheckinRowObject {
}


@synthesize checkIn;


- (id) initWithCheckIn: (CCCheckin *) aCheckIn {
    self = [super init];
    if (self) {
        checkIn = aCheckIn;
    }

    return self;
}







@end