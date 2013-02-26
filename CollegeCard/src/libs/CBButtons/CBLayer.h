#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>


@interface CBLayer : UIButton {

    CAGradientLayer *backgroundLayer;
    CALayer *innerGlow;
    UIColor *borderColor;
}


@property(nonatomic, strong) UIColor *borderColor;

@property(strong, nonatomic) CAGradientLayer *backgroundLayer;
@property(strong, nonatomic) CAGradientLayer *highlightBackgroundLayer;
@property(strong, nonatomic) CALayer *innerGlow;

@end
