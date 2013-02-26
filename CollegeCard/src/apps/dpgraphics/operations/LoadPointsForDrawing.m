//
// Created by dpostigo on 10/16/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "LoadPointsForDrawing.h"
#import "Drawing.h"

@implementation LoadPointsForDrawing {
}

@synthesize drawing;

- (id) initWithDrawing: (Drawing *) aDrawing {
    self = [super init];
    if (self) {
        drawing = aDrawing;
    }

    return self;
}



@end