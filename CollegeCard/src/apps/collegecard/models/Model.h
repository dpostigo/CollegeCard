//
// Created by dpostigo on 9/20/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "BasicModel.h"
#import "CCUser.h"
#import "CCPlaceCocoafish.h"
#import "CCEvent.h"


@interface Model : BasicModel {

    CCEvent *currentEvent;
    CCPlaceCocoafish *currentPlace;
    NSArray *merchantEvents;
    NSDateFormatter *dateFormatter;
}


@property(nonatomic, strong) CCPlaceCocoafish *currentPlace;
@property(nonatomic, strong) NSArray *merchantEvents;
@property(nonatomic, strong) CCEvent *currentEvent;
@property(nonatomic, strong) NSDateFormatter *dateFormatter;
+ (Model *) sharedModel;
- (BOOL) isLoggedIn;
- (CCUser *) currentUser;
- (NSString *) timeStringForEvent: (CCEvent *) event;
- (UIImageView *) nextImageView;
- (NSString *) slugForProperty: (NSString *) property;
- (NSString *) propertyForSlug: (NSString *) slug;

@end