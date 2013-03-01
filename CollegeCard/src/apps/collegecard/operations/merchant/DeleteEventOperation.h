//
// Created by dpostigo on 2/28/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "BasicCocoafishOperation.h"


@interface DeleteEventOperation : BasicCocoafishOperation {

NSString *eventId;
}


@property(nonatomic, copy) NSString *eventId;
- (id) initWithEventId: (NSString *) anEventId;

@end