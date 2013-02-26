//
// Created by dpostigo on 2/25/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "BasicCocoafishOperation.h"


@interface PlaceOperation : BasicCocoafishOperation {

    NSMutableDictionary *paramDict;
}


@property(nonatomic, strong) NSMutableDictionary *paramDict;
- (id) initWithParamDict: (NSMutableDictionary *) aParamDict;

@end