//
// Created by dpostigo on 12/5/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "BasicTableViewController.h"
#import "TableSection.h"
#import "TableRowObject.h"


@implementation BasicTableViewController {
}


@synthesize table;
@synthesize tableDelegate;
@synthesize dataSource;


- (id) initWithCoder: (NSCoder *) aDecoder {
    self = [super initWithCoder: aDecoder];
    if (self) {
        NSLog(@"%s", __PRETTY_FUNCTION__);
    }

    return self;
}


- (void) viewDidLoad {
    [super viewDidLoad];

    if (table.style == UITableViewStyleGrouped) {
        table.backgroundView = [[UIView alloc] init];
    }

    tableDelegate = [[BasicTableViewDelegate alloc] initWithViewController: self];
    table.delegate = tableDelegate;
    table.dataSource = tableDelegate;

    self.dataSource = tableDelegate.dataSource;

    [self prepareDataSource];
    [self registerExternalNibs];

    [table reloadData];
}


- (void) prepareDataSource {
    TableSection *tableSection = [[TableSection alloc] initWithTitle: @""];
    [tableSection.rows addObject: [[TableRowObject alloc] initWithTextLabel: @"Text Label"]];
    [self.dataSource addObject: tableSection];
}


- (void) registerExternalNibs {
}


- (NSString *) tableView: (UITableView *) tableView titleForHeaderInSection: (NSInteger) section {
    return nil;
}


- (CGFloat) heightForFooterInSection: (NSInteger) section {
    return 0;
}


- (CGFloat) heightForHeaderInSection: (NSInteger) section {
    return 0;
}


- (UIView *) viewForFooterInSection: (NSInteger) section {
    return nil;
}


- (UIView *) viewForHeaderInSection: (NSInteger) section {
    return nil;
}


- (void) didSelectRowAtIndexPath: (NSIndexPath *) indexPath {
    TableSection *tableSection = [dataSource objectAtIndex: indexPath.section];
    TableRowObject *rowObject = [tableSection.rows objectAtIndex: indexPath.row];
    [self didSelectRowObject: rowObject inSection: tableSection];
}


- (void) didSelectRowObject: (TableRowObject *) rowObject inSection: (TableSection *) tableSection {
}


- (void) viewDidAppear: (BOOL) animated {
    [super viewDidAppear: animated];
    [table deselectRowAtIndexPath: [table indexPathForSelectedRow] animated: YES];
}



// Sample implementation
- (UITableViewCell *) tableView: (UITableView *) tableView cellForRowAtIndexPath: (NSIndexPath *) indexPath {

    TableSection *tableSection = [dataSource objectAtIndex: indexPath.section];
    TableRowObject *rowObject = [tableSection.rows objectAtIndex: indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"TableCell" forIndexPath: indexPath];
    cell.textLabel.text = rowObject.textLabel;
    return cell;
}

@end