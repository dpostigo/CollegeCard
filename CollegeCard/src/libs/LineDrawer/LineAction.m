//
// Created by dpostigo on 10/10/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "LineAction.h"

@implementation LineAction {
}

@synthesize type;
@synthesize linePoints;


- (id) initWithActionType: (LineActionType) anActionType {
    self = [super init];
    if (self) {
        type = anActionType;
        self.linePoints = [[NSMutableArray alloc] init];
    }

    return self;
}


- (void) encodeWithCoder: (NSCoder *) encoder {
    [encoder encodeInt: type forKey: @"type"];
    [encoder encodeObject: linePoints forKey: @"linePoints"];
}


- (id) initWithCoder: (NSCoder *) decoder {
    self = [super init];
    if (self) {
        self.type = (LineActionType) [decoder decodeIntForKey: @"type"];
        self.linePoints = [[NSMutableArray alloc] init];

        NSArray *pointsArray = [decoder decodeObjectForKey: @"linePoints"];
        [linePoints addObjectsFromArray: pointsArray];
    }

    return self;


}

@end