//
// Created by dpostigo on 3/3/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "BasicCocoafishOperation.h"


@interface PlacePictureOperation : BasicCocoafishOperation {
    UIImage *image;
}


@property(nonatomic, strong) UIImage *image;
- (id) initWithImage: (UIImage *) anImage;

@end