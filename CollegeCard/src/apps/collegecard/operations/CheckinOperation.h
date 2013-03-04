//
// Created by dpostigo on 2/25/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "BasicCocoafishOperation.h"


@interface CheckinOperation : BasicCocoafishOperation {

    CCPlace *place;



}


@property(nonatomic, strong) CCPlace *place;
- (id) initWithPlace: (CCPlace *) aPlace;

@end