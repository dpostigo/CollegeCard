//
// Created by dpostigo on 2/25/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "BasicCocoafishOperation.h"


@interface SearchPlacesOperation : BasicCocoafishOperation {

CLLocation *location;


}


@property(nonatomic, strong) CLLocation *location;
- (id) initWithLocation: (CLLocation *) aLocation;

@end