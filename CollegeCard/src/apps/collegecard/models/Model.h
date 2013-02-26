//
// Created by dpostigo on 9/20/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "BasicModel.h"
#import "CCUser.h"
#import "CCPlaceCocoafish.h"


@interface Model : BasicModel {

    CCPlaceCocoafish *currentPlace;
}


@property(nonatomic, strong) CCPlaceCocoafish *currentPlace;
+ (Model *) sharedModel;
- (BOOL) isLoggedIn;
- (CCUser *) currentUser;

@end