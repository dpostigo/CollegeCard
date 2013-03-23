//
// Created by dpostigo on 12/18/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "NSString+Utils.h"


@implementation NSString (Utils)


- (NSString *) trimWhitespace {
    NSString *trimmedString = [self stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return trimmedString;
}


- (BOOL) containsString: (NSString *) substring {
    NSRange range = [self rangeOfString : substring];
    BOOL found = (range.location != NSNotFound);
    return found;
}


- (BOOL) isNumber {
    NSCharacterSet *nonNumbers = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    NSRange r = [self rangeOfCharacterFromSet: nonNumbers];
    return r.location == NSNotFound;
}


- (BOOL) allNumeric {

    NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString: @"0123456789"];
    for (int i = 0; i < [self length]; i++) {
        unichar c = [self characterAtIndex: i];
        if (![myCharSet characterIsMember: c]) {
            return NO;
        }
    }
    return YES;
}


- (BOOL) isValidEmail {

    if (![self containsString: @"@"]) {
        return NO;
    }

    if (![self containsString: @"."]) {

        return NO;
    }
    return YES;
}

@end