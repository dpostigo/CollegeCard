//
// Created by dpostigo on 3/3/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "BasicTableCell.h"


@interface SwitchCell : BasicTableCell {

    IBOutlet UISwitch *cellSwitch;
}


@property(nonatomic, strong) UISwitch *cellSwitch;

@end