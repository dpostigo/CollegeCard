//
// Created by dpostigo on 2/25/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <CoreLocation/CoreLocation.h>
#import "MerchantSignupViewController.h"
#import "CCRequest.h"
#import "BasicTextFieldCell.h"
#import "TableTextField.h"
#import "PlaceOperation.h"
#import "TableSection+Utils.h"
#import "BasicWhiteView.h"
#import "SVProgressHUD.h"
#import "RegisterOperation.h"
#import "UpdateUserOperation.h"
#import "LogoutOperation.h"


#define PHONE_KEY @"Phone Number"


@implementation MerchantSignupViewController {
    TableSection *accountSection;
    TableSection *currentSection;
    TableSection *infoSection;
    TableSection *optionalSection;
}


- (void) loadView {
    self.rowSpacing = 10;
    [super loadView];

    [self performSegueWithIdentifier: @"MerchantSuccessSegue" sender: self];
}


- (void) viewWillAppear: (BOOL) animated {
    [super viewWillAppear: animated];
    [self.navigationController setNavigationBarHidden: NO];
}


- (IBAction) handleCancel: (id) sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Cancel" message: @"Are you sure you want to cancel creating your merchant account?" delegate: self cancelButtonTitle: @"No" otherButtonTitles: @"Yes", nil];
    alert.delegate = self;
    [alert show];
}


- (IBAction) switchSections: (id) sender {

    BOOL allValid = self.allTextFieldsValid;

    if (!allValid) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Error" message: @"Please fill out all fields before continuing." delegate: nil cancelButtonTitle: @"OK" otherButtonTitles: nil];
        [alert show];
        return;
    }

    TableSection *tableSection = [dataSource objectAtIndex: 0];

    if (tableSection == accountSection) {
        [SVProgressHUD showWithStatus: @"Registering..."];
        [self handleSignup: sender];
    } else if (tableSection == infoSection) {

        [dataSource removeAllObjects];
        [table deleteSections: [NSIndexSet indexSetWithIndex: 0] withRowAnimation: UITableViewRowAnimationFade];

        [dataSource addObject: optionalSection];
        [table insertSections: [NSIndexSet indexSetWithIndex: 0] withRowAnimation: UITableViewRowAnimationFade];

        [self animateButton: submitButton toTitle: @"Send"];

    } else if (tableSection == optionalSection) {

        [self handleSubmit: sender];
    }
}


- (void) handleSignup: (id) sender {
    NSString *email = [[accountSection tableRowObjectForString: @"Email"] stringContent];
    NSString *firstName = [[accountSection tableRowObjectForString: @"Your First Name"] stringContent];
    NSString *lastName = [[accountSection tableRowObjectForString: @"Your Last Name"] stringContent];
    NSString *userPassword = [[accountSection tableRowObjectForString: PASSWORD_KEY] stringContent];
    [_queue addOperation: [[RegisterOperation alloc] initWithEmail: email password: userPassword firstName: firstName lastName: lastName isMerchant: YES]];
}


