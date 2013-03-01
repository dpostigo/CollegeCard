//
// Created by dpostigo on 2/27/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "CCEvent.h"


@interface TempEvent : CCEvent  {

    NSString *name;
    NSDate *startTime;
    NSDate *endTime;
}


@property(nonatomic, retain) NSString *name;
@property(nonatomic, strong) NSDate *startTime;
@property(nonatomic, strong) NSDate *endTime;
- (NSInteger) duration;

@end