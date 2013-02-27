//
// Created by dpostigo on 12/6/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <QuartzCore/QuartzCore.h>
#import "BasicWhiteView.h"
#import "UIColor+Utils.h"


@implementation BasicWhiteView {
}


- (void) create {
    self.backgroundColor = [UIColor colorWithString: WHITE_STRING];
    self.clipsToBounds = NO;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(0, 1);
    self.layer.shadowOpacity = 0.5;
    self.layer.shadowRadius = 1.0;
    self.layer.masksToBounds = NO;
    self.layer.borderColor = [UIColor whiteColor].CGColor;
    self.layer.borderWidth = 1.0;
    [self rasterize];
}

//
//- (void) awakeFromNib {
//    [super awakeFromNib];
//    NSLog(@"self = %@", self);
//    [self create];
//}


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