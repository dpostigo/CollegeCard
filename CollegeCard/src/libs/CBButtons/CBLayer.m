#import "CBLayer.h"




@implementation CBLayer


@synthesize borderColor;
@synthesize backgroundLayer;
@synthesize innerGlow;




#pragma mark - UIButton Overrides

+ (CBLayer *) buttonWithType: (UIButtonType) type {
    return [super buttonWithType: UIButtonTypeCustom];
}


- (id) initWithCoder: (NSCoder *) coder {
    // Call the parent implementation of initWithCoder
    self = [super initWithCoder: coder];

    // Custom drawing methods
    if (self) {

        self.borderColor = [UIColor colorWithRed: 0.77f green: 0.43f blue: 0.00f alpha: 1.00f];

        [self redraw];

    }

    return self;
}


- (void) redraw {

    [self drawButton];
    [self drawInnerGlow];
    [self drawBackgroundLayer];
    [self drawHighlightBackgroundLayer];
    _highlightBackgroundLayer.hidden = YES;




}


- (void) setBackgroundColor: (UIColor *) backgroundColor {
    [super setBackgroundColor: backgroundColor];
}


- (void) layoutSubviews {

    // Set inner glow frame (1pt inset)
    innerGlow.frame = CGRectInset(self.bounds, 1, 1);

    // Set gradient frame (fill the whole button))
    backgroundLayer.frame = self.bounds;

    // Set inverted gradient frame
    _highlightBackgroundLayer.frame = self.bounds;

    [super layoutSubviews];
}


- (void) setHighlighted: (BOOL) highlighted {
    // Disable implicit animation
    [CATransaction begin];
    [CATransaction setDisableActions: YES];

    // Hide/show inverted gradient
    _highlightBackgroundLayer.hidden = !highlighted;
    [CATransaction commit];

    [super setHighlighted: highlighted];
}




#pragma mark - Layer setters

- (void) drawButton {
    CALayer *layer = self.layer;
    layer.cornerRadius = 5;
    layer.borderWidth = 1;
    layer.borderColor = self.borderColor.CGColor;
}


- (void) drawBackgroundLayer {
    // Check if the property has been set already
    if (!backgroundLayer) {
        // Instantiate the gradient layer
        backgroundLayer = [CAGradientLayer layer];

        // Set the colors
        backgroundLayer.colors = (@[
                (id) [UIColor colorWithRed: 0.94f green: 0.82f blue: 0.52f alpha: 1.00f].CGColor,
                (id) [UIColor colorWithRed: 0.91f green: 0.55f blue: 0.00f alpha: 1.00f].CGColor

        ]);

        // Set the stops
        backgroundLayer.locations = (@[
                @0.0f,
                @1.0f
        ]);

        // Add the gradient to the layer hierarchy
        [self.layer insertSublayer: backgroundLayer atIndex: 0];
    }
}


- (void) drawHighlightBackgroundLayer {
    if (!_highlightBackgroundLayer) {
        _highlightBackgroundLayer = [CAGradientLayer layer];
        _highlightBackgroundLayer.colors = (@[
                (id) [UIColor colorWithRed: 0.91f green: 0.55f blue: 0.00f alpha: 1.00f].CGColor,
                (id) [UIColor colorWithRed: 0.94f green: 0.82f blue: 0.52f alpha: 1.00f].CGColor
        ]);
        _highlightBackgroundLayer.locations = (@[
                @0.0f,
                @1.0f
        ]);
        [self.layer insertSublayer: _highlightBackgroundLayer atIndex: 1];
    }
}


- (void) drawInnerGlow {
    if (!innerGlow) {
        // Instantiate the innerGlow layer
        innerGlow = [CALayer layer];

        innerGlow.cornerRadius = 4;
        innerGlow.borderWidth = 1;
        innerGlow.borderColor = [[UIColor whiteColor] CGColor];
        innerGlow.opacity = 0.5;

        [self.layer insertSublayer: innerGlow atIndex: 2];
    }
}

@end
