//
// Created by dpostigo on 12/17/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <QuartzCore/QuartzCore.h>
#import "FadePopSegue.h"


@implementation FadePopSegue {
}


- (void) perform {
    CATransition *transition = [CATransition animation];

    transition.duration = 0.3;
    transition.type = kCATransitionFade;

    [[self.sourceViewController navigationController].view.layer addAnimation: transition forKey: kCATransition];
//    [[self.sourceViewController navigationController] popToViewController: [self destinationViewController] animated: NO];

    [[self.sourceViewController navigationController] popToRootViewControllerAnimated: NO];
}

@end