//
// Created by dpostigo on 3/19/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <QuartzCore/QuartzCore.h>
#import "FakeModalPush.h"


@implementation FakeModalPush {
}


- (void) perform {


    UIViewController *source = (UIViewController *) self.sourceViewController;
    UIViewController *destination = (UIViewController *) self.destinationViewController;

//    [source.navigationController pushViewController: destination animated: NO];
    destination.view.top = destination.view.height;
    destination.view.backgroundColor = [UIColor clearColor];
    destination.view.opaque = NO;
    [UIView animateWithDuration: 0.3 animations: ^{

        destination.view.top -= destination.view.height;
    }                completion: ^(BOOL finished) {
    }];
}

@end