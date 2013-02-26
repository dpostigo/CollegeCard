//
// Created by dpostigo on 1/3/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Accounts/Accounts.h>
#import "SocialHandler.h"
#import "TwitterHandler.h"
#import "FacebookHandler.h"


@implementation SocialHandler {
}


+ (void) saveFacebookAccountWithToken: (NSString *) token secret: (NSString *) secret {

    [FacebookHandler saveFacebookAccountWithToken: token secret: secret];

}

+ (void) saveTwitterAccountWithDataString: (NSString *) data {
    [TwitterHandler saveTwitterAccountWithDataString: data];
}

+ (void) removeTwitterAccounts {
    [TwitterHandler removeTwitterAccounts];
}

@end