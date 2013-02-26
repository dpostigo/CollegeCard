//
// Created by dpostigo on 12/18/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>


@interface NSString (Utils)


- (NSString *) trimWhitespace;
- (BOOL) containsString: (NSString *) substring;
- (BOOL) isNumber;
- (BOOL) allNumeric;

@end