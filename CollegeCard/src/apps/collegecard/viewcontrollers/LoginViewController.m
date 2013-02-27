//
// Created by dpostigo on 2/24/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "LoginViewController.h"
#import "BasicTextFieldCell.h"
#import "UIColor+Utils.h"
#import "LogoutOperation.h"
#import "TextField.h"
#import "TableTextField.h"
#import "SVProgressHUD.h"
#import "LoginOperation.h"


@implementation LoginViewController {
}


@synthesize signUpButton;




- (void) viewDidLoad {
    [super viewDidLoad];

    signUpButton.backgroundColor = [UIColor blueColor];
}


- (void) viewWillAppear: (BOOL) animated {
    [super viewWillAppear: animated];
    [self.navigationController setNavigationBarHidden: YES animated: YES];

    if (_model.isLoggedIn) {
        [self goToHome];
    }
}


- (void) viewWillDisappear: (BOOL) animated {
    [super viewWillDisappear: animated];
    [self.navigationController setNavigationBarHidden: NO animated: YES];
}


- (void) viewDidAppear: (BOOL) animated {
    [super viewDidAppear: animated];
}


- (void) loadView {
    self.rowSpacing = 10.0;
    [super loadView];

    signUpButton.backgroundLayer.colors = (@[
            (id) [UIColor colorWithString: @"00b0ff"].CGColor,
            (id) [UIColor colorWithString: @"038cd3"].CGColor

    ]);

    signUpButton.layer.borderColor = [UIColor colorWithString: @"196287"].CGColor;
}


- (IBAction) handleLogin: (id) sender {

    [self resignAllTextFields];

    NSString *email;
    NSString *userPassword;

    //    if (DEBUG) {
    //
    //        email = @"dani.postigo@gmail.com";
    //        userPassword = @"gr8entw0";
    //
    //        [SVProgressHUD showWithStatus: @"Registering..."];
    //        [_queue addOperation: [[RegisterOperation alloc] initWithEmail: email password: userPassword]];
    //    } else {

    if (self.allTextFieldsValid) {

        TableSection *tableSection = [dataSource objectAtIndex: 0];
        TableRowObject *rowObject = [tableSection.rows objectAtIndex: 0];
        TableRowObject *rowObject1 = [tableSection.rows objectAtIndex: 1];
        email = rowObject.content;
        userPassword = rowObject1.content;

        [SVProgressHUD showWithStatus: @"Signing in ..."];
        [_queue addOperation: [[LoginOperation alloc] initWithEmail: email userPassword: userPassword]];
    } else {

        NSArray *textFields = self.invalidTextFields;
        TableTextField *textField = [textFields objectAtIndex: 0];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Login" message: @"" delegate: nil cancelButtonTitle: @"OK" otherButtonTitles: nil];
        if (textField.mode == TextFieldModeEmail) {
            alert.message = @"Please enter a valid email address.";
        } else {
            alert.message = @"Please enter a password.";
        }

        [alert show];
        NSLog(@"textField = %@", textField);
    }
    //    }

}


- (void) goToHome {
    if (_model.currentUser.isMerchant) {
        [self performSegueWithIdentifier: @"MerchantDashboardSegue" sender: self];
    } else {
        [self performSegueWithIdentifier: @"LoginSegue" sender: self];
    }
}


- (void) prepareDataSource {
    TableSection *tableSection = [[TableSection alloc] initWithTitle: @""];
    [tableSection.rows addObject: [[TableRowObject alloc] initWithTextLabel: EMAIL_KEY]];
    [tableSection.rows addObject: [[TableRowObject alloc] initWithTextLabel: PASSWORD_KEY]];
    [dataSource addObject: tableSection];
}





#pragma mark Callbacks

- (void) registerSucceededWithUsername: (NSString *) username andPassword: (NSString *) password {
    TableSection *tableSection = [dataSource objectAtIndex: 0];
    TableRowObject *rowObject = [tableSection.rows objectAtIndex: 0];
    rowObject.content = username;

    rowObject = [tableSection.rows objectAtIndex: 1];
    rowObject.content = password;
}


- (void) registerSucceeded {

    NSLog(@"%s", __PRETTY_FUNCTION__);
    [table reloadData];
}


- (void) loginSucceeded {
    [SVProgressHUD showSuccessWithStatus: @"Success!"];

    [UIView animateWithDuration: 1.0 animations: ^{
    }                completion: ^(BOOL completion) {

        [self performSelector: @selector(goToHome) withObject: nil afterDelay: 1.0];
    }];
}


- (void) loginFailedWithMessage: (NSString *) message {

    [SVProgressHUD showErrorWithStatus: message];
}





#pragma mark UITableView
//
//- (UITableViewCell *) tableView: (UITableView *) tableView cellForRowAtIndexPath: (NSIndexPath *) indexPath {
//
//    TableSection *tableSection = [dataSource objectAtIndex: indexPath.section];
//    TableRowObject *rowObject = [tableSection.rows objectAtIndex: indexPath.row];
//    BasicTextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier: @"LoginTableViewCell" forIndexPath: indexPath];
//
//
//
//    //    if (rowObject.content) {
//    //        cell.textField.text = rowObject.content;
//    //    }
//
//    return cell;
//}


- (void) configureCell: (UITableViewCell *) tableCell forTableSection: (TableSection *) tableSection rowObject: (TableRowObject *) rowObject {
    [super configureCell: tableCell forTableSection: tableSection rowObject: rowObject];

    NSLog(@"%s", __PRETTY_FUNCTION__);
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