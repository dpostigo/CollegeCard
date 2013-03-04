//
// Created by dpostigo on 2/26/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "BasicCocoafishOperation.h"


@interface GetPlaceOperation : BasicCocoafishOperation {

    NSString *placeId;
    BOOL setAsCurrentPlace;
}


@property(nonatomic, copy) NSString *placeId;
@property(nonatomic) BOOL setAsCurrentPlace;
- (id) initWithPlaceId: (NSString *) aPlaceId;
- (id) initWithPlaceId: (NSString *) aPlaceId setAsCurrentPlace: (BOOL) aBoolean;

@end