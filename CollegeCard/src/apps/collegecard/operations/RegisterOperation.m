//
// Created by dpostigo on 2/24/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "RegisterOperation.h"
#import "CCResponse.h"


#define RESPONSE_EMAIL_TAKEN @"Email is already taken"


@implementation RegisterOperation {
}


@synthesize email;
@synthesize userPassword;
@synthesize isMerchant;


- (id) initWithEmail: (NSString *) anEmail password: (NSString *) aPassword firstName: (NSString *) firstName lastName: (NSString *) lastName {
    return [self initWithEmail: anEmail password: aPassword firstName: firstName lastName: lastName isMerchant: NO];
}


- (id) initWithEmail: (NSString *) anEmail password: (NSString *) aPassword firstName: (NSString *) firstName lastName: (NSString *) lastName isMerchant: (BOOL) aIsMerchant {

    NSMutableDictionary *paramDict = [NSMutableDictionary dictionaryWithCapacity: 5];
    [paramDict setObject: anEmail forKey: @"email"];
    [paramDict setObject: firstName forKey: @"first_name"];
    [paramDict setObject: lastName forKey: @"last_name"];
    [paramDict setObject: aPassword forKey: @"password"];
    [paramDict setObject: aPassword forKey: @"password_confirmation"];

    NSMutableDictionary *customFields = [[NSMutableDictionary alloc] init];
    [customFields setObject: NO_COLLEGE_KEY forKey: @"college"];
    [customFields setObject: @"Your graduate date" forKey: @"graduationDate"];
    [customFields setObject: @"Your birth date" forKey: @"birthDate"];
    [customFields setObject: NO_MAJOR_KEY forKey: @"major"];
    [customFields setObject: @"Your gender" forKey: @"gender"];
    [customFields setObject: [NSNumber numberWithBool: aIsMerchant] forKey: @"isMerchant"];
    [paramDict setObject: customFields forKey: @"custom_fields"];

    self = [super initWithDelegate: nil httpMethod: @"POST" baseUrl: @"users/create.json" paramDict: paramDict];
    if (self) {
        NSLog(@"%s", __PRETTY_FUNCTION__);
        email = anEmail;
        userPassword = aPassword;
    }

    return self;
}


- (void) requestDoneWithResponse: (CCResponse *) response {
    [super requestDoneWithResponse: response];

    if ([response.meta.status isEqualToString: @"ok"]) {
        [_model notifyDelegates: @selector(registerSucceeded) object: nil];
        [_model notifyDelegates: @selector(registerSucceededWithUsername:andPassword:) object: username andObject: password];
    } else if ([response.meta.message isEqualToString: RESPONSE_EMAIL_TAKEN]) {
        [_model notifyDelegates: @selector(registerFailedWithMessage:) object: response.meta.message];
    }
}

@end