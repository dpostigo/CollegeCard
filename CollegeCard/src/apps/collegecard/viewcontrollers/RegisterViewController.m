//
// Created by dpostigo on 2/24/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "RegisterViewController.h"
#import "BasicTextFieldCell.h"
#import "SVProgressHUD.h"
#import "RegisterOperation.h"
#import "TableTextField.h"
#import "CCRequest.h"


@implementation RegisterViewController {
}


- (id) initWithCoder: (NSCoder *) aDecoder {
    self = [super initWithCoder: aDecoder];
    if (self) {
        self.rowSpacing = 10;
    }

    return self;
}


- (void) viewWillAppear: (BOOL) animated {
    [super viewWillAppear: animated];
    [self.navigationController setNavigationBarHidden: NO animated: YES];
}


- (void) viewWillDisappear: (BOOL) animated {
    [super viewWillDisappear: animated];
    //    [self.navigationController setNavigationBarHidden: YES animated: YES];
}


- (void) prepareDataSource {

    TableSection *tableSection = [[TableSection alloc] initWithTitle: @""];
    [tableSection.rows addObject: [[TableRowObject alloc] initWithTextLabel: EMAIL_KEY]];
    [tableSection.rows addObject: [[TableRowObject alloc] initWithTextLabel: @"First Name"]];
    [tableSection.rows addObject: [[TableRowObject alloc] initWithTextLabel: @"Last Name"]];
    [tableSection.rows addObject: [[TableRowObject alloc] initWithTextLabel: PASSWORD_KEY]];

    [dataSource addObject: tableSection];
}


- (IBAction) handleRegister: (id) sender {

    NSString *email;
    NSString *userPassword;
    NSString *firstName;
    NSString *lastName;
    BOOL shouldDebug = NO;

    if (DEBUG && shouldDebug) {

        email = @"dani.postigo@gmail.com";
        userPassword = @"gr8entw0";

        [SVProgressHUD showWithStatus: @"Registering..."];
        [_queue addOperation: [[RegisterOperation alloc] initWithEmail: email password: userPassword firstName: firstName lastName: lastName]];
    } else {

        if (self.allTextFieldsValid) {

            TableSection *tableSection = [dataSource objectAtIndex: 0];
            TableRowObject *rowObject1 = [tableSection.rows objectAtIndex: 0];
            TableRowObject *rowObject2 = [tableSection.rows objectAtIndex: 1];
            TableRowObject *rowObject3 = [tableSection.rows objectAtIndex: 2];
            TableRowObject *rowObject4 = [tableSection.rows objectAtIndex: 3];

            email = rowObject1.content;
            firstName = rowObject2.content;
            lastName = rowObject3.content;
            userPassword = rowObject4.content;

            [SVProgressHUD showWithStatus: @"Registering..."];
            [_queue addOperation: [[RegisterOperation alloc] initWithEmail: email password: userPassword firstName: firstName lastName: lastName]];
        } else {

            NSArray *textFields = self.invalidTextFields;
            TableTextField *textField = [textFields objectAtIndex: 0];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Register" message: @"" delegate: nil cancelButtonTitle: @"OK" otherButtonTitles: nil];
            if (textField.mode == TextFieldModeEmail) {
                alert.message = @"Please enter a valid email address.";
            } else {
                alert.message = @"Please enter a password.";
            }

            [alert show];
            NSLog(@"textField = %@", textField);
        }
    }
}


#pragma mark Callbacks

- (void) registerSucceeded {
    [SVProgressHUD showSuccessWithStatus: @"Success!" duration: 1.0];

    [UIView animateWithDuration: 1.0 animations: ^{
    }                completion: ^(BOOL completion) {
        [self.navigationController popViewControllerAnimated: YES];
    }];
}


- (void) registerFailedWithMessage: (NSString *) message {
    [SVProgressHUD showErrorWithStatus: message];
}


- (void) didRegisterUser {

    //    NSMutableDictionary *paramDict = [NSMutableDictionary dictionaryWithCapacity: 5];
    //    [paramDict setObject: @"email@email.com" forKey: @"email"];
    //    [paramDict setObject: @"John" forKey: @"first_name"];
    //    [paramDict setObject: @"Woo" forKey: @"last_name"];
    //    [paramDict setObject: @"pass" forKey: @"userPassword"];
    //    [paramDict setObject: @"pass" forKey: @"password_confirmation"];
    //    CCRequest *request = [[CCRequest alloc] initWithDelegate: self httpMethod: @"POST" baseUrl: @"users/create.json" paramDict: paramDict];
    //
    //    [_queue addOperation: request]; // for asynchronous call and use my own operation queue

}


#pragma mark UITableViewController





- (void) configureCell: (UITableViewCell *) tableCell forTableSection: (TableSection *) tableSection rowObject: (TableRowObject *) rowObject {
    [super configureCell: tableCell forTableSection: tableSection rowObject: rowObject];

    BasicTextFieldCell *cell = (BasicTextFieldCell *) tableCell;
    cell.textField.placeholder = rowObject.textLabel;
    if ([cell.textField isKindOfClass: [TableTextField class]]) {
        TableTextField *textField = (TableTextField *) cell.textField;
        textField.rowObject = rowObject;

        if ([rowObject.textLabel isEqualToString: EMAIL_KEY]) {
            textField.mode = TextFieldModeEmail;
        } else if ([rowObject.textLabel isEqualToString: PASSWORD_KEY]) {
            textField.secureTextEntry = YES;
        }
    }

    [self subscribeTextField: cell.textField];
}


- (void) textFieldEndedEditing: (UITextField *) aTextField {
    [super textFieldEndedEditing: aTextField];

    if ([aTextField isKindOfClass: [TableTextField class]]) {
        TableTextField *textField = (TableTextField *) aTextField;
        textField.rowObject.content = textField.text;
    }
}

@end