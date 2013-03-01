//
// Created by dpostigo on 2/28/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "TableRowObject.h"


@interface DateRowObject : TableRowObject {
    NSDate *date;
    NSDate *startTime;
    NSDate *endTime;
}


@property(nonatomic, strong) NSDate *startTime;
@property(nonatomic, strong) NSDate *endTime;
@property(nonatomic, strong) NSDate *date;
- (id) initWithStartTime: (NSDate *) aStartTime endTime: (NSDate *) anEndTime cellIdentifier: (NSString *) aCellIdentifier;
- (id) initWithDate: (NSDate *) aDate cellIdentifier: (NSString *) aCellIdentifier;
- (id) initWithTextLabel: (NSString *) aTextLabel date: (NSDate *) aDate cellIdentifier: (NSString *) aCellIdentifier;

@end