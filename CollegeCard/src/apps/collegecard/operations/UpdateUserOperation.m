//
// Created by dpostigo on 2/26/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "UpdateUserOperation.h"
#import "CCResponse.h"


@implementation UpdateUserOperation {
}


@synthesize paramDict;


- (id) initWithParamDict: (NSDictionary *) aParamDict {
    self = [super initWithDelegate: nil httpMethod: @"PUT" baseUrl: @"users/update.json" paramDict: aParamDict];
    if (self) {
        paramDict = aParamDict;
    }
    return self;
}


- (void) requestDoneWithResponse: (CCResponse *) response {
    [super requestDoneWithResponse: response];

    if ([response.meta.status isEqualToString: @"ok"]) {
        [_model notifyDelegates: @selector(userDidUpdate) object: nil];

        [self handleDictionaryKeys: paramDict];
    } else {
        NSLog(@"UpdateUserOperation failed.");
    }
}


- (void) handleDictionaryKeys: (NSDictionary *) dictionary {

    NSArray *keys = [dictionary allKeys];
    for (NSString *key in keys) {
        [_model notifyDelegates: @selector(updateUserForKey:) object: key];

        if ([key isEqualToString: @"custom_fields"]) {
            NSDictionary *customFields = [dictionary objectForKey: key];
            [self handleDictionaryKeys: customFields];
        } else {
            id value = [dictionary objectForKey: key];
            if ([value isKindOfClass: [NSString class]]) {
                NSString *string = value;
                [_model notifyDelegates: @selector(updatedUserForKey:string:) object: key andObject: string];
            } else {
                [_model notifyDelegates: @selector(updatedUserForKey:object:) object: key andObject: value];
            }
        }
    }
}

@end