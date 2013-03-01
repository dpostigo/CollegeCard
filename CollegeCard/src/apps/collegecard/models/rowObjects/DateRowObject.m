//
// Created by dpostigo on 2/28/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "DateRowObject.h"


@implementation DateRowObject {
}


@synthesize startTime;
@synthesize endTime;
@synthesize date;


- (id) initWithStartTime: (NSDate *) aStartTime endTime: (NSDate *) anEndTime cellIdentifier: (NSString *) aCellIdentifier{
    self = [super init];
    if (self) {
        startTime = aStartTime;
        endTime = anEndTime;
        cellIdentifier = aCellIdentifier;
    }

    return self;
}


- (id) initWithDate: (NSDate *) aDate cellIdentifier: (NSString *) aCellIdentifier {
    self = [super init];
    if (self) {
        date = aDate;
        cellIdentifier = aCellIdentifier;
    }

    return self;
}


- (id) initWithTextLabel: (NSString *) aTextLabel date: (NSDate *) aDate cellIdentifier: (NSString *) aCellIdentifier {
    self = [super initWithTextLabel: aTextLabel];
    if (self) {
        date = aDate;
        cellIdentifier = aCellIdentifier;
    }

    return self;
}

@end