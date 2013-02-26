//
// Created by dpostigo on 10/22/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "BasicSplitViewController.h"
#import "UIImage+Utils.h"

@implementation BasicSplitViewController {
}

- (id) initWithCoder: (NSCoder *) aDecoder {
    self = [super initWithCoder: aDecoder];
    if (self) {

     }

    return self;
}

- (void) viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage: [UIImage newImageFromResource: @"background-texture.png"]];

}

- (BOOL) shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation) toInterfaceOrientation {
    return YES;
}

@end