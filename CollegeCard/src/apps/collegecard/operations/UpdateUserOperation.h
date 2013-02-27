//
// Created by dpostigo on 2/26/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "BasicCocoafishOperation.h"


@interface UpdateUserOperation : BasicCocoafishOperation {

NSDictionary *paramDict;

}


@property(nonatomic, strong) NSDictionary *paramDict;
- (id) initWithParamDict: (NSMutableDictionary *) aParamDict;

@end