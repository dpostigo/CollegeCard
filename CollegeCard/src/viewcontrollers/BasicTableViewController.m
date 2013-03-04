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
#import "TableTextField.h"


@implementation BasicTableViewController {
}


@synthesize table;
@synthesize tableDelegate;
@synthesize dataSource;
@synthesize rowSpacing;
@synthesize editingEnabled;


- (id) initWithCoder: (NSCoder *) aDecoder {
    self = [super initWithCoder: aDecoder];
    if (self) {
        self.rowSpacing = 0;
    }

    return self;
}


- (void) viewDidAppear: (BOOL) animated {
    [super viewDidAppear: animated];
    [table deselectRowAtIndexPath: [table indexPathForSelectedRow] animated: YES];
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

    TableSection *tableSection;
    TableRowObject *rowObject;

    if (rowSpacing > 0) {
        if (indexPath.row % 2 != 0) return rowSpacing;
        else {
            tableSection = [dataSource objectAtIndex: indexPath.section];
            rowObject = [tableSection.rows objectAtIndex: indexPath.row / 2];
        }
    }
    else {
        tableSection = [dataSource objectAtIndex: indexPath.section];
        rowObject = [tableSection.rows objectAtIndex: indexPath.row];
    }

    return [self heightForTableRow: rowObject inSection: tableSection];
}


- (CGFloat) heightForTableRow: (TableRowObject *) rowObject inSection: (TableSection *) section {
    return table.rowHeight;
}


- (CGFloat) heightForFooterInSection: (NSInteger) section {
    return 0;
}


- (CGFloat) heightForHeaderInSection: (NSInteger) section {
    TableSection *tableSection = [dataSource objectAtIndex: section];
    if (tableSection) {
        return [self heightForHeaderInTableSection: tableSection];
    }
    return 0;
}


- (CGFloat) heightForHeaderInTableSection: (TableSection *) tableSection {
    return 0;
}


- (UIView *) viewForFooterInSection: (NSInteger) section {
    return nil;
}


- (UIView *) viewForHeaderInSection: (NSInteger) section {
    TableSection *tableSection = [dataSource objectAtIndex: section];
    if (tableSection) {
        return [self viewForHeaderInTableSection: tableSection];
    }
    return nil;
}


- (UIView *) viewForHeaderInTableSection: (TableSection *) tableSection {
    return nil;
}


- (void) didSelectRowAtIndexPath: (NSIndexPath *) indexPath {

    TableSection *tableSection;
    TableRowObject *rowObject;
    NSLog(@"indexPath = %@", indexPath);

    if (rowSpacing > 0) {
        if (indexPath.row % 2 == 0) {
            tableSection = [dataSource objectAtIndex: indexPath.section];
            rowObject = [tableSection.rows objectAtIndex: indexPath.row / 2];
            [self didSelectRowObject: rowObject inSection: tableSection];
        } else {

            [table deselectRowAtIndexPath: indexPath animated: NO];
        }
    }
    else {

        tableSection = [dataSource objectAtIndex: indexPath.section];
        rowObject = [tableSection.rows objectAtIndex: indexPath.row];
        [self didSelectRowObject: rowObject inSection: tableSection];
    }
}


- (void) didSelectRowObject: (TableRowObject *) rowObject
                  inSection: (TableSection *) tableSection {
}


// Sample implementation
- (UITableViewCell *) tableView: (UITableView *) tableView
          cellForRowAtIndexPath: (NSIndexPath *) indexPath {

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
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
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


- (void) configureCell: (UITableViewCell *) tableCell
       forTableSection: (TableSection *) tableSection
             rowObject: (TableRowObject *) rowObject {
    tableCell.textLabel.text = rowObject.textLabel;
}


#pragma mark Deleting

- (void) shouldDeleteRowAtIndexPath: (NSIndexPath *) indexPath {

    TableSection *tableSection = [dataSource objectAtIndex: indexPath.section];
    TableRowObject *rowObject = [self rowObjectForRow: indexPath.row inSection: tableSection];

    if (rowObject != nil) {
        [self shouldDeleteRow: rowObject inSection: tableSection];
        [self shouldDeleteAtRow: indexPath.row inSection: indexPath.section];
    }
}


- (void) shouldDeleteRow: (TableRowObject *) rowObject inSection: (TableSection *) tableSection {
}


- (void) shouldDeleteAtRow: (NSInteger) row inSection: (NSInteger) section {
}


- (void) deleteRowObject: (TableRowObject *) rowObject inSection: (TableSection *) tableSection animation: (UITableViewRowAnimation) rowAnimation {

    NSInteger row = [tableSection.rows indexOfObject: rowObject];
    NSInteger section = [dataSource indexOfObject: tableSection];
    [tableSection.rows removeObjectAtIndex: row];

    NSArray *indexPaths;
    if (self.rowSpacing > 0) {

        indexPaths = [NSArray arrayWithObjects: [NSIndexPath indexPathForRow: row inSection: section],
                                                [NSIndexPath indexPathForRow: row + 1 inSection: section],
                                                nil];
    } else {
        indexPaths = [NSArray arrayWithObject: [NSIndexPath indexPathForRow: row inSection: section]];
    }
    [table deleteRowsAtIndexPaths: indexPaths withRowAnimation: rowAnimation];
}


- (TableRowObject *) rowObjectForRow: (NSInteger) row inSection: (TableSection *) tableSection {
    TableRowObject *rowObject;
    if (rowSpacing > 0) {
        if (row % 2 == 0) {
            rowObject = [tableSection.rows objectAtIndex: row / 2];
        } else {
            return nil;
        }
    } else {
        rowObject = [tableSection.rows objectAtIndex: row];
    }
    return rowObject;
}

#pragma mark TextFields

- (void) textFieldEndedEditing: (UITextField *) aTextField {
    [super textFieldEndedEditing: aTextField];

    if ([aTextField isKindOfClass: [TableTextField class]]) {
        TableTextField *tableTextField = (TableTextField *) aTextField;
        [self tableTextFieldEndedEditing: tableTextField];
    }
}


- (void) tableTextFieldEndedEditing: (TableTextField *) tableTextField {
}


#pragma mark Convenience

- (TableSection *) tableSectionForTitle: (NSString *) title {
    for (TableSection *tableSection in dataSource) {
        if ([tableSection.title isEqualToString: title]) {
            return tableSection;
        }
    }
    return nil;
}


- (NSInteger) indexOfTableSectionWithTitle: (NSString *) title {
    TableSection *tableSection = [self tableSectionForTitle: title];
    if (tableSection) return [dataSource indexOfObject: tableSection];
    return nil;
}


- (void) addTopSpacing {
    table.tableHeaderView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, table.width, 10)];
}

@end