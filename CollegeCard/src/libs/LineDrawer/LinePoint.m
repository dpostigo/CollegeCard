//
// Created by dpostigo on 9/21/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "LinePoint.h"

@implementation LinePoint

@synthesize position;
@synthesize width;
@synthesize startingPoint;
@synthesize endingPoint;
@synthesize isErasure;
@synthesize lineStyle;


- (id) initWithCoder: (NSCoder *) aDecoder {

    self = [super init];
    if (self) {

        self.position = [aDecoder decodeCGPointForKey: @"position"];
        self.width = [aDecoder decodeFloatForKey: @"width"];
        self.startingPoint = [aDecoder decodeBoolForKey: @"startingPoint"];
        self.endingPoint = [aDecoder decodeBoolForKey: @"endingPoint"];
        self.isErasure = [aDecoder decodeBoolForKey: @"isErasure"];
        self.lineStyle = [self lineStyleForInt: [aDecoder decodeIntForKey: @"lineStyle"]];
    }

    return self;
}


- (void) encodeWithCoder: (NSCoder *) aCoder {
    [aCoder encodeCGPoint: position forKey: @"position"];
    [aCoder encodeFloat: width forKey: @"width"];
    [aCoder encodeBool: startingPoint forKey: @"startingPoint"];
    [aCoder encodeBool: endingPoint forKey: @"endingPoint"];
    [aCoder encodeBool: isErasure forKey: @"isErasure"];

    [aCoder encodeInt: [self intForLineStyle: lineStyle] forKey: @"lineStyle"];
}


- (LineDrawerStyle) lineStyleForInt: (int) intValue {

    LineDrawerStyle aLineStyle = LineDrawerStyleUndefined;

    if (intValue >= 1 && intValue <= 2)
        aLineStyle = (LineDrawerStyle) intValue;

    return aLineStyle;
}


- (int) intForLineStyle: (LineDrawerStyle) aLineStyle {
    int value = aLineStyle;
    return value;
}


/*
- (NSString *) stringForLineStyle: (LineDrawerStyle) aLineStyle {

    NSString *result = nil;
    switch (aLineStyle) {
        case LineDrawerStyleThin :
            result = @"Thin";
            break;
        case LineDrawerStyleThick :
            result = @"Thick";
            break;
        case LineDrawerStyleThinRetina :
            result = @"ThinRetina";
            break;
        case LineDrawerStyleThickRetina :
            result = @"ThickRetina";
            break;
        case LineDrawerStyleSuperThick :
            result = @"SuperThick";
            break;
        case LineDrawerStyleMessy :
            result = @"Messy";
            break;

        case LineDrawerStyleEraser :
            result = @"Eraser";
            break;
    }

    return [NSString stringWithFormat: @"%@", result];
}
*/

@end