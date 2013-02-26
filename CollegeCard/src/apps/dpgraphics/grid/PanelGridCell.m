//
// Created by dpostigo on 9/24/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "PanelGridCell.h"
#import "Panel.h"

@implementation PanelGridCell {

}

@synthesize panel;

- (id) initWithFrame: (CGRect) frame reuseIdentifier: (NSString *) reuseIdentifier {
    self = [super initWithFrame: frame reuseIdentifier: reuseIdentifier];
    if (self) {

        self.panel = [[Panel alloc] initWithFrame: CGRectMake(0, 0, PANEL_WIDTH, PANEL_WIDTH * 0.75)];

        self.contentView.backgroundColor = [UIColor clearColor];
        //[self.contentView addSubview: panel];

    }

    return self;
}

@end