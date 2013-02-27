//
// Created by dpostigo on 2/25/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "SVProgressHUD.h"


@interface DPProgressHUD : SVProgressHUD


- (UIWindow *) overlayWindow;
- (UIView *) hudView;

@end