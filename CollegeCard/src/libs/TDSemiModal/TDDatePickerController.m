//
//  TDDatePickerController.m
//
//  Created by Nathan  Reed on 30/09/10.
//  Copyright 2010 Nathan Reed. All rights reserved.
//

#import "TDDatePickerController.h"


@implementation TDDatePickerController


@synthesize datePicker, delegate;
@synthesize date;


- (void) viewDidLoad {
    [super viewDidLoad];


    datePicker.date = self.date;
    // we need to set the subview dimensions or it will not always render correctly
    // http://stackoverflow.com/questions/1088163
    for (UIView *subview in datePicker.subviews) {
        subview.frame = datePicker.bounds;
    }
}


- (BOOL) shouldAutorotate {
    return YES;
}


- (BOOL) shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation) interfaceOrientation {
    return YES;
}

#pragma mark -
#pragma mark Actions

- (IBAction) saveDateEdit: (id) sender {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    if (delegate && [delegate respondsToSelector: @selector(datePickerSetDate:)]) {
        [delegate performSelector: @selector(datePickerSetDate:) withObject: self];
    }
}


- (IBAction) clearDateEdit: (id) sender {
    if ([delegate respondsToSelector: @selector(datePickerClearDate:)]) {
        [delegate datePickerClearDate: self];
    }
}


- (IBAction) cancelDateEdit: (id) sender {
    if ([delegate respondsToSelector: @selector(datePickerCancel:)]) {
        [delegate datePickerCancel: self];
    } else {
        // just dismiss the view automatically?
    }
}

#pragma mark -
#pragma mark Memory Management

- (void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void) viewDidUnload {
    [self setToolbar: nil];
    [super viewDidUnload];

    self.datePicker = nil;
    self.delegate = nil;
}

@end


