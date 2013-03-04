//
// Created by dpostigo on 2/25/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "PlaceViewController.h"
#import "CheckinOperation.h"
#import "DPProgressHUD.h"
#import "UIColor+Utils.h"
#import "UpdateUserOperation.h"


@implementation PlaceViewController {
}


- (void) loadView {
    [super loadView];

    textLabel.text = _model.currentPlace.name;
    detailTextLabel.text = _model.currentPlace.address;

    self.title = _model.currentPlace.name;
    self.view.backgroundColor = [UIColor colorWithString: WHITE_STRING];

    [self updateSaveButtonState];

    self.imageButton = profileImageButton;
}


#pragma mark IBActions

- (IBAction) handleSaveButton: (id) sender {

    NSLog(@"%s", __PRETTY_FUNCTION__);
    NSMutableArray *savedPlaces = [[NSMutableArray alloc] initWithArray: _model.currentUser.savedPlaces];
    [savedPlaces addObject: _model.currentPlace.objectId];

    NSDictionary *customFields = [NSDictionary dictionaryWithObject: savedPlaces forKey: @"savedPlaces"];
    NSDictionary *paramDict = [NSDictionary dictionaryWithObject: customFields forKey: @"custom_fields"];

    [_queue addOperation: [[UpdateUserOperation alloc] initWithParamDict: paramDict]];
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


- (void) updatedUserForKey: (NSString *) key string: (NSString *) string {
    if ([string isEqualToString: @"savedPlaces"]) {
        NSLog(@"Updated savedPlaces.");
        [self updateSaveButtonState];
    }
}


- (void) updateSaveButtonState {

    BOOL isSaved = [_model.currentUser isSavedPlace: _model.currentPlace.objectId];
    if (isSaved) {
        [saveButton setTitle: @"Saved" forState: UIControlStateNormal];
    } else {

        [saveButton setTitle: @"Save To Your Places" forState: UIControlStateNormal];
    }
}
@end