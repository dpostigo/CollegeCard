//
// Created by dpostigo on 2/27/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "EventEditViewController.h"
#import "TempEvent.h"
#import "NSDateFormatter+JMSimpleDate.h"
#import "BasicTextFieldCell.h"
#import "UIImage+Utils.h"
#import "CCRequest.h"
#import "UpdateEventOperation.h"
#import "TableTextField.h"
#import "TableSection+Utils.h"
#import "DateRowObject.h"
#import "DateCell.h"
#import "TDSemiModal.h"
#import "TDDatePickerController.h"
#import "BasicWhiteView.h"
#import "NSDate+JMSimpleDate.h"
#import "SwitchCell.h"


#define START_DATE_KEY @"Starts"

#define END_DATE_KEY @"Ends"

#define EVENT_NAME_KEY @"Name"


@implementation EventEditViewController {
    NSDateFormatter *formatter;
    TDDatePickerController *datePickerView;
}


- (void) loadView {
    self.rowSpacing = 10;
    [super loadView];
}


- (NSDateFormatter *) dateFormatter {
    if (formatter == nil) {
        formatter = [[NSDateFormatter alloc] init];
        formatter.dateStyle = NSDateFormatterMediumStyle;
        formatter.timeStyle = NSDateFormatterShortStyle;
    }
    return formatter;
}

#pragma mark UITableView

- (void) configureCell: (UITableViewCell *) tableCell forTableSection: (TableSection *) tableSection rowObject: (TableRowObject *) rowObject {
    [super configureCell: tableCell forTableSection: tableSection rowObject: rowObject];

    if ([rowObject.cellIdentifier isEqualToString: @"DateCell"]) {
        DateRowObject *dateRowObject = (DateRowObject *) rowObject;
        DateCell *dateCell = (DateCell *) tableCell;

        dateCell.backgroundView = [[BasicWhiteView alloc] init];
        dateCell.dateLabel.text = [self.dateFormatter stringFromDate: dateRowObject.date];

        return;
    }

    if ([rowObject.cellIdentifier isEqualToString: @"SwitchCell"]) {
        SwitchCell *switchCell = (SwitchCell *) tableCell;
        switchCell.textLabel.text = rowObject.textLabel;
        [switchCell.cellSwitch addTarget: self action: @selector(handleSwitch:) forControlEvents: UIControlEventTouchUpInside];
        switchCell.cellSwitch.on = _model.currentEvent.isPublished;
        return;
    }

    BasicTextFieldCell *cell = (BasicTextFieldCell *) tableCell;
    cell.textField.text = rowObject.detailTextLabel;
    if ([cell.textField isKindOfClass: [TableTextField class]]) {
        TableTextField *textField = (TableTextField *) cell.textField;
        textField.rowObject = rowObject;
        textField.rowObject.stringContent = rowObject.detailTextLabel;
    }
    [self subscribeTextField: cell.textField];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    //    cell.accessoryView = [[UIImageView alloc] initWithImage: [UIImage newImageFromResource: @"edit-icon.png"]];
}


- (void) prepareDataSource {
    TableSection *tableSection = [[TableSection alloc] initWithTitle: @""];
    [tableSection.rows addObject: [[TableRowObject alloc] initWithTextLabel: EVENT_NAME_KEY detailTextLabel: _model.currentEvent.name]];
    [tableSection.rows addObject: [[DateRowObject alloc] initWithTextLabel: START_DATE_KEY date: _model.currentEvent.startTime cellIdentifier: @"DateCell"]];
    [tableSection.rows addObject: [[DateRowObject alloc] initWithTextLabel: END_DATE_KEY date: _model.currentEvent.endTime cellIdentifier: @"DateCell"]];
    [tableSection.rows addObject: [[TableRowObject alloc] initWithTextLabel: @"Published" detailTextLabel: _model.currentEvent.name cellIdentifier: @"SwitchCell"]];
    [dataSource addObject: tableSection];
}


