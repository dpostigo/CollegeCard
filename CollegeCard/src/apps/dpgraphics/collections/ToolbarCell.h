//
// Created by dpostigo on 10/10/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "BasicCollectionCell.h"

@interface ToolbarCell : BasicCollectionCell {

    IBOutlet UIView *innerView;

    BOOL isDisabled;
}

@property(nonatomic, strong) UIView *innerView;
@property(nonatomic) BOOL isDisabled;
- (void) updateAlphas;

@end