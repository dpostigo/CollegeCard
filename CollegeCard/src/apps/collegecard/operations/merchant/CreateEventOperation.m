//
// Created by dpostigo on 2/27/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "CreateEventOperation.h"
#import "CCResponse.h"


@implementation CreateEventOperation {
}


@synthesize tempEvent;


- (id) initWithTempEvent: (TempEvent *) aTempEvent {

    _model = [Model sharedModel];
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionaryWithCapacity: 1];
    [paramDict setObject: aTempEvent.name forKey: @"name"];
    [paramDict setObject: _model.currentUser.placeId forKey: @"place_id"];
    [paramDict setObject: aTempEvent.startTime forKey: @"start_time"];
    [paramDict setObject: aTempEvent.endTime forKey: @"end_time"];
    [paramDict setObject: [NSNumber numberWithInteger: aTempEvent.duration] forKey: @"duration"];

    NSDictionary *customFields = [NSDictionary dictionaryWithObject: [NSNumber numberWithBool: NO] forKey: @"isPublished"];
    [paramDict setObject: customFields forKey: @"custom_data_fields"];
    self = [super initWithDelegate: nil httpMethod: @"POST" baseUrl: @"events/create.json" paramDict: paramDict];
    if (self) {
        tempEvent = aTempEvent;
    }

    return self;
}


- (void) requestDoneWithResponse: (CCResponse *) response {
    [super requestDoneWithResponse: response];

    if ([response.meta.status isEqualToString: @"ok"]) {
        NSArray *events = [response getObjectsOfType: [CCEvent class]];
        CCEvent *event = [events objectAtIndex: 0];
        [_model notifyDelegates: @selector(createEventSucceeded:forTempEvent:) object: event andObject: tempEvent];
    }
}

@end