- (CGFloat) heightForTableRow: (TableRowObject *) rowObject inSection: (TableSection *) section {
    if ([rowObject.cellIdentifier isEqualToString: @"DateCell"]) {
        return 44;
    }
    return [super heightForTableRow: rowObject inSection: section];
}


- (void) didSelectRowObject: (TableRowObject *) rowObject inSection: (TableSection *) tableSection {
    [super didSelectRowObject: rowObject inSection: tableSection];

    if ([rowObject.cellIdentifier isEqualToString: @"DateCell"]) {
        DateRowObject *dateRowObject = (DateRowObject *) rowObject;
        [self showDatePickerWithDate: dateRowObject.date];
    }
}


#pragma mark UIDatePickerView

- (void) showDatePickerWithDate: (NSDate *) date {
    datePickerView = [[TDDatePickerController alloc] initWithNibName: @"TDDatePickerController" bundle: nil];
    datePickerView.delegate = self;
    datePickerView.date = date;
    [self presentSemiModalViewController: datePickerView];
}


- (void) datePickerSetDate: (TDDatePickerController *) viewController; {

    NSIndexPath *indexPath = [table indexPathForSelectedRow];
    TableSection *tableSection = [dataSource objectAtIndex: 0];
    DateRowObject *rowObject = (DateRowObject *) [self rowObjectForRow: indexPath.row inSection: tableSection];
    rowObject.date = viewController.datePicker.date;

    if ([rowObject.textLabel isEqualToString: START_DATE_KEY]) {
        DateRowObject *endsRowObject = (DateRowObject *) [tableSection tableRowObjectForString: END_DATE_KEY];
        if ([endsRowObject.date isEarlierThanDate: rowObject.date]) {
            endsRowObject.date = [rowObject.date dateByAddingHours: 1];
        }
    }
    [self updateEventObject];
    [self dismissSemiModalViewController: viewController];
}


- (void) datePickerClearDate: (TDDatePickerController *) viewController; {
}


- (void) datePickerCancel: (TDDatePickerController *) viewController; {
    [self dismissSemiModalViewController: viewController];
}

#pragma mark Switch

- (void) handleSwitch: (id) sender {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

#pragma mark TextFields


- (void) tableTextFieldEndedEditing: (TableTextField *) tableTextField {
    [super tableTextFieldEndedEditing: tableTextField];

    tableTextField.rowObject.stringContent = tableTextField.text;
    [self updateEventObject];
}


- (void) updateEventObject {
    TableSection *tableSection = [dataSource objectAtIndex: 0];
    TableRowObject *rowObject;
    NSString *eventName = [tableSection tableRowObjectForString: EVENT_NAME_KEY].stringContent;
    NSLog(@"eventName = %@", eventName);
    DateRowObject *startRowObject = (DateRowObject *) [tableSection tableRowObjectForString: START_DATE_KEY];
    DateRowObject *endRowObject = (DateRowObject *) [tableSection tableRowObjectForString: END_DATE_KEY];
    NSMutableDictionary *paramDict = [[NSMutableDictionary alloc] init];
    [paramDict setObject: _model.currentEvent.objectId forKey: @"event_id"];
    [paramDict setObject: eventName forKey: @"name"];
    [paramDict setObject: startRowObject.date forKey: @"start_time"];
    [paramDict setObject: endRowObject.date forKey: @"end_time"];
    [_queue addOperation: [[UpdateEventOperation alloc] initWithParamDict: paramDict]];
}


#pragma mark Callbacks

- (void) createEventSucceeded: (CCEvent *) event forTempEvent: (TempEvent *) tempEvent {
    if (_model.currentEvent == tempEvent) {
        _model.currentEvent = event;
    }
}


- (void) eventDidUpdate: (CCEvent *) event {

    [table reloadSections: [NSIndexSet indexSetWithIndex: 0] withRowAnimation: UITableViewRowAnimationFade];
}

@end