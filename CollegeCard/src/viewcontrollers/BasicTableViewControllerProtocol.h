//
// Created by dpostigo on 2/24/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "TableRowObject.h"
#import "TableSection.h"


@protocol BasicTableViewControllerProtocol <NSObject>


@required

- (void) prepareDataSource;
- (void) registerExternalNibs;

@optional

- (NSInteger) numberOfRowsInSection: (NSInteger) section;
- (NSInteger) numberOfSections;

- (UITableViewCell *) tableView: (UITableView *) tableView cellForRowAtIndexPath: (NSIndexPath *) indexPath;
- (UIView *) tableView: (UITableView *) tableView viewForFooterInSection: (NSInteger) section;
- (NSString *) tableView: (UITableView *) tableView titleForHeaderInSection: (NSInteger) section;
- (CGFloat) heightForFooterInSection: (NSInteger) section;
- (CGFloat) heightForHeaderInSection: (NSInteger) section;
- (CGFloat) heightForRowAtIndexPath: (NSIndexPath *) indexPath;

- (UIView *) viewForFooterInSection: (NSInteger) section;
- (UIView *) viewForHeaderInSection: (NSInteger) section;


- (void) didSelectRowAtIndexPath: (NSIndexPath *) indexPath;
- (void) didSelectRowObject: (TableRowObject *) rowObject inSection: (TableSection *) tableSection;
    - (UITableViewCell *) cellForRowObject: (TableRowObject *) rowObject inSection: (TableSection *) tableSection;

@end


