#import "CBLayer.h"


@implementation CBLayer


@synthesize outerBorderColor;
@synthesize backgroundLayer;
@synthesize innerGlow;
@synthesize innerBorderColor;
@synthesize topColor;
@synthesize bottomColor;






#pragma mark - UIButton Overrides

+ (CBLayer *) buttonWithType: (UIButtonType) type {
    return [super buttonWithType: UIButtonTypeCustom];
}


- (id) initWithCoder: (NSCoder *) coder {
    self = [super initWithCoder: coder];
    if (self) {



        self.titleLabel.layer.shadowColor = [UIColor colorWithWhite: 1.0 alpha: 0.5].CGColor;
        self.titleLabel.layer.shadowOffset = CGSizeMake(0, 0);
        self.titleLabel.layer.shadowRadius = 0;
        self.titleLabel.layer.shadowOpacity = 1;

        self.innerBorderColor = [UIColor colorWithWhite: 1.0 alpha: 0.5];
        self.outerBorderColor = [UIColor colorWithRed: 0.77f green: 0.43f blue: 0.00f alpha: 1.00f];
        self.topColor = [UIColor colorWithRed: 0.94f green: 0.82f blue: 0.52f alpha: 1.00f];
        self.bottomColor = [UIColor colorWithRed: 0.91f green: 0.55f blue: 0.00f alpha: 1.00f];

        self.layer.cornerRadius = 5;
        self.layer.borderWidth = 1;

        innerGlow = [CALayer layer];
        innerGlow.cornerRadius = 4;
        innerGlow.borderWidth = 1;
        innerGlow.opacity = 1;
        [self.layer insertSublayer: innerGlow atIndex: 2];

        backgroundLayer = [CAGradientLayer layer];
        backgroundLayer.locations = (@[@0.0f, @1.0f]);
        [self.layer insertSublayer: backgroundLayer atIndex: 0];

        _highlightBackgroundLayer = [CAGradientLayer layer];
        _highlightBackgroundLayer.locations = (@[@0.0f, @1.0f]);
        [self.layer insertSublayer: _highlightBackgroundLayer atIndex: 1];

        [self redraw];
    }
    return self;
}


- (void) redraw {

    self.layer.borderColor = self.outerBorderColor.CGColor;
    self.innerGlow.borderColor = self.innerBorderColor.CGColor;

    backgroundLayer.colors = (@[(id) topColor.CGColor, (id) bottomColor.CGColor]);
    _highlightBackgroundLayer.colors = (@[(id) bottomColor.CGColor, (id) topColor.CGColor]);

    _highlightBackgroundLayer.hidden = YES;
}


- (void) layoutSubviews {
    innerGlow.frame = CGRectInset(self.bounds, 1, 1);
    backgroundLayer.frame = self.bounds;
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
    layer.borderColor = self.outerBorderColor.CGColor;
}


- (void) drawBackgroundLayer {
    if (!backgroundLayer) {
        backgroundLayer = [CAGradientLayer layer];
        [self.layer insertSublayer: backgroundLayer atIndex: 0];
    }

    backgroundLayer.colors = (@[
            (id) [UIColor colorWithRed: 0.94f green: 0.82f blue: 0.52f alpha: 1.00f].CGColor,
            (id) [UIColor colorWithRed: 0.91f green: 0.55f blue: 0.00f alpha: 1.00f].CGColor
    ]);

    backgroundLayer.locations = (@[
            @0.0f,
            @1.0f
    ]);
}


- (void) drawHighlightBackgroundLayer {
    if (!_highlightBackgroundLayer) {
        _highlightBackgroundLayer = [CAGradientLayer layer];
        [self.layer insertSublayer: _highlightBackgroundLayer atIndex: 1];
    }

    NSArray *colors = backgroundLayer.colors;
    _highlightBackgroundLayer.colors = [[colors reverseObjectEnumerator] allObjects];
    _highlightBackgroundLayer.locations = (@[
            @0.0f,
            @1.0f
    ]);
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
