//
// Created by dpostigo on 2/24/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <SDWebImage/UIImageView+WebCache.h>
#import "HomeViewController.h"
#import "CCPhoto.h"
#import "BasicTextFieldCell.h"
#import "UIImage+Utils.h"
#import "GetCheckinsOperation.h"
#import "BasicWhiteView.h"
#import "BasicBlackView.h"


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
    //    [self addTopSpacing];

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

    //    BasicTextFieldCell *userCell = [table dequeueReusableCellWithIdentifier: @"UserCell"];
    //    userCell.backgroundView = [[BasicWhiteView alloc] init];
    //    [self handleUserCell: userCell];
    //    [topView addSubview: userCell];
    //
    //    topView.height = table.top;
    //    userCell.bottom = topView.height;
    //
    //    userCell.button = [UIButton buttonWithType: UIButtonTypeCustom];
    //    userCell.button.frame = userCell.imageView.frame;
    //    [userCell.contentView addSubview: userCell.button];
    //    [userCell.button  addTarget: self action: @selector(handleProfileSegue:) forControlEvents: UIControlEventTouchUpInside];

    for (UIView *view in searchBar.subviews) {
        if ([view isKindOfClass: NSClassFromString(@"UISearchBarBackground")]) {
            UIView *newView = [[UIView alloc] initWithFrame: view.frame];
            newView.backgroundColor = [UIColor blackColor];
            [view addSubview: newView];
            break;
        }
    }
}


#pragma mark IBActions

- (IBAction) handleSettingsButton: (id) sender {
}


- (IBAction) handleCheckin: (id) sender {
}


- (IBAction) handleSwoop: (id) sender {
}


- (IBAction) handleYourPlaces: (id) sender {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    [self performSegueWithIdentifier: @"SavedPlacesSegue" sender: self];
}


- (void) handleProfileSegue: (id) sender {
    [self performSegueWithIdentifier: @"ProfileSegue" sender: self];
}



#pragma mark UITableView

- (void) prepareDataSource {


    TableSection *tableSection;
    tableSection = [[TableSection alloc] initWithTitle: @"TopCell"];
    [tableSection.rows addObject: [[TableRowObject alloc] initWithTextLabel: USERVIEW_KEY detailTextLabel: _model.currentUser.email cellIdentifier: @"UserCell"]];
    [dataSource addObject: tableSection];

    tableSection = [[TableSection alloc] initWithTitle: @""];
    [tableSection.rows addObject: [[TableRowObject alloc] initWithTextLabel: @"Tokyo Bay Japanese" detailTextLabel: @"15% off" cellIdentifier: @"TableCell"]];
    [tableSection.rows addObject: [[TableRowObject alloc] initWithTextLabel: @"Tokyo Bay Japanese" detailTextLabel: @"15% off" cellIdentifier: @"TableCell"]];
    [tableSection.rows addObject: [[TableRowObject alloc] initWithTextLabel: @"Tokyo Bay Japanese" detailTextLabel: @"15% off" cellIdentifier: @"TableCell"]];
    [tableSection.rows addObject: [[TableRowObject alloc] initWithTextLabel: @"Tokyo Bay Japanese" detailTextLabel: @"15% off" cellIdentifier: @"TableCell"]];
    [tableSection.rows addObject: [[TableRowObject alloc] initWithTextLabel: @"Tokyo Bay Japanese" detailTextLabel: @"15% off" cellIdentifier: @"TableCell"]];
    [dataSource addObject: tableSection];
}


- (CGFloat) heightForTableRow: (TableRowObject *) rowObject inSection: (TableSection *) section {
    if ([rowObject.cellIdentifier isEqualToString: @"UserCell"]) {
        return 297;
    }
    return [super heightForTableRow: rowObject inSection: section];
}


