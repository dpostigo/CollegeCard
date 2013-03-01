//
// Created by dpostigo on 2/26/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "BasicCocoafishOperation.h"


@interface GetMerchantEventsOperation : BasicCocoafishOperation {
    NSString *placeId;
    CLLocation *location;
    float distance;
}


@property(nonatomic, retain) NSString *placeId;
@property(nonatomic, strong) CLLocation *location;
@property(nonatomic) float distance;
- (id) initWithPlaceId: (NSString *) aPlaceId;
- (id) initWithLocation: (CLLocation *) aLocation distance: (float) aDistance;

@end