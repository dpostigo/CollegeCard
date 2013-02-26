//
// Created by dpostigo on 2/25/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <CoreLocation/CoreLocation.h>
#import "MerchantViewController.h"
#import "CCRequest.h"
#import "BasicTextFieldCell.h"
#import "TableTextField.h"
#import "PlaceOperation.h"


#define PHONE_KEY @"Phone Number"


@implementation MerchantViewController {
}

//
//- (IBAction) handleSubmit: (id) sender {
//
//    BOOL allValid = self.allTextFieldsValid;
//
//    if (!allValid) {
//        return;
//    }
//
//    TableSection *tableSection = [dataSource objectAtIndex: 0];
//    TableRowObject *addressObject = [tableSection tableRowObjectForString: @"Store Address"];
//    TableRowObject *cityObject = [tableSection tableRowObjectForString: @"City"];
//    TableRowObject *stateObject = [tableSection tableRowObjectForString: @"State"];
//    TableRowObject *nameObject = [tableSection tableRowObjectForString: @"Store Name"];
//    TableRowObject *zipObject = [tableSection tableRowObjectForString: @"Zip Code"];
//    TableRowObject *websiteObject = [tableSection tableRowObjectForString: @"Web Site"];
//    TableRowObject *phoneObject = [tableSection tableRowObjectForString: PHONE_KEY];
//
//    if (!addressObject || !cityObject || !stateObject) {
//        return;
//    }
//
//    NSString *name = nameObject.stringContent;
//    NSString *address = addressObject.stringContent;
//    NSString *city = cityObject.stringContent;
//    NSString *state = stateObject.stringContent;
//    NSString *zip = zipObject.stringContent;
//    NSString *website = websiteObject.stringContent;
//    NSString *phone = phoneObject.stringContent;
//    NSString *fullAddress = [NSString stringWithFormat: @"%@, %@, %@", addressObject.stringContent, cityObject.stringContent, stateObject.stringContent];
//
//    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
//
//    [geocoder geocodeAddressString: fullAddress
//                 completionHandler: ^(NSArray *placemarks, NSError *error) {
//
//                     NSLog(@"error = %@", error);
//
//                     if ([placemarks count] > 1) {
//                         NSLog(@"More than one placemark.");
//                     } else {
//
//                         CLPlacemark *placemark = [placemarks objectAtIndex: 0];
//                         CLLocationCoordinate2D coordinate = placemark.location.coordinate;
//                         CGFloat latitude = (CGFloat) coordinate.latitude;
//                         CGFloat longitude = (CGFloat) coordinate.longitude;
//                         NSMutableDictionary *paramDict = [NSMutableDictionary dictionaryWithCapacity: 1];
//                         [paramDict setObject: name forKey: @"name"];
//                         [paramDict setObject: address forKey: @"address"];
//                         [paramDict setObject: city forKey: @"city"];
//                         [paramDict setObject: state forKey: @"state"];
//                         [paramDict setObject: zip forKey: @"postal_code"];
//                         [paramDict setObject: @"United States" forKey: @"country"];
//                         [paramDict setObject: website forKey: @"website"];
//                         [paramDict setObject: phone forKey: @"phone_number"];
//                         [paramDict setObject: [NSNumber numberWithFloat: latitude] forKey: @"latitude"];
//                         [paramDict setObject: [NSNumber numberWithFloat: longitude] forKey: @"longitude"];
//
//                         [_queue addOperation: [[PlaceOperation alloc] initWithParamDict: paramDict]];
//                     }
//                 }];
//}
//

- (void) prepareDataSource {
    TableSection *tableSection = [[TableSection alloc] initWithTitle: @""];

    [tableSection.rows addObject: [[TableRowObject alloc] initWithTextLabel: @"Store Name"]];
    [tableSection.rows addObject: [[TableRowObject alloc] initWithTextLabel: @"Store Address"]];
    [tableSection.rows addObject: [[TableRowObject alloc] initWithTextLabel: @"City"]];
    [tableSection.rows addObject: [[TableRowObject alloc] initWithTextLabel: @"State"]];
    [tableSection.rows addObject: [[TableRowObject alloc] initWithTextLabel: @"Zip Code"]];
    [tableSection.rows addObject: [[TableRowObject alloc] initWithTextLabel: PHONE_KEY]];
    [tableSection.rows addObject: [[TableRowObject alloc] initWithTextLabel: @"Web Site"]];

    [dataSource addObject: tableSection];
}


- (void) createPlace {

    NSMutableDictionary *paramDict = [NSMutableDictionary dictionaryWithCapacity: 1];
    [paramDict setObject: @"Appcelerator Cloud Services" forKey: @"name"];
    [paramDict setObject: @"58 South Park Ave" forKey: @"address"];
    [paramDict setObject: @"San Francisco" forKey: @"city"];
    [paramDict setObject: @"California" forKey: @"state"];
    [paramDict setObject: @"94107" forKey: @"postal_code"];
    [paramDict setObject: @"United States" forKey: @"country"];
    [paramDict setObject: @"http://www.appcelerator.com" forKey: @"website"];
    [paramDict setObject: @"acs" forKey: @"twitter"];
    [paramDict setObject: @"37.782227" forKey: @"latitude"];
    [paramDict setObject: @"-122.393159" forKey: @"longitude"];

    CCRequest *request = [[CCRequest alloc] initWithDelegate: self httpMethod: @"POST" baseUrl: @"places/create.json" paramDict: paramDict];
    [request startAsynchronous];
}


- (UITableViewCell *) tableView: (UITableView *) tableView cellForRowAtIndexPath: (NSIndexPath *) indexPath {

    TableSection *tableSection = [dataSource objectAtIndex: indexPath.section];
    TableRowObject *rowObject = [tableSection.rows objectAtIndex: indexPath.row];
    BasicTextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier: @"TableCell" forIndexPath: indexPath];

    cell.textField.placeholder = rowObject.textLabel;

    if ([cell.textField isKindOfClass: [TableTextField class]]) {
        TableTextField *textField = (TableTextField *) cell.textField;
        textField.rowObject = rowObject;
    }

    [self subscribeTextField: cell.textField];
    return cell;
}


- (void) textFieldEndedEditing: (UITextField *) aTextField {
    [super textFieldEndedEditing: aTextField];
    NSLog(@"%s", __PRETTY_FUNCTION__);

    if ([aTextField isKindOfClass: [TableTextField class]]) {
        TableTextField *textField = (TableTextField *) aTextField;
        NSString *string = [NSString stringWithFormat: @"%@", textField.text];
        NSLog(@"string = %@", string);
        textField.rowObject.content = string;
        textField.rowObject.stringContent = string;
    }
}

@end