- (IBAction) handleSubmit: (id) sender {

    NSString *storeName = [[infoSection tableRowObjectForString: @"Store Name"] stringContent];
    NSString *address = [[infoSection tableRowObjectForString: @"Store Address"] stringContent];
    NSString *city = [[infoSection tableRowObjectForString: @"City"] stringContent];
    NSString *state = [[infoSection tableRowObjectForString: @"State"] stringContent];
    NSString *zip = [[infoSection tableRowObjectForString: @"Zip Code"] stringContent];
    NSString *website = [[optionalSection tableRowObjectForString: @"Web Site"] stringContent];
    NSString *phone = [[optionalSection tableRowObjectForString: PHONE_KEY] stringContent];
    NSString *fullAddress = [NSString stringWithFormat: @"%@, %@, %@", address, city, state];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];

    [geocoder geocodeAddressString: fullAddress
                 completionHandler: ^(NSArray *placemarks, NSError *error) {

                     if ([placemarks count] > 1) {
                         NSLog(@"More than one placemark.");
                     } else {

                         CLPlacemark *placemark = [placemarks objectAtIndex: 0];
                         CLLocationCoordinate2D coordinate = placemark.location.coordinate;
                         CGFloat latitude = (CGFloat) coordinate.latitude;
                         CGFloat longitude = (CGFloat) coordinate.longitude;
                         NSMutableDictionary *paramDict = [NSMutableDictionary dictionaryWithCapacity: 1];
                         [paramDict setObject: storeName forKey: @"name"];
                         [paramDict setObject: address forKey: @"address"];
                         [paramDict setObject: city forKey: @"city"];
                         [paramDict setObject: state forKey: @"state"];
                         [paramDict setObject: zip forKey: @"postal_code"];
                         [paramDict setObject: @"United States" forKey: @"country"];

                         if (website) [paramDict setObject: website forKey: @"website"];
                         if (phone)[paramDict setObject: phone forKey: @"phone_number"];
                         [paramDict setObject: [NSNumber numberWithFloat: latitude] forKey: @"latitude"];
                         [paramDict setObject: [NSNumber numberWithFloat: longitude] forKey: @"longitude"];

                         [SVProgressHUD showWithStatus: @"Sending..."];
                         [_queue addOperation: [[PlaceOperation alloc] initWithParamDict: paramDict]];
                     }
                 }];
}


- (void) animateButton: (UIButton *) button toTitle: (NSString *) title {
    [UIView animateWithDuration: 0.25 delay: 0.0 options: UIViewAnimationOptionCurveEaseOut animations: ^{
        button.alpha = 0;
    }                completion: ^(BOOL completion) {
        [button setTitle: title forState: UIControlStateNormal];

        [UIView animateWithDuration: 0.25 delay: 0.0 options: UIViewAnimationOptionCurveEaseOut animations: ^{

            button.alpha = 1;
        }                completion: nil];
    }];
}


#pragma mark UITableView

- (void) prepareDataSource {
    TableSection *tableSection = nil;

    tableSection = [[TableSection alloc] initWithTitle: @"Create your merchant account"];
    [tableSection.rows addObject: [[TableRowObject alloc] initWithTextLabel: @"Email"]];
    [tableSection.rows addObject: [[TableRowObject alloc] initWithTextLabel: @"Your First Name"]];
    [tableSection.rows addObject: [[TableRowObject alloc] initWithTextLabel: @"Your Last Name"]];
    [tableSection.rows addObject: [[TableRowObject alloc] initWithTextLabel: PASSWORD_KEY]];
    accountSection = tableSection;

    tableSection = [[TableSection alloc] initWithTitle: @"Store Details"];
    [tableSection.rows addObject: [[TableRowObject alloc] initWithTextLabel: @"Store Name"]];
    [tableSection.rows addObject: [[TableRowObject alloc] initWithTextLabel: @"Store Address"]];
    [tableSection.rows addObject: [[TableRowObject alloc] initWithTextLabel: @"City"]];
    [tableSection.rows addObject: [[TableRowObject alloc] initWithTextLabel: @"State"]];
    [tableSection.rows addObject: [[TableRowObject alloc] initWithTextLabel: @"Zip Code"]];
    infoSection = tableSection;

    tableSection = [[TableSection alloc] initWithTitle: @"Store Details (cont)"];
    [tableSection.rows addObject: [[TableRowObject alloc] initWithTextLabel: PHONE_KEY]];
    [tableSection.rows addObject: [[TableRowObject alloc] initWithTextLabel: @"Web Site"]];
    optionalSection = tableSection;

    [dataSource addObject: accountSection];
}


- (CGFloat) heightForHeaderInSection: (NSInteger) section {
    return table.rowHeight + 10;
}


