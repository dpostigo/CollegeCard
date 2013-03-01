//
// Created by dpostigo on 2/26/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "TableRowObject.h"
#import "CCEvent.h"


@interface EventRowObject : TableRowObject {

    CCEvent *event;
}


@property(nonatomic, strong) CCEvent *event;
- (id) initWithEvent: (CCEvent *) anEvent;
- (id) initWithEvent: (CCEvent *) anEvent cellIdentifier: (NSString *) aCellIdentifier;

@end