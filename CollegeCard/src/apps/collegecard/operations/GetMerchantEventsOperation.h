//
// Created by dpostigo on 2/26/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "BasicCocoafishOperation.h"


@interface GetMerchantEventsOperation : BasicCocoafishOperation {
    NSString *placeId;
}


@property(nonatomic, retain) NSString *placeId;
- (id) initWithPlaceId: (NSString *) aPlaceId;

@end