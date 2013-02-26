//
// Created by dpostigo on 2/25/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "PlaceViewController.h"
#import "CheckinOperation.h"


@implementation PlaceViewController {
}


- (void) loadView {
    [super loadView];

    NSLog(@"_model.currentPlace.name = %@", _model.currentPlace.name);
    NSLog(@"textLabel = %@", textLabel);

    textLabel.text = _model.currentPlace.name;
    detailTextLabel.text = _model.currentPlace.address;


}


- (IBAction) handleCheckinButton: (id) sender {

    [_queue addOperation: [[CheckinOperation alloc] initWithPlace: _model.currentPlace]];
}

@end