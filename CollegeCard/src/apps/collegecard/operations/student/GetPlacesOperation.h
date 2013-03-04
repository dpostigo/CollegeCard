//
// Created by dpostigo on 3/3/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "BasicCocoafishOperation.h"


@interface GetPlacesOperation : BasicCocoafishOperation {

    NSArray *placeIds;
}


@property(nonatomic, strong) NSArray *placeIds;
- (id) initWithPlaceIds: (NSArray *) aPlaceIds;

@end