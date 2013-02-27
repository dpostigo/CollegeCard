//
// Created by dpostigo on 2/25/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "PlaceViewController.h"
#import "CheckinOperation.h"
#import "DPProgressHUD.h"
#import "UIColor+Utils.h"


@implementation PlaceViewController {
}


- (void) loadView {
    [super loadView];

    NSLog(@"_model.currentPlace.name = %@", _model.currentPlace.name);
    NSLog(@"textLabel = %@", textLabel);

    textLabel.text = _model.currentPlace.name;
    detailTextLabel.text = _model.currentPlace.address;

    self.title = _model.currentPlace.name;
    self.view.backgroundColor = [UIColor colorWithString: WHITE_STRING];
}


- (IBAction) handleCheckinButton: (id) sender {

    [DPProgressHUD showWithStatus: @"Checking in..."];
    [_queue addOperation: [[CheckinOperation alloc] initWithPlace: _model.currentPlace]];
}


#pragma mark Callbacks


- (void) checkinSucceeded {
    [DPProgressHUD dismiss];

    [UIView animateWithDuration: 0.5 delay: 0.0 options: UIViewAnimationOptionCurveEaseInOut animations: ^{
        checkinButton.alpha = 0;
    }                completion: nil];
}

@end