//
// Created by dpostigo on 7/22/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <CoreGraphics/CoreGraphics.h>
#import "HouseholdButton.h"
#import "UIColor+Utils.h"


@implementation HouseholdButton {

}

@synthesize text;

- (id) init {
    return [self initWithFrame: CGRectMake(0, 0, 200, 46)];
}

- (void) initialization {
    self.backgroundColor = [UIColor clearColor];
    [self setTitleColor: [UIColor whiteColor] forState: UIControlStateNormal];
    [self setTitleColor: [UIColor whiteColor] forState: UIControlStateSelected];
    [self setTitleColor: [UIColor colorWithString: LIGHT_GREY] forState: UIControlStateHighlighted];

    [self setDefaultImage];
    self.height = 46;
    self.titleLabel.frame = self.frame;
    self.titleLabel.font = [UIFont boldSystemFontOfSize: 15.0];

}


- (id) initWithFrame: (CGRect)frame {
    self = [super initWithFrame: frame];
    if (self) {
        [self initialization];
    }

    return self;
}


- (void) awakeFromNib {
    [super awakeFromNib];
    [self initialization];
}

- (void) setText: (NSString *) text1 {
    if (text != text1) {
        text = text1;
        [self setTitle: text forState: UIControlStateNormal];
    }
}

- (void) setImage: (UIImage *) image {
    [self setBackgroundImage: image forState: UIControlStateNormal];
    [self setBackgroundImage: image forState: UIControlStateSelected];

}

- (void) setDefaultImage {

    UIImage *normal = [[UIImage imageNamed: @"blue-button-bg.png"] resizableImageWithCapInsets: UIEdgeInsetsMake(23, 23, 23, 23)];
    [self setBackgroundImage: normal forState: UIControlStateNormal];
    [self setBackgroundImage: normal forState: UIControlStateSelected];

    UIImage *highlighted = [[UIImage imageNamed: @"blue-button-bg-highlighted.png"] resizableImageWithCapInsets: UIEdgeInsetsMake(23, 23, 23, 23)];
    [self setBackgroundImage: highlighted forState: UIControlStateHighlighted];

}

@end