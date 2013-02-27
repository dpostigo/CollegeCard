//
// Created by dpostigo on 2/27/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "BasicCocoafishOperation.h"
#import "TempEvent.h"


@interface CreateEventOperation : BasicCocoafishOperation {
    TempEvent *tempEvent;
}


@property(nonatomic, strong) TempEvent *tempEvent;
- (id) initWithTempEvent: (TempEvent *) aTempEvent;

@end