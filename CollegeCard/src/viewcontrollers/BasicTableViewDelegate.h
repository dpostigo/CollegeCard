//
// Created by dpostigo on 2/24/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "BasicTableViewControllerProtocol.h"


@interface BasicTableViewDelegate : NSObject <UITableViewDataSource, UITableViewDelegate> {


    id<BasicTableViewControllerProtocol> viewController;
    NSMutableArray *dataSource;
}


@property(nonatomic, strong) NSMutableArray *dataSource;
@property(nonatomic, strong) id <BasicTableViewControllerProtocol> viewController;
- (id) initWithViewController: (id <BasicTableViewControllerProtocol>) aViewController;

@end