//
// Created by dpostigo on 12/5/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "BasicViewController.h"
#import "BasicTableViewDelegate.h"
#import "TableRowObject.h"
#import "TableSection.h"


@interface BasicTableViewController : BasicViewController {

    CGFloat rowSpacing;
    IBOutlet UITableView *table;
    BasicTableViewDelegate *tableDelegate;
    __unsafe_unretained NSMutableArray *dataSource;
}


@property(nonatomic, assign) NSMutableArray *dataSource;
@property(nonatomic, strong) IBOutlet UITableView *table;
@property(nonatomic, retain) BasicTableViewDelegate *tableDelegate;
@property(nonatomic) CGFloat rowSpacing;
- (void) prepareDataSource;
- (void) registerExternalNibs;
- (void) sizeTableToFit;
- (NSInteger) numberOfSections;
- (NSInteger) numberOfRowsInSection: (NSInteger) section;
- (NSString *) tableView: (UITableView *) tableView titleForHeaderInSection: (NSInteger) section;
- (CGFloat) heightForRowAtIndexPath: (NSIndexPath *) indexPath;
- (CGFloat) heightForFooterInSection: (NSInteger) section;
- (CGFloat) heightForHeaderInSection: (NSInteger) section;
- (UIView *) viewForHeaderInSection: (NSInteger) section;
- (void) didSelectRowAtIndexPath: (NSIndexPath *) indexPath;
- (void) didSelectRowObject: (TableRowObject *) rowObject inSection: (TableSection *) tableSection;
- (UITableViewCell *) tableView: (UITableView *) tableView cellForRowAtIndexPath: (NSIndexPath *) indexPath;
- (UITableViewCell *) tableCellForIndexPath: (NSIndexPath *) indexPath;
- (void) configureCell: (UITableViewCell *) tableCell forTableSection: (TableSection *) tableSection rowObject: (TableRowObject *) rowObject;

@end