//
// Created by dpostigo on 3/1/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "SavedPlacesViewController.h"
#import "SearchPlacesOperation.h"


@implementation SavedPlacesViewController {
}


- (void) loadView {
    [super loadView];

    [_queue addOperation: [[SearchPlacesOperation alloc] init]];
}


#pragma mark UITableView


#pragma mark IBActions


#pragma mark Callbacks



@end