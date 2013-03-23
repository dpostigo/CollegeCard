//
// Created by dpostigo on 3/11/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "UILabel+CustomLabel.h"


@implementation UILabel (CustomLabel)


- (void) customize {
    self.font = [UIFont fontWithName: @"Rockwell" size: self.font.pointSize];
}
@end