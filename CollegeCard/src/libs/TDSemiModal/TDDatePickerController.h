//
//  TDDatePickerController.h
//
//  Created by Nathan  Reed on 30/09/10.
//  Copyright 2010 Nathan Reed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import	"TDSemiModal.h"


@class TDDatePickerController;
@protocol TDDatePickerControllerDelegate <NSObject>


- (void) datePickerSetDate: (TDDatePickerController *) viewController;
- (void) datePickerClearDate: (TDDatePickerController *) viewController;
- (void) datePickerCancel: (TDDatePickerController *) viewController;
@end


@interface TDDatePickerController : TDSemiModalViewController {
    __unsafe_unretained id <TDDatePickerControllerDelegate> delegate;
    NSDate *date;
}


@property(nonatomic, assign) id <TDDatePickerControllerDelegate> delegate;
@property(nonatomic, strong) IBOutlet UIDatePicker *datePicker;
@property(weak, nonatomic) IBOutlet UIToolbar *toolbar;
@property(nonatomic, strong) NSDate *date;
- (IBAction) saveDateEdit: (id) sender;
- (IBAction) clearDateEdit: (id) sender;
- (IBAction) cancelDateEdit: (id) sender;

@end

