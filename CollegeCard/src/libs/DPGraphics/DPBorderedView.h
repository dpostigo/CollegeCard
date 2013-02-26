//
// Created by dpostigo on 10/22/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

@interface DPBorderedView : UIView {

    UIView *innerShadow;

    UIColor *strokeColor;
    UIColor *innerStrokeColor;

    CGFloat borderWidth;
    CGFloat cornerRadius;

    UIView *_contentView;
}

@property(nonatomic, strong) UIView *innerShadow;
@property(nonatomic, strong) UIColor *strokeColor;
@property(nonatomic, strong) UIColor *innerStrokeColor;
@property(nonatomic) CGFloat borderWidth;
@property(nonatomic) CGFloat cornerRadius;

@end