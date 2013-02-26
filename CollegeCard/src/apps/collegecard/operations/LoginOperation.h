//
// Created by dpostigo on 2/24/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "BasicCocoafishOperation.h"


@interface LoginOperation : BasicCocoafishOperation {

    NSString *email;
    NSString *userPassword;
}


@property(nonatomic, retain) NSString *email;
@property(nonatomic, retain) NSString *userPassword;
- (id) initWithEmail: (NSString *) anEmail userPassword: (NSString *) anUserPassword;

@end