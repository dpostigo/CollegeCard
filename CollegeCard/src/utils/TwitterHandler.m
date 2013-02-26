//
// Created by dpostigo on 1/3/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Accounts/Accounts.h>
#import "TwitterHandler.h"


@implementation TwitterHandler {
}



+ (void) saveTwitterAccountWithDataString: (NSString *) data {
    NSDictionary *twitterDictionary = [self twitterDictionary: data];
    NSString *authToken = [twitterDictionary objectForKey: @"oauth_token"];
    NSString *authTokenSecret = [twitterDictionary objectForKey: @"oauth_token_secret"];
    [self saveTwitterAccountWithToken: authToken secret: authTokenSecret];
}

+ (void) removeTwitterAccounts {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    ACAccountStore *accountStore = [[ACAccountStore alloc] init];
    ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier: ACAccountTypeIdentifierTwitter];
    NSArray *accountsArray = [accountStore accountsWithAccountType: accountType];
    for (ACAccount *twitterAccount in accountsArray) {
        [accountStore removeAccount: twitterAccount withCompletionHandler: ^(BOOL success, NSError *error) {
        }];
    }
}




+ (void) saveTwitterAccountWithToken: (NSString *) token secret: (NSString *) secret {

    ACAccountStore *_store = [[ACAccountStore alloc] init];
    ACAccountCredential *credential = [[ACAccountCredential alloc] initWithOAuthToken: token tokenSecret: secret];
    ACAccountType *twitterAcctType = [_store accountTypeWithAccountTypeIdentifier: ACAccountTypeIdentifierTwitter];

    ACAccount *account = [[ACAccount alloc] initWithAccountType: twitterAcctType];
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



+ (NSDictionary *) twitterDictionary: (NSString *) data {
    NSArray *components = [data componentsSeparatedByString: @"&"];
    NSMutableDictionary *twitterData = [[NSMutableDictionary alloc] init];

    for (NSString *string in components) {
        NSArray *values = [string componentsSeparatedByString: @"="];
        [twitterData setObject: [values objectAtIndex: 1] forKey: [values objectAtIndex: 0]];
    }
    return twitterData;
}


@end