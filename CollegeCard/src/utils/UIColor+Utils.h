//
// Created by dpostigo on 7/14/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

@interface UIColor (Utils)

+ (void) getRGBAComponents: (UIColor *) aColor forRed: (CGFloat) red g: (CGFloat) green b: (CGFloat) blue a: (CGFloat) alpha;
+ (void) getRGBComponents: (CGFloat[]) components forColor: (UIColor *) color;
+ (UIColor *)colorWithString:(NSString *)hexString;


@end