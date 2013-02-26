//
// Created by dpostigo on 2/24/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "LogoutOperation.h"


@implementation LogoutOperation {
}


- (id) initWithDefault {
    return [self initWithDelegate: nil httpMethod: @"GET" baseUrl: @"users/logout.json" paramDict: nil];
}

@end