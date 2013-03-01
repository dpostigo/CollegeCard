//
// Created by dpostigo on 2/28/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "TableRowObject.h"
#import "CCCheckin.h"


@interface CheckinRowObject : TableRowObject {
    CCCheckin *checkIn;
}


@property(nonatomic, strong) CCCheckin *checkIn;
- (id) initWithCheckIn: (CCCheckin *) aCheckIn;

@end