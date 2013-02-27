//
// Created by dpostigo on 2/26/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "BlueButton.h"
#import "UIColor+Utils.h"


@implementation BlueButton {
}


- (id) initWithCoder: (NSCoder *) aDecoder {
    self = [super initWithCoder: aDecoder];
    if (self) {
        self.topColor = [UIColor colorWithString: @"00b0ff"];
        self.bottomColor = [UIColor colorWithString: @"038cd3"];

        self.borderColor = [UIColor colorWithString: @"196287"];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.shadowColor = [UIColor blackColor];
    }

    return self;
}


- (void) awakeFromNib {
    [super awakeFromNib];
    self.titleLabel.textColor = [UIColor whiteColor];
}


- (UIColor *) currentTitleColor {
    return [UIColor whiteColor];
}

@end