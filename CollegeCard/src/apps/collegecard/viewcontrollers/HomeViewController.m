//
// Created by dpostigo on 2/24/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "HomeViewController.h"
#import "UIColor+Utils.h"


@implementation HomeViewController {
}


- (void) viewWillAppear: (BOOL) animated {
    [super viewWillAppear: animated];

    [self.navigationItem setHidesBackButton: YES];
    [self.navigationController setNavigationBarHidden: NO animated: YES];
}


- (void) viewDidLoad {
    [super viewDidLoad];
}


- (void) loadView {
    [super loadView];

    placesButton.borderColor = [UIColor colorWithWhite: 0.9 alpha: 1.0];
    placesButton.topColor = [UIColor whiteColor];
    placesButton.bottomColor = [UIColor colorWithWhite: 0.9 alpha: 1.0];
    placesButton.innerGlow = [UIColor colorWithWhite: 1.0 alpha: 0.5];

    nameLabel.text = _model.currentUser.displayName;
    collegeLabel.text = _model.currentUser.college;

    if ([_model.currentUser.major isEqualToString: NO_MAJOR_KEY]) {
    }
    majorLabel.text = _model.currentUser.major;
}


- (IBAction) handleSettingsButton: (id) sender {
}


- (IBAction) handleCheckin: (id) sender {
}
@end