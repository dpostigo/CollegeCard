//
// Created by dpostigo on 2/26/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "BasicPlaceViewController.h"
#import "PlaceRowObject.h"
#import "BasicWhiteView.h"
#import "BasicTextFieldCell.h"


@implementation BasicPlaceViewController {
}




#pragma mark Callbacks -

- (void) searchSucceededWithPlaces: (NSArray *) places {

    if (self.navigationController.visibleViewController != self) {
        return;
    }

    [dataSource removeAllObjects];
    TableSection *tableSection = [[TableSection alloc] initWithTitle: @""];

    if ([places count] == 0) {
        [tableSection.rows addObject: [[TableRowObject alloc] initWithTextLabel: NO_MERCHANTS_FOUND_KEY]];
    } else {
        for (CCPlaceCocoafish *place in places) {
            [tableSection.rows addObject: [[PlaceRowObject alloc] initWithPlace: place]];
        }
    }

    [dataSource addObject: tableSection];
    [table reloadSections: [NSIndexSet indexSetWithIndex: 0] withRowAnimation: UITableViewRowAnimationFade];
}




#pragma mark UITableView -




- (UITableViewCell *) tableView: (UITableView *) tableView cellForRowAtIndexPath: (NSIndexPath *) indexPath {

    TableSection *tableSection = [dataSource objectAtIndex: indexPath.section];
    TableRowObject *rowObject = [tableSection.rows objectAtIndex: indexPath.row];
    BasicTextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier: @"TableCell" forIndexPath: indexPath];

    if ([rowObject isKindOfClass: [PlaceRowObject class]]) {

        PlaceRowObject *placeObject = (PlaceRowObject *) rowObject;
        CCPlaceCocoafish *place = placeObject.place;
        cell.textLabel.text = place.name;
        cell.detailTextLabel.text = place.fullAddress;
        cell.accessoryView = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"arrow-right-dark.png"]];
        cell.backgroundView = [[BasicWhiteView alloc] initWithFrame: cell.bounds];
        cell.textLabel.textAlignment = NSTextAlignmentLeft;
    } else {

        cell.textLabel.text = rowObject.textLabel;
        cell.detailTextLabel.text = rowObject.detailTextLabel;
        cell.textLabel.textAlignment = NSTextAlignmentCenter;

        if ([rowObject.textLabel isEqualToString: NO_MERCHANTS_FOUND_KEY] || [rowObject.textLabel isEqualToString: ENTER_SEARCH_KEY]) {
            cell.textField.font = [UIFont fontWithName: @"HelveticaNeue-Italic" size: cell.textLabel.font.pointSize];
        }
    }

    return cell;
}


- (void) didSelectRowObject: (TableRowObject *) rowObject inSection: (TableSection *) tableSection {
    [super didSelectRowObject: rowObject inSection: tableSection];

    if ([rowObject isKindOfClass: [PlaceRowObject class]]) {
        PlaceRowObject *placeRowObject = (PlaceRowObject *) rowObject;
        CCPlaceCocoafish *place = placeRowObject.place;
        _model.currentPlace = place;

        [self performSegueWithIdentifier: @"PlaceSegue" sender: self];
    }
}

@end