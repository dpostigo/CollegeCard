//
// Created by dpostigo on 12/5/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "TextField.h"
#import "BasicTableCell.h"

@interface LoginCell : BasicTableCell {

    IBOutlet TextField *textField;
}


@property(nonatomic, strong) TextField *textField;

@end