#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>


@interface CBLayer : UIButton {

    UIColor *outerBorderColor;
    UIColor *innerBorderColor;
    UIColor *topColor;
    UIColor *bottomColor;
    CAGradientLayer *backgroundLayer;
    CALayer *innerGlow;
}


@property(nonatomic, strong) UIColor *outerBorderColor;

@property(strong, nonatomic) CAGradientLayer *backgroundLayer;
@property(strong, nonatomic) CAGradientLayer *highlightBackgroundLayer;
@property(strong, nonatomic) CALayer *innerGlow;
@property(nonatomic, strong) UIColor *innerBorderColor;
@property(nonatomic, strong) UIColor *topColor;
@property(nonatomic, strong) UIColor *bottomColor;
- (void) redraw;

@end
