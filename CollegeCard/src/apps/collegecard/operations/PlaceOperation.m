//
// Created by dpostigo on 2/25/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "PlaceOperation.h"


@implementation PlaceOperation {
}


@synthesize paramDict;


- (id) initWithParamDict: (NSMutableDictionary *) aParamDict {

    self = [super initWithDelegate: nil httpMethod: @"POST" baseUrl: @"places/create.json" paramDict: paramDict];
    if (self) {
        paramDict = aParamDict;
    }

    return self;
}

@end