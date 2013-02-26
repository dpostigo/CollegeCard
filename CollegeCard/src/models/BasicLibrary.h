//
// Created by dpostigo on 8/30/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

@interface BasicLibrary : NSObject {

    NSMutableArray *delegates;
}


@property(nonatomic, retain) NSMutableArray *delegates;


- (void) subscribeDelegate: (id) aDelegate;

- (void) unsubscribeDelegate: (id) aDelegate;

- (void) notifyDelegates: (SEL) aSelector object: (id) obj;
- (void) notifyDelegates: (SEL) aSelector object: (id) obj andObject: (id) obj2;

@end