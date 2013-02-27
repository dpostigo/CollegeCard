//
// Created by dpostigo on 2/27/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "EventEditViewController.h"
#import "TempEvent.h"
#import "NSDateFormatter+JMSimpleDate.h"
#import "BasicTextFieldCell.h"


@implementation EventEditViewController {
}



#pragma mark UITableView

- (void) configureCell: (UITableViewCell *) tableCell forTableSection: (TableSection *) tableSection rowObject: (TableRowObject *) rowObject {
    [super configureCell: tableCell forTableSection: tableSection rowObject: rowObject];

    BasicTextFieldCell *cell = (BasicTextFieldCell *) tableCell;
    cell.textField.text = rowObject.detailTextLabel;

}


- (void) prepareDataSource {

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = [NSString stringWithFormat: @"%@ %@", [NSDateFormatter dateFormatString], [NSDateFormatter timeFormatString]];

    TableSection *tableSection = [[TableSection alloc] initWithTitle: @""];
    [tableSection.rows addObject: [[TableRowObject alloc] initWithTextLabel: @"Name" detailTextLabel: _model.currentEvent.name]];
    [tableSection.rows addObject: [[TableRowObject alloc] initWithTextLabel: @"Start Time" detailTextLabel: [formatter stringFromDate: _model.currentEvent.startTime]]];
    [tableSection.rows addObject: [[TableRowObject alloc] initWithTextLabel: @"End Time" detailTextLabel: [formatter stringFromDate: _model.currentEvent.endTime]]];
    [dataSource addObject: tableSection];
}

#pragma mark Callbacks

- (void) createEventSucceeded: (CCEvent *) event forTempEvent: (TempEvent *) tempEvent {

    if (_model.currentEvent == tempEvent) {
        _model.currentEvent = event;
    }
}

@end