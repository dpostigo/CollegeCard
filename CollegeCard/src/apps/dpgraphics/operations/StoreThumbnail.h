//
// Created by dpostigo on 9/20/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "BasicOperation.h"
#import "Drawing.h"

@interface StoreThumbnail : BasicOperation {
    Drawing *drawing;


}

@property(nonatomic, strong) Drawing *drawing;

@end