- (UIView *) viewForHeaderInSection: (NSInteger) section {

    TableSection *tableSection = [dataSource objectAtIndex: section];
    UITableViewCell *cell = [table dequeueReusableCellWithIdentifier: @"HeaderCell"];
    cell.textLabel.text = tableSection.title;
    return cell;

    return [super viewForHeaderInSection: section];
}


- (void) configureCell: (UITableViewCell *) tableCell forTableSection: (TableSection *) tableSection rowObject: (TableRowObject *) rowObject {
    [super configureCell: tableCell forTableSection: tableSection rowObject: rowObject];

    BasicTextFieldCell *cell = (BasicTextFieldCell *) tableCell;

    cell.textField.text = nil;
    cell.textField.placeholder = rowObject.textLabel;
    cell.backgroundView = [[BasicWhiteView alloc] init];

    if ([cell.textField isKindOfClass: [TableTextField class]]) {
        TableTextField *textField = (TableTextField *) cell.textField;
        textField.rowObject = rowObject;

        if ([rowObject.textLabel isEqualToString: EMAIL_KEY]) {
            textField.mode = TextFieldModeEmail;
        } else if ([rowObject.textLabel isEqualToString: PASSWORD_KEY]) {
            textField.secureTextEntry = YES;
        }
    }

    if (tableSection == infoSection) {
        cell.textField.autocapitalizationType = UITextAutocapitalizationTypeWords;
    }

    [self subscribeTextField: cell.textField];
}


- (void) didSelectRowObject: (TableRowObject *) rowObject inSection: (TableSection *) tableSection {
    [super didSelectRowObject: rowObject inSection: tableSection];
    [self resignAllTextFields];
}

#pragma mark TextFields

- (void) textFieldEndedEditing: (UITextField *) aTextField {
    [super textFieldEndedEditing: aTextField];
    NSLog(@"%s", __PRETTY_FUNCTION__);

    if ([aTextField isKindOfClass: [TableTextField class]]) {
        TableTextField *textField = (TableTextField *) aTextField;
        NSString *string = [NSString stringWithFormat: @"%@", textField.text];
        textField.rowObject.content = string;
        textField.rowObject.stringContent = string;
    }
}







#pragma mark Callbacks

- (void) registerSucceeded {
    [SVProgressHUD showSuccessWithStatus: @"Success!"];

    [dataSource removeAllObjects];
    [table deleteSections: [NSIndexSet indexSetWithIndex: 0] withRowAnimation: UITableViewRowAnimationFade];

    [dataSource addObject: infoSection];
    [table insertSections: [NSIndexSet indexSetWithIndex: 0] withRowAnimation: UITableViewRowAnimationFade];
    [self animateButton: submitButton toTitle: @"Final Step"];
}


- (void) registerFailedWithMessage: (NSString *) message {
    [SVProgressHUD showErrorWithStatus: message];
}


- (void) merchantSignupSucceeded {

    NSMutableDictionary *customFields = [[NSMutableDictionary alloc] initWithDictionary: _model.currentUser.customFields];
    [customFields setObject: _model.currentPlace.objectId forKey: @"placeId"];

    NSDictionary *paramDict = [NSDictionary dictionaryWithObject: customFields forKey: @"custom_fields"];
    [_queue addOperation: [[UpdateUserOperation alloc] initWithParamDict: paramDict]];
}


- (void) userDidUpdate {
    [SVProgressHUD showSuccessWithStatus: @"Success!"];
    [self performSegueWithIdentifier: @"MerchantSuccessSegue" sender: self];
}


- (void) logoutSucceeded {
    [self dismissModal];
}

#pragma mark UIAlertViewDelegate


- (void) alertView: (UIAlertView *) alertView didDismissWithButtonIndex: (NSInteger) buttonIndex {
    if (buttonIndex != alertView.cancelButtonIndex) {

        [_queue addOperation: [[LogoutOperation alloc] initWithDefault]];
    }
}

@end