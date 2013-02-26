//
// Created by dpostigo on 2/24/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "User.h"


@implementation User {
}


@synthesize birthDate;


- (NSString *) firstName {
    if (_firstName == nil) return @"Joe";
    return _firstName;
}


- (NSString *) lastName {
    return _lastName;
}


@end