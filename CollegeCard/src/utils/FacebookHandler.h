//
// Created by dpostigo on 1/3/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>


@interface FacebookHandler : NSObject


+ (void) saveFacebookAccountWithDataString: (NSString *) data;
+ (void) removeFacebookAccounts;
+ (void) saveFacebookAccountWithToken: (NSString *) token secret: (NSString *) secret;

@end