//
// Created by dpostigo on 10/8/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "LineDrawerPoint.h"

@implementation LineDrawerPoint {
}

@synthesize aString;




- (id) init {
    self = [super init];
    if (self) {
    }

    return self;
}


- (id) initWithCoder: (NSCoder *) decoder {
    self = [super init];
    if (self) {
        NSLog(@" [decoder decodeObjectForKey: @'aString'] = %@",  [decoder decodeObjectForKey: @"aString"]);
        self.aString = [decoder decodeObjectForKey: @"aString"];
    }
    return self;
}


- (void) encodeWithCoder: (NSCoder *) encoder {
    [encoder encodeObject: aString forKey: @"aString"];
}

@end