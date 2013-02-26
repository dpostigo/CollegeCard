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



@interface BasicTableViewController : BasicViewController  {



    IBOutlet UITableView *table;
    BasicTableViewDelegate *tableDelegate;

    __unsafe_unretained NSMutableArray *dataSource;




}

@property(nonatomic, assign) NSMutableArray *dataSource;
@property(nonatomic, strong) IBOutlet UITableView *table;
@property(nonatomic, retain) BasicTableViewDelegate *tableDelegate;


- (void) prepareDataSource;
- (void) registerExternalNibs;
- (NSString *) tableView: (UITableView *) tableView titleForHeaderInSection: (NSInteger) section;
- (CGFloat) heightForFooterInSection: (NSInteger) section;
- (CGFloat) heightForHeaderInSection: (NSInteger) section;
- (UIView *) viewForHeaderInSection: (NSInteger) section;
- (void) didSelectRowAtIndexPath: (NSIndexPath *) indexPath;
- (void) didSelectRowObject: (TableRowObject *) rowObject inSection: (TableSection *) tableSection;
- (UITableViewCell *) tableView: (UITableView *) tableView cellForRowAtIndexPath: (NSIndexPath *) indexPath;

@end