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

        dateCell.startTimeLabel.text = [self.dateFormatter stringFromDate: dateRowObject.date];
        dateCell.startTimeLabel.text = [self.dateFormatter stringFromDate: dateRowObject.date];
        //        dateCell.endTimeLabel.text = [self.dateFormatter stringFromDate: dateRowObject.endTime];

        return;
    }

    BasicTextFieldCell *cell = (BasicTextFieldCell *) tableCell;
    cell.textField.text = rowObject.detailTextLabel;
    if ([cell.textField isKindOfClass: [TableTextField class]]) {
        TableTextField *textField = (TableTextField *) cell.textField;
        textField.rowObject = rowObject;
    }
    [self subscribeTextField: cell.textField];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    //    cell.accessoryView = [[UIImageView alloc] initWithImage: [UIImage newImageFromResource: @"edit-icon.png"]];
}


- (void) prepareDataSource {
    TableSection *tableSection = [[TableSection alloc] initWithTitle: @""];
    [tableSection.rows addObject: [[TableRowObject alloc] initWithTextLabel: @"Name" detailTextLabel: _model.currentEvent.name]];
    [tableSection.rows addObject: [[DateRowObject alloc] initWithTextLabel: @"Starts" date: _model.currentEvent.startTime cellIdentifier: @"DateCell"]];
    [tableSection.rows addObject: [[DateRowObject alloc] initWithTextLabel: @"Ends" date: _model.currentEvent.endTime cellIdentifier: @"DateCell"]];
    [dataSource addObject: tableSection];
}


- (CGFloat) heightForTableRow: (TableRowObject *) rowObject inSection: (TableSection *) section {
    if ([rowObject.cellIdentifier isEqualToString: @"DateCell"]) {
        return 100;
    }
    return [super heightForTableRow: rowObject inSection: section];
}


- (void) didSelectRowObject: (TableRowObject *) rowObject inSection: (TableSection *) tableSection {
    [super didSelectRowObject: rowObject inSection: tableSection];

    if ([rowObject.cellIdentifier isEqualToString: @"DateCell"]) {
        [self showDatePicker: nil];
    }
}


#pragma mark UIDatePickerView

- (void) showDatePicker: (id) sender {
    datePickerView = [[TDDatePickerController alloc] initWithNibName: @"TDDatePickerController" bundle: nil];
    datePickerView.delegate = self;
    [self presentSemiModalViewController: datePickerView];
}


- (void) datePickerSetDate: (TDDatePickerController *) viewController; {
}


- (void) datePickerClearDate: (TDDatePickerController *) viewController; {
}


- (void) datePickerCancel: (TDDatePickerController *) viewController; {
    [self dismissSemiModalViewController: datePickerView];
}


- (void) pickerView: (UIPickerView *) pickerView didSelectRow: (NSInteger) row inComponent: (NSInteger) component {
}




#pragma mark Callbacks

- (void) createEventSucceeded: (CCEvent *) event forTempEvent: (TempEvent *) tempEvent {
    if (_model.currentEvent == tempEvent) {
        _model.currentEvent = event;
    }
}


- (void) eventDidUpdate: (CCEvent *) event {
}


- (void) tableTextFieldEndedEditing: (TableTextField *) tableTextField {
    [super tableTextFieldEndedEditing: tableTextField];

    tableTextField.rowObject.stringContent = tableTextField.text;

    TableSection *tableSection = [dataSource objectAtIndex: 0];
    TableRowObject *rowObject;
    NSString *eventName = [tableSection tableRowObjectForString: @"Name"].stringContent;
    NSDate *startTime = [formatter dateFromString: [tableSection tableRowObjectForString: @"Start Time"].stringContent];
    NSMutableDictionary *paramDict = [[NSMutableDictionary alloc] init];
    [paramDict setObject: _model.currentEvent.objectId forKey: @"event_id"];
    [paramDict setObject: eventName forKey: @"name"];
    [paramDict setObject: startTime forKey: @"start_time"];

    [_queue addOperation: [[UpdateEventOperation alloc] initWithParamDict: paramDict]];
}

@end