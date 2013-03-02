//
// Created by dpostigo on 2/24/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <SDWebImage/UIImageView+WebCache.h>
#import "HomeViewController.h"
#import "UIColor+Utils.h"
#import "CCPhoto.h"
#import "BasicTextFieldCell.h"
#import "UIImage+Utils.h"
#import "GetCheckinsOperation.h"


@implementation HomeViewController {
}


- (void) viewWillAppear: (BOOL) animated {
    [super viewWillAppear: animated];
    [self.navigationItem setHidesBackButton: YES];
    [self.navigationController setNavigationBarHidden: NO animated: YES];
}


- (void) loadView {
    [super loadView];
    [self userPictureUpdated];

    placesButton.borderColor = [UIColor colorWithWhite: 0.9 alpha: 1.0];
    placesButton.topColor = [UIColor whiteColor];
    placesButton.bottomColor = [UIColor colorWithWhite: 0.9 alpha: 1.0];
    placesButton.innerGlow = [UIColor colorWithWhite: 1.0 alpha: 0.5];

    nameLabel.text = _model.currentUser.displayName;
    collegeLabel.text = _model.currentUser.college;

    if ([_model.currentUser.major isEqualToString: NO_MAJOR_KEY]) {
    }
    majorLabel.text = _model.currentUser.major;

    [self sizeTableToFit];

    [_queue addOperation: [[GetCheckinsOperation alloc] initWithUserId: _model.currentUser.objectId]];
}


- (IBAction) handleSettingsButton: (id) sender {
}


- (IBAction) handleCheckin: (id) sender {
}




#pragma mark UITableView

- (void) prepareDataSource {
    TableSection *tableSection;
    tableSection = [[TableSection alloc] initWithTitle: @""];
    [tableSection.rows addObject: [[TableRowObject alloc] initWithTextLabel: USERVIEW_KEY detailTextLabel: _model.currentUser.email cellIdentifier: @"UserCell"]];
    [dataSource addObject: tableSection];
}


- (CGFloat) heightForRowAtIndexPath: (NSIndexPath *) indexPath {
    if (indexPath.row == 0) return 88;
    return [super heightForRowAtIndexPath: indexPath];
}


- (void) configureCell: (UITableViewCell *) tableCell forTableSection: (TableSection *) tableSection rowObject: (TableRowObject *) rowObject {
    [super configureCell: tableCell forTableSection: tableSection rowObject: rowObject];

    BasicTextFieldCell *cell = (BasicTextFieldCell *) tableCell;

    cell.textLabel.text = rowObject.textLabel;
    cell.detailTextLabel.text = rowObject.detailTextLabel;
    cell.textField.placeholder = rowObject.detailTextLabel;
    cell.selectedBackgroundView = [[UIView alloc] init];

    [self subscribeTextField: cell.textField];

    if ([rowObject.textLabel isEqualToString: USERVIEW_KEY]) {

        imageView = cell.imageView;
        cell.textLabel.text = _model.currentUser.displayName;

        if ([_model.currentUser.college isEqualToString: NO_COLLEGE_KEY]) {
            cell.textField.placeholder = _model.currentUser.college;
        } else {
            cell.textField.text = _model.currentUser.college;
        }

        if ([_model.currentUser.major isEqualToString: NO_MAJOR_KEY]) {
            cell.detailTextField.placeholder = _model.currentUser.major;
        } else {
            cell.detailTextField.text = _model.currentUser.major;
        }

        cell.textField.userInteractionEnabled = NO;
        cell.detailTextField.userInteractionEnabled = NO;
        [self userPictureUpdated];
//        NSString *string = _model.currentUser.photo.thumbURL;
//        if (string) {
//            NSLog(@"Setting image in HomeViewController");
//            [cell.imageView setImageWithURL: [NSURL URLWithString: string]];
//        }
    }
}


- (void) didSelectRowObject: (TableRowObject *) rowObject inSection: (TableSection *) tableSection {
    [super didSelectRowObject: rowObject inSection: tableSection];

    if ([rowObject.textLabel isEqualToString: USERVIEW_KEY]) {
        [self performSegueWithIdentifier: @"ProfileSegue" sender: self];
    }
}


#pragma mark Callbacks

- (void) userPictureUpdated {
    NSString *string = _model.currentUser.photo.smallURL;
    if (string) {
        [imageView setImageWithURL: [NSURL URLWithString: string]];
    }
}


- (void) userDidUpdate {


}
@end