- (void) configureCell: (UITableViewCell *) tableCell forTableSection: (TableSection *) tableSection rowObject: (TableRowObject *) rowObject {
    [super configureCell: tableCell forTableSection: tableSection rowObject: rowObject];

    BasicTextFieldCell *cell = (BasicTextFieldCell *) tableCell;

    if ([rowObject.textLabel isEqualToString: USERVIEW_KEY]) {
        [self handleUserCell: cell];
        return;
    }

    cell.textLabel.text = rowObject.textLabel;
    cell.detailTextLabel.text = rowObject.detailTextLabel;
    cell.textField.placeholder = rowObject.detailTextLabel;
    cell.selectedBackgroundView = [[UIView alloc] init];
    cell.backgroundView = [[UIView alloc] init];
    cell.backgroundView.backgroundColor = [UIColor whiteColor];
    cell.accessoryView = _model.defaultAccessoryView;

    UIView *divider = [[UIView alloc] init];
    divider.width = cell.width;
    divider.height = 1;
    divider.bottom = cell.contentView.height;
    divider.backgroundColor = [UIColor colorWithWhite: 0.0 alpha: 0.1];
    [cell.contentView addSubview: divider];
    [self subscribeTextField: cell.textField];
}


- (void) didSelectRowObject: (TableRowObject *) rowObject inSection: (TableSection *) tableSection {
    [super didSelectRowObject: rowObject inSection: tableSection];

    if ([rowObject.textLabel isEqualToString: USERVIEW_KEY]) {
        [self performSegueWithIdentifier: @"ProfileSegue" sender: self];
    }
}


- (CGFloat) heightForHeaderInTableSection: (TableSection *) tableSection {
    if ([tableSection.title isEqualToString: @"TopCell"]) {
        return 0;
    }
    return 30;
}


- (UIView *) viewForHeaderInTableSection: (TableSection *) tableSection {

    if ([tableSection.title isEqualToString: @"TopCell"]) {
        return nil;
    }


    BasicTableCell *cell = [table dequeueReusableCellWithIdentifier: @"HeaderCell"];
    //    [cell prettifyWithBackgroundColor: cell.backgroundColor outerBorderColor: cell.backgroundColor];

    //    UIButton *button = [UIButton buttonWithType: UIButtonTypeCustom];
    //    button.backgroundColor = [UIColor blueColor];
    //    [cell.contentView addSubview: button];
    //    button.bounds = cell.bounds;
    //    [button addTarget: self action: @selector(handleYourPlaces:) forControlEvents: UIControlEventTouchUpInside];
    return cell;
}


- (void) handleUserCell: (BasicTextFieldCell *) cell {

    imageView = cell.imageView;
    cell.textLabel.text = _model.currentUser.displayName;
    cell.backgroundView = [[BasicBlackView alloc] init];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.textColor = [UIColor whiteColor];
    cell.captionLabel.textColor = [UIColor whiteColor];
    cell.textField.textColor = [UIColor whiteColor];

    if ([_model.currentUser.college isEqualToString: NO_COLLEGE_KEY]) {
        cell.textField.placeholder = _model.currentUser.college;
    } else {
        cell.textField.text = _model.currentUser.college;
    }

    cell.detailTextLabel.text = @"Class of 2012";
    cell.captionLabel.text = _model.currentUser.major;

    if ([_model.currentUser.major isEqualToString: NO_MAJOR_KEY]) {
        cell.detailTextField.placeholder = _model.currentUser.major;
    } else {
        cell.detailTextField.text = _model.currentUser.major;
    }

    cell.detailTextLabel.text = _model.currentUser.email;
    cell.captionLabel.hidden = YES;

    cell.textField.userInteractionEnabled = NO;
    cell.detailTextField.userInteractionEnabled = NO;
    [self userPictureUpdated];
}

#pragma mark Callbacks

- (void) userPictureUpdated {
    NSString *string = _model.currentUser.photo.smallURL;
    if (string) {
        [imageView setImageWithURL: [NSURL URLWithString: string] placeholderImage: [UIImage newImageFromResource: @"default-user-pic.png"]];
    }
}


- (void) userDidUpdate {
}
@end