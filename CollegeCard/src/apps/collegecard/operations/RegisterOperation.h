//
// Created by dpostigo on 2/24/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "BasicOperation.h"
#import "BasicCocoafishOperation.h"


@interface RegisterOperation : BasicCocoafishOperation {

    NSString *email;
    NSString *userPassword;

}


@property(nonatomic, retain) NSString *email;
@property(nonatomic, retain) NSString *userPassword;
- (id) initWithEmail: (NSString *) anEmail password: (NSString *) aPassword firstName: (NSString *) firstName lastName: (NSString *) lastName;

@end