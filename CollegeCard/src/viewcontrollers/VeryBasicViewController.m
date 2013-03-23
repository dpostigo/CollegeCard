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
        NSLog(@"%s", __PRETTY_FUNCTION__);
        _queue = [NSOperationQueue new];
        textFields = [[NSMutableArray alloc] init];
    }

    return self;
}


- (id) initWithCoder: (NSCoder *) aDecoder {
    self = [super initWithCoder: aDecoder];
    if (self) {
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


//- (void) dealloc {
////    [_model unsubscribeDelegate: self];
//}


- (void) viewDidLoad {
    [super viewDidLoad];
    textFields = [[NSMutableArray alloc] init];
}


- (BOOL) shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation) toInterfaceOrientation {
    return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
}


- (void) subscribeTextField: (UITextField *) aTextField {
    if (aTextField != nil && ![textFields containsObject: aTextField]) {
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
    NSLog(@"%s", __PRETTY_FUNCTION__);
    [self dismissViewControllerAnimated: YES completion: nil];
}


- (IBAction) popSelf {

    [self.navigationController popViewControllerAnimated: YES];
}


- (void) animateTextField: (UITextField *) textField up: (BOOL) up {

    const int limit = 100;
    const int movementDistance = 80; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed


    CGFloat topDistance = textField.top;

    if ([textField.superview isKindOfClass: NSClassFromString(@"UITableViewCellContentView")]) {
        topDistance += textField.superview.top + textField.superview.superview.top;
    }

    NSLog(@"topDistance = %f", topDistance);

    if (up) {
        NSLog(@"Animating UP.");
        if (topDistance > limit) {
            int movement = (limit - topDistance);
            CGRect rect = CGRectOffset(self.view.frame, 0, movement);

            [UIView beginAnimations: @"anim" context: nil];
            [UIView setAnimationBeginsFromCurrentState: YES];
            [UIView setAnimationDuration: movementDuration];
            self.view.frame = rect;
            [UIView commitAnimations];
        }
    }

    else {

        NSLog(@"Animating down.");
        NSLog(@"self.view.frame = %@", NSStringFromCGRect(self.view.frame));

        CGRect statusBarRect = [self statusBarFrameViewRect: self.view];
        NSLog(@"statusBarRect.size.height = %f", statusBarRect.size.height);

        [UIView beginAnimations: @"anim" context: nil];
        [UIView setAnimationBeginsFromCurrentState: YES];
        [UIView setAnimationDuration: movementDuration];
        self.view.frame = CGRectMake(0, 0, self.view.width, self.view.height);
        [UIView commitAnimations];
    }
}


- (CGRect) statusBarFrameViewRect: (UIView *) view {
    CGRect statusBarFrame = [[UIApplication sharedApplication] statusBarFrame];
    CGRect statusBarWindowRect = [view.window convertRect: statusBarFrame fromWindow: nil];
    CGRect statusBarViewRect = [view convertRect: statusBarWindowRect fromView: nil];
    return statusBarViewRect;
}


#pragma mark TextFields -
#pragma mark Convenience


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


- (void) resignAllTextFields {
    for (UITextField *textField in self.textFields) {
        [textField resignFirstResponder];
    }
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


#pragma mark UITextFieldDelegate

- (void) textFieldDidBeginEditing: (UITextField *) textField {
    [self animateTextField: textField up: YES];
}


- (void) textFieldDidEndEditing: (UITextField *) aTextField {
    [self textFieldEndedEditing: aTextField];
    [self animateTextField: aTextField up: NO];
}


- (void) textFieldDidReturn: (UITextField *) aTextField {
    //    [self textFieldEndedEditing: aTextField];
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


#pragma mark Rewritten callbacks

- (void) textFieldEndedEditing: (UITextField *) aTextField {
}


- (void) textFieldDidChange: (UITextField *) aTextField {
}

@end