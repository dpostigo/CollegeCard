//
// Created by dpostigo on 3/19/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "LogoLabelButton.h"
#import "UIColor+Utils.h"


@implementation LogoLabelButton {
    UIView *plusView;
}


- (id) initWithCoder: (NSCoder *) aDecoder {
    self = [super initWithCoder: aDecoder];
    if (self) {



        UILabel *plusLabel = [[UILabel alloc] init];
        plusLabel.text = @"+";
        plusLabel.font = [UIFont fontWithName: @"Helvetica-Bold" size: 16.0];
        plusLabel.textColor = [UIColor colorWithString: @"ff9933"];
        plusLabel.backgroundColor = [UIColor clearColor];
        [plusLabel sizeToFit];


        plusView = [[UIView alloc] initWithFrame: plusLabel.bounds];
        plusView.backgroundColor = [UIColor clearColor];
        plusView.right = self.width;
        plusView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
        [self addSubview: plusView];


        [plusView addSubview: plusLabel];

    }

    return self;
}

@end