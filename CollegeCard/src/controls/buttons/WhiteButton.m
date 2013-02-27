//
// Created by dpostigo on 2/25/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "WhiteButton.h"


@implementation WhiteButton {
}


- (id) initWithCoder: (NSCoder *) aDecoder {
    self = [super initWithCoder: aDecoder];
    if (self) {

        self.borderColor = [UIColor colorWithWhite: 0.9 alpha: 1.0];
        self.topColor = [UIColor whiteColor];
        self.bottomColor = [UIColor colorWithWhite: 0.9 alpha: 1.0];
        self.innerGlow = [UIColor colorWithWhite: 1.0 alpha: 0.5];
    }

    return self;
}

@end