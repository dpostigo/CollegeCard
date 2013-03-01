//
// Created by dpostigo on 12/6/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "BasicTableCell.h"


@implementation BasicTableCell {
}


@synthesize __textLabel;
@synthesize __detailTextLabel;
@synthesize imageView;
@synthesize button;
@synthesize captionLabel;


- (id) initWithCoder: (NSCoder *) aDecoder {
    self = [super initWithCoder: aDecoder];
    if (self) {
    self.textLabel.highlightedTextColor = [UIColor grayColor];
    }

    return self;
}


- (UILabel *) detailTextLabel {
    return __detailTextLabel;
}


- (UILabel *) textLabel {
    return __textLabel;
}


- (void) awakeFromNib {
    [super awakeFromNib];
    self.backgroundView = [[UIView alloc] init];
}


- (void) layoutSubviews {
    [super layoutSubviews];

    self.selectedBackgroundView.height = self.height - 5;
}

@end