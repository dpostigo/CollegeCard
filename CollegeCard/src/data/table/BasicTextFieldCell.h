//
// Created by dpostigo on 2/24/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "BasicTableCell.h"


@interface BasicTextFieldCell : BasicTableCell {

    IBOutlet UITextField *textField;
}


@property(nonatomic, strong) UITextField *textField;

@end