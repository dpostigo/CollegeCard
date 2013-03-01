//
// Created by dpostigo on 2/27/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "TempEvent.h"


@implementation TempEvent {
}


@synthesize name;
@synthesize startTime;
@synthesize endTime;


- (NSInteger) duration {
    return 60 * 60;
}

@end