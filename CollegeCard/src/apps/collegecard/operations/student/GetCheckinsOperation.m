//
// Created by dpostigo on 2/28/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "GetCheckinsOperation.h"
#import "CCWhere.h"
#import "CCResponse.h"
#import "CCCheckin.h"


@implementation GetCheckinsOperation {
}


@synthesize userId;


- (id) initWithUserId: (NSString *) anUserId {

    //    CCWhere *where = [[CCWhere alloc] init];
    //    [where fieldName: @"coordinates" nearLat: 37.12 nearLng: -122.23 maxDistanceMi: 5.0];
    NSMutableDictionary *paramDict = [[NSMutableDictionary alloc] init];
    [paramDict setObject: anUserId forKey: @"user_id"];

    self = [super initWithDelegate: nil httpMethod: @"GET" baseUrl: @"checkins/query.json" paramDict: paramDict];

    if (self) {
        userId = anUserId;
    }

    return self;
}


- (void) requestDoneWithResponse: (CCResponse *) response {
    [super requestDoneWithResponse: response];

    NSArray *checkins = [response getObjectsOfType: [CCCheckin class]];
    [_model notifyDelegates: @selector(getCheckinsSucceeded:) object: checkins];

    if ([userId isEqualToString: _model.currentUser.objectId]) {
        _model.currentUser.checkins = checkins;
    }
}

@end