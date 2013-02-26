//
// Created by dpostigo on 2/24/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "LoginOperation.h"
#import "CCResponse.h"


@implementation LoginOperation {
}


@synthesize email;
@synthesize userPassword;


- (id) initWithEmail: (NSString *) anEmail userPassword: (NSString *) anUserPassword; {

    NSMutableDictionary *paramDict = [NSMutableDictionary dictionaryWithCapacity: 5];
    [paramDict setObject: anEmail forKey: @"login"];
    [paramDict setObject: anUserPassword forKey: @"password"];

    self = [super initWithDelegate: nil httpMethod: @"POST" baseUrl: @"users/login.json" paramDict: paramDict];
    if (self) {
        email = anEmail;
        userPassword = anUserPassword;
    }

    return self;
}


- (void) requestDoneWithResponse: (CCResponse *) response {
    [super requestDoneWithResponse: response];

    if ([response.meta.status isEqualToString: @"ok"]) {
        [_model notifyDelegates: @selector(loginSucceeded) object: nil];
    } else {
        NSLog(@"response.meta.message = %@", response.meta.message);
    }
}


- (void) requestFailedWithResponse: (CCResponse *) response {
    [super requestFailedWithResponse: response];

    NSLog(@"%s", __PRETTY_FUNCTION__);
    NSLog(@"response.meta.message = %@", response.meta.message);

    [_model notifyDelegates: @selector(loginFailedWithMessage:) object: response.meta.message];
}

@end