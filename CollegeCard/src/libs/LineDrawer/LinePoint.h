//
// Created by dpostigo on 9/21/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "LineDrawerStyle.h"

@interface LinePoint : NSObject <NSCoding> {

    CGPoint position;
    CGFloat width;

    BOOL startingPoint;
    BOOL endingPoint;
    BOOL isErasure;

    LineDrawerStyle lineStyle;

}

@property(nonatomic) CGPoint position;
@property(nonatomic) CGFloat width;
@property(nonatomic) BOOL startingPoint;
@property(nonatomic) BOOL endingPoint;
@property(nonatomic) BOOL isErasure;
@property(nonatomic) LineDrawerStyle lineStyle;

@end