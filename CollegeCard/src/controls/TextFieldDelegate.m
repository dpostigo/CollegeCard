//
// Created by dpostigo on 12/4/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "TextFieldDelegate.h"

@implementation TextFieldDelegate {
}

- (void) textFieldDidEndEditing: (UITextField *) textField {
    //    NSLog(@"%s", __PRETTY_FUNCTION__);
    [textField resignFirstResponder];

}

- (BOOL) textFieldShouldReturn: (UITextField *) textField {
    NSLog(@"%s", __PRETTY_FUNCTION__);

    [textField resignFirstResponder];
    return NO;
}


@end