//
// Created by dpostigo on 2/28/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "DeleteEventOperation.h"


@implementation DeleteEventOperation {
}


@synthesize eventId;


- (id) initWithEventId: (NSString *) anEventId {
    NSDictionary *paramDict = [NSDictionary dictionaryWithObject: anEventId forKey: @"event_id"];
    self = [super initWithDelegate: nil httpMethod: @"DELETE" baseUrl: @"events/delete.json" paramDict: paramDict];
    if (self) {
        eventId = anEventId;
    }

    return self;
}
@end