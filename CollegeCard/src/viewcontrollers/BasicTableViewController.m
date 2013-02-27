//
// Created by dpostigo on 12/5/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "BasicTableViewController.h"
#import "TableSection.h"
#import "TableRowObject.h"
#import "BasicTextFieldCell.h"
#import "BlankCell.h"
#import "BasicWhiteView.h"


@implementation BasicTableViewController {
}


@synthesize table;
@synthesize tableDelegate;
@synthesize dataSource;
@synthesize rowSpacing;


- (id) initWithCoder: (NSCoder *) aDecoder {
    self = [super initWithCoder: aDecoder];
    if (self) {
        self.rowSpacing = 0;
    }

    return self;
}


- (void) loadView {
    [super loadView];
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


- (void) viewDidLoad {
    [super viewDidLoad];
}


- (void) prepareDataSource {
    TableSection *tableSection = [[TableSection alloc] initWithTitle: @""];
    [tableSection.rows addObject: [[TableRowObject alloc] initWithTextLabel: @"Text Label"]];
    [self.dataSource addObject: tableSection];
}


- (void) registerExternalNibs {
    [table registerClass: [BlankCell class] forCellReuseIdentifier: @"BlankCell"];
}


- (void) sizeTableToFit {

    NSInteger numSections = [table numberOfSections];
    CGFloat cumHeight;
    for (int j = 0; j < numSections; j++) {
        NSInteger numRows = [table numberOfRowsInSection: j];
        for (int k = 0; k < numRows; k++) {
            cumHeight += [self heightForRowAtIndexPath: [NSIndexPath indexPathForRow: k inSection: j]];
        }
    }

    CGFloat tableHeight = table.height;
    table.height = cumHeight;

    if ([[table superview] isKindOfClass: [BasicWhiteView class]]) {

        CGFloat margin = 15;
        table.top = margin;
        table.left = margin;
        table.width = table.superview.width - (margin * 2);
        CGFloat topGap = table.top;
        CGFloat bottomGap = table.superview.height - table.bottom;

        if (bottomGap > topGap) {
            CGFloat diff = bottomGap - topGap;
            table.superview.height -= diff;
        }
    }
    table.height = tableHeight;
}

#pragma mark UITableViewDataSource


- (NSInteger) numberOfSections {
    return [dataSource count];
}


- (NSInteger) numberOfRowsInSection: (NSInteger) section {
    TableSection *tableSection = [dataSource objectAtIndex: section];
    return [tableSection.rows count] * (rowSpacing == 0 ? 1: 2);
}


- (NSString *) tableView: (UITableView *) tableView titleForHeaderInSection: (NSInteger) section {
    return nil;
}


- (CGFloat) heightForRowAtIndexPath: (NSIndexPath *) indexPath {
    if (rowSpacing > 0 && indexPath.row % 2 != 0) {
        return rowSpacing;
    }
    return table.rowHeight;
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

    UITableViewCell *cell;
    BOOL isOdd = (indexPath.row % 2 != 0);
    if (rowSpacing == 0 || !isOdd) {
        cell = [self tableCellForIndexPath: indexPath];
        return cell;
    }
    else {
        cell = [self blankCellForIndexPath: indexPath];
    }

    return cell;
}


- (UITableViewCell *) blankCellForIndexPath: (NSIndexPath *) indexPath {
    UITableViewCell *cell = [table dequeueReusableCellWithIdentifier: @"BlankCell" forIndexPath: indexPath];
    return cell;
}


- (UITableViewCell *) tableCellForIndexPath: (NSIndexPath *) indexPath {
    TableSection *tableSection;
    TableRowObject *rowObject;

    if (rowSpacing == 0) {
        tableSection = [dataSource objectAtIndex: indexPath.section];
        rowObject = [tableSection.rows objectAtIndex: indexPath.row];
    } else {
        tableSection = [dataSource objectAtIndex: indexPath.section];
        rowObject = [tableSection.rows objectAtIndex: (indexPath.row / 2)];
    }

    UITableViewCell *cell;
    if (rowObject.cellIdentifier == nil) {
        cell = [table dequeueReusableCellWithIdentifier: @"TableCell" forIndexPath: indexPath];
    } else {
        cell = [table dequeueReusableCellWithIdentifier: rowObject.cellIdentifier forIndexPath: indexPath];
    }
    [self configureCell: cell forTableSection: tableSection rowObject: rowObject];
    return cell;
}


- (void) configureCell: (UITableViewCell *) tableCell forTableSection: (TableSection *) tableSection rowObject: (TableRowObject *) rowObject {
    tableCell.textLabel.text = rowObject.textLabel;
}

@end