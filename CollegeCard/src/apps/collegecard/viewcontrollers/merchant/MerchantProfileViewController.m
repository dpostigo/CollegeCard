//
// Created by dpostigo on 3/3/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <SDWebImage/UIButton+WebCache.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "MerchantProfileViewController.h"
#import "UserDetailRowObject.h"
#import "BasicTextFieldCell.h"
#import "CCPhoto.h"
#import "PlacePictureOperation.h"


@implementation MerchantProfileViewController {
}


- (void) loadView {
    [super loadView];

    NSLog(@"_model.currentPlace = %@", _model.currentPlace);
    NSLog(@"_model.currentPlace.photo = %@", _model.currentPlace.photo);
    NSLog(@"_model.currentPlace.photo.smallURL = %@", _model.currentPlace.photo.smallURL);
}



#pragma mark UITableView

- (void) prepareDataSource {
    TableSection *tableSection;
    tableSection = [[TableSection alloc] initWithTitle: @""];
    [tableSection.rows addObject: [[TableRowObject alloc] initWithTextLabel: USERVIEW_KEY detailTextLabel: _model.currentUser.email cellIdentifier: @"UserCell"]];
    [tableSection.rows addObject: [[TableRowObject alloc] initWithTextLabel: MERCHANT_EMAIL_KEY detailTextLabel: _model.currentUser.email]];
    [tableSection.rows addObject: [[UserDetailRowObject alloc] initWithTextLabel: [_model slugForProperty: @"name"] detailTextLabel: _model.currentPlace.name]];
    [tableSection.rows addObject: [[UserDetailRowObject alloc] initWithTextLabel: [_model slugForProperty: @"address"] detailTextLabel: _model.currentPlace.address]];
    [tableSection.rows addObject: [[UserDetailRowObject alloc] initWithTextLabel: [_model slugForProperty: @"city"] detailTextLabel: _model.currentPlace.city]];
    [tableSection.rows addObject: [[UserDetailRowObject alloc] initWithTextLabel: [_model slugForProperty: @"state"] detailTextLabel: _model.currentPlace.state]];
    [tableSection.rows addObject: [[UserDetailRowObject alloc] initWithTextLabel: [_model slugForProperty: @"postal_code"] detailTextLabel: _model.currentPlace.postalCode]];
    [dataSource addObject: tableSection];
}


- (void) handleUserCell: (UITableViewCell *) tableCell forTableSection: (TableSection *) tableSection rowObject: (TableRowObject *) rowObject {

    BasicTextFieldCell *cell = (BasicTextFieldCell *) tableCell;
    cell.textLabel.text = _model.currentUser.displayName;
    self.imageButton = cell.button;
    imageView = cell.imageView;

    NSString *string = _model.currentPlace.photo.largeURL;
    if (string) {
        [imageView setImageWithURL: [NSURL URLWithString: string]];
    }
}


- (void) configureCell: (UITableViewCell *) tableCell forTableSection: (TableSection *) tableSection rowObject: (TableRowObject *) rowObject {
    [super configureCell: tableCell forTableSection: tableSection rowObject: rowObject];

}


#pragma mark ImagePicker

- (void) imagePickerSelectedImage: (UIImage *) image {
    [_queue addOperation: [[PlacePictureOperation alloc] initWithImage: image]];
}

#pragma mark TextFields

- (void) tableTextFieldEndedEditing: (TableTextField *) tableTextField {
    [super tableTextFieldEndedEditing: tableTextField];

    if (tableTextField.text == nil || [tableTextField.text isEqualToString: @""]) return;

    TableRowObject *rowObject = tableTextField.rowObject;
    rowObject.stringContent = tableTextField.text;

    if ([rowObject.textLabel isEqualToString: MERCHANT_EMAIL_KEY]) {
    }

    else {
    }

    if ([tableTextField.rowObject isKindOfClass: [UserDetailRowObject class]]) {

        UserDetailRowObject *rowObject = (UserDetailRowObject *) tableTextField.rowObject;
        NSDictionary *paramDict;
        if (rowObject.isCustomField) {
            NSDictionary *customFields = [NSDictionary dictionaryWithObject: rowObject.stringContent forKey: [_model propertyForSlug: rowObject.textLabel]];
            paramDict = [NSDictionary dictionaryWithObject: customFields forKey: @"custom_fields"];
        } else {
            paramDict = [NSDictionary dictionaryWithObject: rowObject.stringContent forKey: [_model propertyForSlug: rowObject.textLabel]];
        }


        //        [_queue addOperation: [[UpdateUserOperation alloc] initWithParamDict: paramDict]];
    }
}


#pragma mark IBActions


#pragma mark Callbacks

- (void) placePictureUpdated {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    [table reloadSections: [NSIndexSet indexSetWithIndex: 0] withRowAnimation: UITableViewRowAnimationFade];

    [[SDWebImageManager sharedManager].imageCache clearMemory];

    NSString *string = _model.currentPlace.photo.smallURL;
    NSLog(@"string = %@", string);


    [imageView setImageWithURL: [NSURL URLWithString: string]];

    [UIView animateWithDuration: 1.0 animations: ^{
        containerProgress.alpha = 0;
    }                completion: ^(BOOL completion) {
    }];
}

@end