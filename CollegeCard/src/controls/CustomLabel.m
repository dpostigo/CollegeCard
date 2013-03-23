//
// Created by dpostigo on 3/5/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "CustomLabel.h"
#import "UILabel+CustomLabel.h"


@implementation CustomLabel {
}


- (id) initWithCoder: (NSCoder *) aDecoder {
    self = [super initWithCoder: aDecoder];
    if (self) {
        [self customize];
    }

    return self;
}



@end