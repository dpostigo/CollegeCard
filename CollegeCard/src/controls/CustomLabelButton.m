//
// Created by dpostigo on 3/11/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "CustomLabelButton.h"
#import "UILabel+CustomLabel.h"


@implementation CustomLabelButton {
}


- (id) initWithCoder: (NSCoder *) aDecoder {
    self = [super initWithCoder: aDecoder];
    if (self) {
        [self.titleLabel customize];
    }

    return self;
}

@end