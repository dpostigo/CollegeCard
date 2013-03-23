//
// Created by dpostigo on 3/19/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "BlueLayerButton.h"
#import "UIColor+Utils.h"


@implementation BlueLayerButton {
}


- (id) initWithCoder: (NSCoder *) aDecoder {
    self = [super initWithCoder: aDecoder];
    if (self) {

        self.topColor = [UIColor colorWithString: @"00b0ff"];
        self.bottomColor = [UIColor colorWithString: @"038cd3"];

        self.outerBorderColor = [UIColor colorWithString: @"196287"];
        self.backgroundColor = [UIColor blueColor];
        [self redraw];
    }

    return self;
}

@end