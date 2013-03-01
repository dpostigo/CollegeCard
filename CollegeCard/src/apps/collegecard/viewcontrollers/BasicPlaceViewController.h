//
// Created by dpostigo on 2/26/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "BasicLocationViewController.h"


@interface BasicPlaceViewController : BasicLocationViewController {

}


- (void) searchSucceededWithPlaces: (NSArray *) places;
- (UITableViewCell *) tableView: (UITableView *) tableView cellForRowAtIndexPath: (NSIndexPath *) indexPath;
- (void) didSelectRowObject: (TableRowObject *) rowObject inSection: (TableSection *) tableSection;

@end