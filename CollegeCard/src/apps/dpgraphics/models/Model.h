//
// Created by dpostigo on 9/20/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "BasicModel.h"

@interface Model : BasicModel  {
    NSMutableArray *drawings;
    BOOL usesGestures;

    BOOL directorLive;

}

@property(nonatomic, strong) NSMutableArray *drawings;
@property(nonatomic) BOOL usesGestures;
@property(nonatomic) BOOL directorLive;
+ (Model *) sharedModel;


@end