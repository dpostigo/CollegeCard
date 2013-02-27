//
// Created by dpostigo on 2/26/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "BasicCocoafishOperation.h"


@interface PictureOperation : BasicCocoafishOperation {
    UIImage *image;
}


@property(nonatomic, strong) UIImage *image;
- (id) initWithImage: (UIImage *) anImage;

@end