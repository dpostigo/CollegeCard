//
// Created by dpostigo on 3/19/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "OrangeButton.h"
#import "UIColor+Utils.h"


@implementation OrangeButton {
}


- (id) initWithCoder: (NSCoder *) aDecoder {
    self = [super initWithCoder: aDecoder];
    if (self) {
        self.topColor = [UIColor colorWithString: @"ffc48a"];
        self.bottomColor = [UIColor colorWithString: @"ff8c00"];
        self.outerBorderColor = [UIColor colorWithString: @"ec8200"];
        [self redraw];
    }

    return self;
}

@end