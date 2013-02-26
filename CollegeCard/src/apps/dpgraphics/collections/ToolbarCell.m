//
// Created by dpostigo on 10/10/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "ToolbarCell.h"

@implementation ToolbarCell {
}

@synthesize isDisabled;
@synthesize innerView;

#define NORMAL 0.5
#define ACTIVE 0.95
#define HOVER 1.0
#define DISABLED 0.2


- (void) updateAlphas {

    if (self.isDisabled) {
        self.innerView.alpha = 0.2;
    }

    else if (self.isHighlighted) {
        self.innerView.alpha = 1.0;
    }

    else if (self.isSelected) {
        self.innerView.alpha = 0.95;
    }

    else {
        self.innerView.alpha = 0.6;
    }

}

- (void) setSelected: (BOOL) selected {
    [super setSelected: selected];

    [self updateAlphas];
}

- (void) setIsDisabled: (BOOL) isDisabled1 {
    isDisabled = isDisabled1;
    [self updateAlphas];
}


- (void) layoutSubviews {
    [super layoutSubviews];
    [self updateAlphas];
}


@end