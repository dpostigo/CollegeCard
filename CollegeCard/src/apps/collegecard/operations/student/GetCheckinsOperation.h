//
// Created by dpostigo on 2/28/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "BasicCocoafishOperation.h"


@interface GetCheckinsOperation : BasicCocoafishOperation {

    NSString *userId;
}


@property(nonatomic, retain) NSString *userId;
- (id) initWithUserId: (NSString *) anUserId;

@end