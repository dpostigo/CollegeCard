#import "CBBezier.h"


@implementation CBBezier


@synthesize topColor;
@synthesize bottomColor;
@synthesize borderColor;
@synthesize innerGlow;


#pragma mark - UIButton Overrides

+ (CBBezier *) buttonWithType: (UIButtonType) type {
    return [super buttonWithType: UIButtonTypeCustom];
}


- (id) initWithCoder: (NSCoder *) aDecoder {
    self = [super initWithCoder: aDecoder];
    if (self) {

        self.borderColor = [UIColor colorWithRed: 0.77f green: 0.43f blue: 0.00f alpha: 1.00f];
        self.topColor = [UIColor colorWithRed: 0.94f green: 0.82f blue: 0.52f alpha: 1.00f];
        self.bottomColor = [UIColor colorWithRed: 0.91f green: 0.55f blue: 0.00f alpha: 1.00f];
        self.innerGlow = [UIColor colorWithWhite: 1.0 alpha: 0.5];
    }

    return self;
}


- (void) setHighlighted: (BOOL) highlighted {
    [self setNeedsDisplay];
    [super setHighlighted: highlighted];
}

#pragma mark - Touch event overrides


- (void) drawRect: (CGRect) rect {

    // General Declarations
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = UIGraphicsGetCurrentContext();

    // Color Declarations

    // Gradient Declarations
    NSArray *gradientColors = (@[
            (id) topColor.CGColor,
            (id) bottomColor.CGColor
    ]);
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) (gradientColors), NULL);
    NSArray *highlightedGradientColors = (@[
            (id) bottomColor.CGColor,
            (id) topColor.CGColor
    ]);
    CGGradientRef highlightedGradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) (highlightedGradientColors), NULL);


    // Draw rounded rectangle bezier path
    UIBezierPath *roundedRectanglePath = [UIBezierPath bezierPathWithRoundedRect: self.bounds cornerRadius: 5];
    // Use the bezier as a clipping path
    [roundedRectanglePath addClip];

    // Use one of the two gradients depending on the state of the button
    CGGradientRef background = self.highlighted ? highlightedGradient: gradient;

    // Draw gradient within the path
    CGContextDrawLinearGradient(context, background, CGPointMake(self.width, 0), CGPointMake(self.width, self.height), 0);

    // Draw border
    [borderColor setStroke];
    roundedRectanglePath.lineWidth = 2;
    [roundedRectanglePath stroke];

    // Draw Inner Glow
    UIBezierPath *innerGlowRect = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(1.5, 1.5, self.width, self.height) cornerRadius: 4];
    [innerGlow setStroke];
    innerGlowRect.lineWidth = 1;
    [innerGlowRect stroke];

    // Cleanup
    CGGradientRelease(gradient);
    CGGradientRelease(highlightedGradient);
    CGColorSpaceRelease(colorSpace);
}

@end
