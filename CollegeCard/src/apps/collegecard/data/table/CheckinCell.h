//
// Created by dpostigo on 2/28/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "BasicTableCell.h"


@interface CheckinCell : BasicTableCell {
    IBOutlet UILabel *timeLabel;
}


@property(nonatomic, strong) UILabel *timeLabel;

@end