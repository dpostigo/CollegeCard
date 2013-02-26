//
// Created by dpostigo on 7/18/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "Model.h"


@interface BasicOperation : NSOperation {
    Model *_model;
    __unsafe_unretained id delegate;
}

@property(nonatomic, assign) id delegate;

@end