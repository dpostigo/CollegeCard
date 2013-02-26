//
// Created by dpostigo on 1/3/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>


@interface TwitterHandler : NSObject


+ (void) saveTwitterAccountWithDataString: (NSString *) data;
+ (void) removeTwitterAccounts;

@end