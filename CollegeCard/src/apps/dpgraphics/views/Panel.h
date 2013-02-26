//
// Created by dpostigo on 9/18/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

@interface Panel : UIView {


    BOOL isEditing;
    UIView *backgroundView;
    UIImageView *imageView;
    UIImageView *editingImageView;

}

@property(nonatomic, strong) UIImageView *imageView;
@property(nonatomic, strong) UIView *backgroundView;
@property(nonatomic) BOOL isEditing;
@property(nonatomic, strong) UIImageView *editingImageView;

@end