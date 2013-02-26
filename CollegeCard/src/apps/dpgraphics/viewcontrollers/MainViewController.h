//
// Created by dpostigo on 10/23/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "BasicTableViewController.h"

@interface MainViewController : BasicTableViewController  <UITableViewDelegate, UITableViewDataSource> {


    IBOutlet UINavigationController *navigationController;
    IBOutlet UIView *containerView;

    IBOutlet UIStoryboardSegue *embedSegue;

}


@property(nonatomic, strong) UIView *containerView;
@property(nonatomic, strong) IBOutlet UINavigationController *navigationController;

@end