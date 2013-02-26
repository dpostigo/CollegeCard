//
// Created by dpostigo on 2/24/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "AccountSettingsViewController.h"
#import "BasicTextFieldCell.h"
#import "CCRequest.h"


@implementation AccountSettingsViewController {
}


- (void) prepareDataSource {

    NSLog(@"_model.currentUser.email = %@", _model.currentUser.email);

    TableSection *tableSection;

    tableSection = [[TableSection alloc] initWithTitle: @""];
    [tableSection.rows addObject: [[TableRowObject alloc] initWithTextLabel: EMAIL_KEY detailTextLabel: _model.currentUser.email]];
    [tableSection.rows addObject: [[TableRowObject alloc] initWithTextLabel: @"First Name" detailTextLabel: _model.currentUser.firstName]];
    [tableSection.rows addObject: [[TableRowObject alloc] initWithTextLabel: @"Last Name" detailTextLabel: [self nilCheck: _model.currentUser.lastName alternative: @"Your last name"]]];
    [tableSection.rows addObject: [[TableRowObject alloc] initWithTextLabel: @"Graduation Date" detailTextLabel: [self nilCheck: _model.currentUser.graduationDate alternative: @"Your gender"]]];
    [tableSection.rows addObject: [[TableRowObject alloc] initWithTextLabel: @"Major" detailTextLabel: [self nilCheck: _model.currentUser.major alternative: @"Your major"]]];
    [tableSection.rows addObject: [[TableRowObject alloc] initWithTextLabel: @"Birth Date" detailTextLabel: [self nilCheck: _model.currentUser.birthDate alternative: @"Your birth date"]]];
    [tableSection.rows addObject: [[TableRowObject alloc] initWithTextLabel: @"Gender" detailTextLabel: [self nilCheck: _model.currentUser.gender alternative: @"Your gender"]]];

    [dataSource addObject: tableSection];
}


- (NSString *) nilCheck: (NSString *) string alternative: (NSString *) alternativeString {
    if (string == nil) return alternativeString;
    return string;
}


- (UITableViewCell *) tableView: (UITableView *) tableView cellForRowAtIndexPath: (NSIndexPath *) indexPath {

    TableSection *tableSection = [dataSource objectAtIndex: indexPath.section];
    TableRowObject *rowObject = [tableSection.rows objectAtIndex: indexPath.row];
    BasicTextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier: @"TableCell" forIndexPath: indexPath];
    cell.textLabel.text = rowObject.textLabel;
    cell.detailTextLabel.text = rowObject.detailTextLabel;
    cell.textField.placeholder = rowObject.detailTextLabel;
    cell.selectedBackgroundView = [[UIView alloc] init];

    [self subscribeTextField: cell.textField];

    if ([rowObject.textLabel isEqualToString: EMAIL_KEY])  {
        cell.textField.userInteractionEnabled = NO;
        cell.textField.text = rowObject.detailTextLabel;
    }

    return cell;
}


- (void) textFieldEndedEditing: (UITextField *) aTextField {
    [super textFieldEndedEditing: aTextField];



    NSMutableDictionary *paramDict = [[NSMutableDictionary alloc] init];
    [paramDict setObject: _model.currentUser.firstName forKey: @"first_name"];
    [paramDict setObject: _model.currentUser.lastName forKey: @"last_name"];

    NSMutableDictionary *customFields = [[NSMutableDictionary alloc] init];

    NSLog(@"_model.currentUser.graduationDate = %@", _model.currentUser.graduationDate);
    [customFields setObject: _model.currentUser.graduationDate forKey: @"graduationDate"];
    [customFields setObject: _model.currentUser.birthDate forKey: @"birthDate"];
    [customFields setObject: _model.currentUser.major forKey: @"major"];
    [customFields setObject: _model.currentUser.gender forKey: @"gender"];

    [paramDict setObject: customFields forKey: @"custom_fields"];

    [_queue addOperation: [[CCRequest alloc] initWithDelegate: nil httpMethod: @"PUT" baseUrl: @"users/update.json" paramDict: paramDict]];
}



- (void) didSelectRowObject: (TableRowObject *) rowObject inSection: (TableSection *) tableSection {
    [super didSelectRowObject: rowObject inSection: tableSection];

    for (UITextField *textField in self.textFields) {
        [textField resignFirstResponder];
    }
}

@end