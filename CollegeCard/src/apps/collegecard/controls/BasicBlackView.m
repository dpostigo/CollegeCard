//
// Created by dpostigo on 3/5/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <QuartzCore/QuartzCore.h>
#import "BasicBlackView.h"


@implementation BasicBlackView {
}



- (void) create {

    self.backgroundColor = [UIColor colorWithWhite: 0.0 alpha: 0.4];
    self.layer.borderWidth = 1.0;
    self.layer.borderColor = [UIColor colorWithWhite: 0.5 alpha: 0.4].CGColor;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOpacity = 1.0;
    self.layer.shadowOffset = CGSizeMake(0, 1);
    self.layer.shadowRadius = 0;
    [self rasterize];
}


- (id) initWithCoder: (NSCoder *) aDecoder {
    self = [super initWithCoder: aDecoder];
    if (self) {
        [self create];
    }

    return self;
}


- (id) initWithFrame: (CGRect) frame {
    self = [super initWithFrame: frame];
    if (self) {
    [self create];
    }

    return self;
}

@end