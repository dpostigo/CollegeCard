//
// Created by dpostigo on 9/24/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "AQGridViewCell.h"
#import "Panel.h"

@interface PanelGridCell : AQGridViewCell {
    Panel *panel;

}

@property(nonatomic, strong) Panel *panel;

@end