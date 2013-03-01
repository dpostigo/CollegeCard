//
// Created by dpostigo on 2/27/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "BasicCocoafishOperation.h"


@interface UpdateEventOperation : BasicCocoafishOperation {
    NSDictionary *paramDict;
}


@property(nonatomic, strong) NSDictionary *paramDict;
- (id) initWithParamDict: (NSDictionary *) aParamDict;

@end