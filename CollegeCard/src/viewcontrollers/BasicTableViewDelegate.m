//
// Created by dpostigo on 2/24/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "BasicTableViewDelegate.h"


@implementation BasicTableViewDelegate {
}


@synthesize dataSource;
@synthesize viewController;


- (id) init {
    self = [super init];
    if (self) {
        self.dataSource = [[NSMutableArray alloc] init];
    }

    return self;
}


- (id) initWithViewController: (id <BasicTableViewControllerProtocol>) aViewController {
    self = [super init];
    if (self) {
        viewController = aViewController;
        self.dataSource = [[NSMutableArray alloc] init];
    }

    return self;
}


- (NSInteger) numberOfSectionsInTableView: (UITableView *) tableView {
    return [dataSource count];
}


- (NSInteger) tableView: (UITableView *) tableView numberOfRowsInSection: (NSInteger) section {
    TableSection *tableSection = [dataSource objectAtIndex: section];
    return [tableSection.rows count];
}


- (NSString *) tableView: (UITableView *) tableView titleForHeaderInSection: (NSInteger) section {
    return [viewController tableView: tableView titleForHeaderInSection: section];
}


- (CGFloat) tableView: (UITableView *) tableView heightForFooterInSection: (NSInteger) section {
    return [viewController heightForFooterInSection: section];
}


- (CGFloat) tableView: (UITableView *) tableView heightForHeaderInSection: (NSInteger) section {
    return [viewController heightForHeaderInSection: section];
}


- (UIView *) tableView: (UITableView *) tableView viewForFooterInSection: (NSInteger) section {
    return [viewController viewForFooterInSection: section];
}


- (UIView *) tableView: (UITableView *) tableView viewForHeaderInSection: (NSInteger) section {
    return [viewController viewForHeaderInSection: section];
}


- (UITableViewCell *) tableView: (UITableView *) tableView cellForRowAtIndexPath: (NSIndexPath *) indexPath {
    TableSection *tableSection = [dataSource objectAtIndex: indexPath.section];
    TableRowObject *rowObject = [tableSection.rows objectAtIndex: indexPath.row];


    UITableViewCell *cell = nil;
    if ([viewController respondsToSelector: @selector(tableView:cellForRowAtIndexPath:)]) {
        cell = [viewController performSelector: @selector(tableView:cellForRowAtIndexPath:) withObject: tableView withObject: indexPath];
    } else {

        cell = [tableView dequeueReusableCellWithIdentifier: @"TableCell" forIndexPath: indexPath];
        cell.textLabel.text = rowObject.textLabel;
    }

    return cell;
}


- (void) tableView: (UITableView *) tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath {
    TableSection *tableSection = [dataSource objectAtIndex: indexPath.section];
    TableRowObject *rowObject = [tableSection.rows objectAtIndex: indexPath.row];

//    [viewController didSelectRowAtIndexPath: indexPath];
    [viewController didSelectRowObject: rowObject inSection: tableSection];
}

@end