//
// Created by dpostigo on 9/20/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "VeryBasicViewController.h"
#import "Model.h"
#import "TextField.h"
#import "NSString+Utils.h"


@implementation VeryBasicViewController {
}


@synthesize _model;
@synthesize queue = _queue;

@synthesize delegate;
@synthesize delegates;
@synthesize textFields;


- (id) initWithNibName: (NSString *) nibNameOrNil bundle: (NSBundle *) nibBundleOrNil {
    self = [super initWithNibName: nibNameOrNil bundle: nibBundleOrNil];
    if (self) {
        _queue = [NSOperationQueue new];
        textFields = [[NSMutableArray alloc] init];
    }

    return self;
}


- (void) loadView {
    [super loadView];

    if (_queue == nil) {
        _queue = [NSOperationQueue new];
    }

    _model = [Model sharedModel];
    [_model subscribeDelegate: self];
}


- (void) viewWillUnload {
    [super viewWillUnload];
    [_model unsubscribeDelegate: self];
}


- (void) viewDidLoad {
    [super viewDidLoad];
    textFields = [[NSMutableArray alloc] init];
}


- (BOOL) shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation) toInterfaceOrientation {
    return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
}


- (void) subscribeTextField: (UITextField *) aTextField {
    if (![textFields containsObject: aTextField]) {
        [textFields addObject: aTextField];
        aTextField.delegate = self;
        [aTextField addTarget: self action: @selector(textFieldDidChange:) forControlEvents: UIControlEventEditingChanged];
    }
}


- (void) unsubscribeTextField: (UITextField *) aTextField {
    aTextField.delegate = nil;
    [textFields removeObject: aTextField];
}


- (void) touchesBegan: (NSSet *) touches withEvent: (UIEvent *) event {
    for (int j = 0; j < [textFields count]; j++) {
        UITextField *aTextField = [textFields objectAtIndex: j];
        [aTextField resignFirstResponder];
    }
}


- (void) dismissModal {
    [self dismissViewControllerAnimated: YES completion: nil];
}





#pragma mark TextFields



- (BOOL) allTextFieldsValid {
    NSArray *invalidFields = self.invalidTextFields;
    return ([invalidFields count] == 0);
}


- (NSArray *) invalidTextFields {
    NSMutableArray *invalid = [[NSMutableArray alloc] init];
    for (TextField *aTextField in textFields) {
        if (!aTextField.isValid) {
            [invalid addObject: aTextField];
        }
    }
    return invalid;
}


- (NSArray *) invalidTextFieldTypes {
    NSMutableArray *invalid = [[NSMutableArray alloc] init];
    for (TextField *aTextField in textFields) {
        if (!aTextField.isValid) {
            [invalid addObject: aTextField];
        }
    }
    return invalid;
}


- (BOOL) textFieldShouldReturn: (UITextField *) aTextField {
    NSLog(@"%s", __PRETTY_FUNCTION__);

    NSInteger index;
    switch (aTextField.returnKeyType) {

        case UIReturnKeyNext :

            index = [textFields indexOfObject: aTextField];
            if (index < [textFields count]) {
                UITextField *nextTextfield = [textFields objectAtIndex: index + 1];
                [nextTextfield becomeFirstResponder];
            }
            else {
                [aTextField resignFirstResponder];
            }

            break;

        case UIReturnKeyDone :
            [aTextField resignFirstResponder];
            break;

        case UIReturnKeyDefault:
            [aTextField resignFirstResponder];
            break;

        default:
            break;
    }

    [self textFieldDidReturn: aTextField];
    return NO;
}


- (void) textFieldDidEndEditing: (UITextField *) aTextField {
    [self textFieldEndedEditing: aTextField];
}


- (void) textFieldDidReturn: (UITextField *) aTextField {
    [self textFieldEndedEditing: aTextField];
}


- (void) textFieldEndedEditing: (UITextField *) aTextField {
}


- (void) textFieldDidChange: (UITextField *) aTextField {
}


- (BOOL) textField: (UITextField *) aTextField2 shouldChangeCharactersInRange: (NSRange) range replacementString: (NSString *) string {

    if ([aTextField2 isKindOfClass: [TextField class]]) {
        TextField *aTextField = (TextField *) aTextField2;

        if (aTextField.isNumeric && ![string allNumeric]) {
            return NO;
        }

        if (aTextField.characterLimit) {

            NSUInteger newLength = [aTextField.text length] + [string length] - range.length;
            if (newLength > aTextField.characterLimit) {
                return NO;
            }
        }
    }

    return YES;
}

@end