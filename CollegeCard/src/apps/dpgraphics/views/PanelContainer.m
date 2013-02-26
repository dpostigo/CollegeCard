//
// Created by dpostigo on 9/18/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "PanelContainer.h"
#import "Panel.h"

@implementation PanelContainer {

}

@synthesize scrollView;

- (id) initWithFrame: (CGRect) frame {
    self = [super initWithFrame: frame];
    if (self) {

        self.scrollView = [[UIScrollView alloc] initWithFrame: self.frame];

    }

    return self;
}


- (void) addPanel {

}


- (void) insertPanel: (Panel *) panel atIndex: (NSInteger) index {

}

@end