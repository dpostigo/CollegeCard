//
// Created by dpostigo on 2/28/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "BasicTableCell.h"


@interface DateCell : BasicTableCell {

    IBOutlet UILabel *startTimeLabel;
    IBOutlet UILabel *endTimeLabel;
}


@property(nonatomic, strong) UILabel *startTimeLabel;
@property(nonatomic, strong) UILabel *endTimeLabel;

@end