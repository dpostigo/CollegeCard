//
// Created by dpostigo on 2/27/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "CCEvent.h"


@interface TempEvent : CCEvent  {

    NSString *name;
}


@property(nonatomic, retain) NSString *name;

@end