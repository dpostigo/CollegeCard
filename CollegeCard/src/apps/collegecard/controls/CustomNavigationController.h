//
// Created by dpostigo on 3/11/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "CustomNavigationBar.h"


@interface CustomNavigationController : UINavigationController {

    IBOutlet CustomNavigationBar *customNavigationBar;
}


@property(nonatomic, strong) CustomNavigationBar *customNavigationBar;

@end