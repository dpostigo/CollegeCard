#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>


@interface CBBezier : UIButton {

    UIColor *borderColor;
    UIColor *topColor;
    UIColor *bottomColor;
    UIColor *innerGlow;
}


@property(nonatomic, strong) UIColor *borderColor;
@property(nonatomic, strong) UIColor *topColor;
@property(nonatomic, strong) UIColor *bottomColor;
@property(nonatomic, strong) UIColor *innerGlow;

@end
