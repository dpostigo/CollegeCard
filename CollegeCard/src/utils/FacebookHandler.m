//
// Created by dpostigo on 1/3/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Accounts/Accounts.h>
#import "FacebookHandler.h"


@implementation FacebookHandler {
}


+ (void) saveFacebookAccountWithDataString: (NSString *) data {
    NSDictionary *dictionary = [self facebookDictionary: data];
    NSString *authToken = [dictionary objectForKey: @"oauth_token"];
    NSString *authTokenSecret = [dictionary objectForKey: @"oauth_token_secret"];
    [self saveFacebookAccountWithToken: authToken secret: authTokenSecret];
}

+ (void) removeFacebookAccounts {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    ACAccountStore *accountStore = [[ACAccountStore alloc] init];
    ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier: ACAccountTypeIdentifierFacebook];
    NSArray *accountsArray = [accountStore accountsWithAccountType: accountType];
    for (ACAccount *account in accountsArray) {
        [accountStore removeAccount: account withCompletionHandler: ^(BOOL success, NSError *error) {
        }];
    }
}




+ (void) saveFacebookAccountWithToken: (NSString *) token secret: (NSString *) secret {

    ACAccountStore *_store = [[ACAccountStore alloc] init];
    ACAccountCredential *credential = [[ACAccountCredential alloc] initWithOAuthToken: token tokenSecret: secret];
    ACAccountType *accountType = [_store accountTypeWithAccountTypeIdentifier: ACAccountTypeIdentifierFacebook];

    ACAccount *account = [[ACAccount alloc] initWithAccountType: accountType];
    account.credential = credential;

    [_store saveAccount: account withCompletionHandler: ^(BOOL success, NSError *error) {
        if (success) {
            NSLog(@"the account was saved!");
        }
        else {
            NSLog(@"the account was NOT saved");

            if ([[error domain] isEqualToString: ACErrorDomain]) {

                switch ([error code]) {
                    case ACErrorAccountMissingRequiredProperty:
                        NSLog(@"Account wasn't saved because "
                                "it is missing a required property.");
                        break;
                    case ACErrorAccountAuthenticationFailed:
                        NSLog(@"Account wasn't saved because "
                                "authentication of the supplied "
                                "credential failed.");
                        break;
                    case ACErrorAccountTypeInvalid:
                        NSLog(@"Account wasn't saved because "
                                "the account type is invalid.");
                        break;
                    case ACErrorAccountAlreadyExists:
                        NSLog(@"Account wasn't added because "
                                "it already exists.");

                        break;
                    case ACErrorAccountNotFound:
                        NSLog(@"Account wasn't deleted because"
                                "it could not be found.");
                        break;
                    case ACErrorPermissionDenied:
                        NSLog(@"Permission Denied");
                        break;
                    case ACErrorUnknown:
                    default:

                        NSLog(@"An unknown error occurred.");
                        break;
                }
            } else {
                NSLog(@"%@", [error localizedDescription]);
            }
        }
    }];

}



+ (NSDictionary *) facebookDictionary: (NSString *) data {
    NSArray *components = [data componentsSeparatedByString: @"&"];
    NSMutableDictionary *twitterData = [[NSMutableDictionary alloc] init];

    for (NSString *string in components) {
        NSArray *values = [string componentsSeparatedByString: @"="];
        [twitterData setObject: [values objectAtIndex: 1] forKey: [values objectAtIndex: 0]];
    }
    return twitterData;
}


@end