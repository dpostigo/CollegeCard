//
// Created by dpostigo on 10/16/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "BasicOperation.h"
#import "Drawing.h"

@interface LoadPointsForDrawing : BasicOperation {
    Drawing *drawing;
}

@property(nonatomic, strong) Drawing *drawing;
- (id) initWithDrawing: (Drawing *) aDrawing;

@end