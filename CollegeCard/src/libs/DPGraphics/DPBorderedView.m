//
// Created by dpostigo on 10/22/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <QuartzCore/QuartzCore.h>
#import "DPBorderedView.h"

@implementation DPBorderedView {
}

@synthesize innerShadow;
@synthesize strokeColor;
@synthesize innerStrokeColor;
@synthesize borderWidth;
@synthesize cornerRadius;

- (id) initWithFrame: (CGRect) frame style: (DPPopoverStyle) aStyle {

    self = [super initWithFrame: frame];
    if (self) {
        style = aStyle;

        strokeColor = [UIColor grayColor];
        innerStrokeColor = [UIColor blackColor];
        cornerRadius = 3.0;
        borderWidth = 7.0;

        self.innerShadow = [[[UIView alloc] init] autorelease];
        innerShadow.backgroundColor = [UIColor clearColor];
        innerShadow.userInteractionEnabled = NO;
        innerShadow.layer.borderColor = [UIColor whiteColor].CGColor;
        innerShadow.layer.shadowColor = [UIColor blackColor].CGColor;


        //we need to set the background as clear to see the view below
        self.backgroundColor = [UIColor clearColor];
        self.clipsToBounds = YES;

        self.layer.shadowOpacity = 0.7;
        self.layer.shadowRadius = 1;
        self.layer.shadowOffset = CGSizeMake(1, 1);

        //to get working the animations
        self.contentMode = UIViewContentModeRedraw;



        [self setupViews];
    }

    return self;
}


- (id) initWithFrame: (CGRect) frame {
    return [self initWithFrame: frame style: DPPopoverStyleWhiteOnBlack];

}



- (void) addContentView: (UIView *) contentView {
    if (_contentView != contentView) {
        [_contentView removeFromSuperview];
        [_contentView release];
        _contentView = [contentView retain];
        [self addSubview: _contentView];
        [self addSubview: innerShadow];
    }
    [self setupViews];
}

- (CGPathRef) newContentPathWithBorderWidth: (CGFloat) borderWidth arrowDirection: (FPPopoverArrowDirection) direction {
    CGFloat w = self.bounds.size.width;
    CGFloat h = self.bounds.size.height;
    CGFloat ah = DP_POPOVER_ARROW_HEIGHT; //is the height of the triangle of the arrow
    CGFloat aw = DP_POPOVER_ARROW_BASE/ 2.0; //is the 1/2 of the base of the arrow
    CGFloat radius = cornerRadius;
    CGFloat b = borderWidth;
    CGRect rect;
    if (direction == FPPopoverArrowDirectionUp) {

        rect.size.width = w - 2 * b;
        rect.size.height = h - ah - 2 * b;
        rect.origin.x = b;
        rect.origin.y = ah + b;
    }
    else if (direction == FPPopoverArrowDirectionDown) {
        rect.size.width = w - 2 * b;
        rect.size.height = h - ah - 2 * b;
        rect.origin.x = b;
        rect.origin.y = b;
    }

    else if (direction == FPPopoverArrowDirectionRight) {
        rect.size.width = w - ah - 2 * b;
        rect.size.height = h - 2 * b;
        rect.origin.x = b;
        rect.origin.y = b;
    }
    else {
        //Assuming direction == FPPopoverArrowDirectionLeft to suppress static analyzer warnings
        rect.size.width = w - ah - 2 * b;
        rect.size.height = h - 2 * b;
        rect.origin.x = ah + b;
        rect.origin.y = b;
    }

    //the arrow will be near the origin
    CGFloat ax = self.relativeOrigin.x - aw; //the start of the arrow when UP or DOWN
    if (ax < aw + b) ax = aw + b;
    else if (ax + 2 * aw + 2 * b > self.bounds.size.width) ax = self.bounds.size.width - 2 * aw - 2 * b;

    CGFloat ay = self.relativeOrigin.y - aw; //the start of the arrow when RIGHT or LEFT
    if (ay < aw + b) ay = aw + b;
    else if (ay + 2 * aw + 2 * b > self.bounds.size.height) ay = self.bounds.size.height - 2 * aw - 2 * b;


    //ROUNDED RECT
    // arrow UP
    CGRect innerRect = CGRectInset(rect, radius, radius);
    CGFloat inside_right = innerRect.origin.x + innerRect.size.width;
    CGFloat outside_right = rect.origin.x + rect.size.width;
    CGFloat inside_bottom = innerRect.origin.y + innerRect.size.height;
    CGFloat outside_bottom = rect.origin.y + rect.size.height;
    CGFloat inside_top = innerRect.origin.y;
    CGFloat outside_top = rect.origin.y;
    CGFloat outside_left = rect.origin.x;


    //drawing the border with arrow
    CGMutablePathRef path = CGPathCreateMutable();

    CGPathMoveToPoint(path, NULL, innerRect.origin.x, outside_top);

    //top arrow
    if (direction == FPPopoverArrowDirectionUp) {
        CGPathAddLineToPoint(path, NULL, ax, ah + b);
        CGPathAddLineToPoint(path, NULL, ax + aw, b);
        CGPathAddLineToPoint(path, NULL, ax + 2 * aw, ah + b);
    }

    CGPathAddLineToPoint(path, NULL, inside_right, outside_top);
    CGPathAddArcToPoint(path, NULL, outside_right, outside_top, outside_right, inside_top, radius);

    //right arrow
    if (direction == FPPopoverArrowDirectionRight) {
        CGPathAddLineToPoint(path, NULL, outside_right, ay);
        CGPathAddLineToPoint(path, NULL, outside_right + ah + b, ay + aw);
        CGPathAddLineToPoint(path, NULL, outside_right, ay + 2 * aw);
    }

    CGPathAddLineToPoint(path, NULL, outside_right, inside_bottom);
    CGPathAddArcToPoint(path, NULL, outside_right, outside_bottom, inside_right, outside_bottom, radius);

    //down arrow
    if (direction == FPPopoverArrowDirectionDown) {
        CGPathAddLineToPoint(path, NULL, ax + 2 * aw, outside_bottom);
        CGPathAddLineToPoint(path, NULL, ax + aw, outside_bottom + ah);
        CGPathAddLineToPoint(path, NULL, ax, outside_bottom);
    }

    CGPathAddLineToPoint(path, NULL, innerRect.origin.x, outside_bottom);
    CGPathAddArcToPoint(path, NULL, outside_left, outside_bottom, outside_left, inside_bottom, radius);

    //left arrow
    if (direction == FPPopoverArrowDirectionLeft) {
        CGPathAddLineToPoint(path, NULL, outside_left, ay + 2 * aw);
        CGPathAddLineToPoint(path, NULL, outside_left - ah - b, ay + aw);
        CGPathAddLineToPoint(path, NULL, outside_left, ay);
    }

    CGPathAddLineToPoint(path, NULL, outside_left, inside_top);
    CGPathAddArcToPoint(path, NULL, outside_left, outside_top, innerRect.origin.x, outside_top, radius);

    CGPathCloseSubpath(path);

    return path;
}


- (CGGradientRef) newGradient {
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();

    // make a gradient
    CGFloat colors[8];

    if (self.tint == FPPopoverBlackTint) {
        if (_arrowDirection == FPPopoverArrowDirectionUp) {
            colors[0] = colors[1] = colors[2] = 0.6;
            colors[4] = colors[5] = colors[6] = 0.2;
            colors[3] = colors[7] = 0.7;
        }
        else {
            colors[0] = colors[1] = colors[2] = 0.4;
            colors[4] = colors[5] = colors[6] = 0.1;
            colors[3] = colors[7] = 1.0;
        }
    }

    else if (self.tint == FPPopoverLightGrayTint) {
        if (_arrowDirection == FPPopoverArrowDirectionUp) {
            colors[0] = colors[1] = colors[2] = 0.8;
            colors[4] = colors[5] = colors[6] = 0.3;
            colors[3] = colors[7] = 1.0;
        }
        else {
            colors[0] = colors[1] = colors[2] = 0.6;
            colors[4] = colors[5] = colors[6] = 0.1;
            colors[3] = colors[7] = 1.0;
        }
    }
    else if (self.tint == FPPopoverRedTint) {
        if (_arrowDirection == FPPopoverArrowDirectionUp) {
            colors[0] = 0.72;
            colors[1] = 0.35;
            colors[2] = 0.32;
            colors[4] = 0.36;
            colors[5] = 0.0;
            colors[6] = 0.09;
            colors[3] = colors[7] = 1.0;
        }
        else {
            colors[0] = 0.82;
            colors[1] = 0.45;
            colors[2] = 0.42;
            colors[4] = 0.36;
            colors[5] = 0.0;
            colors[6] = 0.09;
            colors[3] = colors[7] = 1.0;
        }
    }

    else if (self.tint == FPPopoverGreenTint) {
        if (_arrowDirection == FPPopoverArrowDirectionUp) {
            colors[0] = 0.35;
            colors[1] = 0.72;
            colors[2] = 0.17;
            colors[4] = 0.18;
            colors[5] = 0.30;
            colors[6] = 0.03;
            colors[3] = colors[7] = 1.0;
        }
        else {
            colors[0] = 0.45;
            colors[1] = 0.82;
            colors[2] = 0.27;
            colors[4] = 0.18;
            colors[5] = 0.30;
            colors[6] = 0.03;
            colors[3] = colors[7] = 1.0;
        }
    }

    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, colors, NULL, 2);

    CFRelease(colorSpace);
    return gradient;
}



- (void) drawRect: (CGRect) rect {
    [super drawRect: rect];

    CGFloat red = 0.0, green = 0.0, blue = 0.0, alpha = 0.0;
    CGGradientRef gradient = [self newGradient];
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSaveGState(ctx);

    //content fill
    CGPathRef contentPath = [self newContentPathWithBorderWidth: 2.0 arrowDirection: _arrowDirection];

    CGContextAddPath(ctx, contentPath);
    CGContextClip(ctx);

    //  Draw a linear gradient from top to bottom
    CGPoint start;
    CGPoint end;
    if (_arrowDirection == FPPopoverArrowDirectionUp) {
        start = CGPointMake(self.bounds.size.width / 2.0, 0);
        end = CGPointMake(self.bounds.size.width / 2.0, 40);
    }
    else {
        start = CGPointMake(self.bounds.size.width / 2.0, 0);
        end = CGPointMake(self.bounds.size.width / 2.0, 20);
    }

    CGContextDrawLinearGradient(ctx, gradient, start, end, 0);

    CGGradientRelease(gradient);
    //fill the other part of path
    if (self.tint == FPPopoverBlackTint) {
        CGContextSetRGBFillColor(ctx, 0.1, 0.1, 0.1, 1.0);
    }
    else if (self.tint == FPPopoverLightGrayTint) {
        CGContextSetRGBFillColor(ctx, 0.3, 0.3, 0.3, 1.0);
    }
    else if (self.tint == FPPopoverRedTint) {
        CGContextSetRGBFillColor(ctx, 0.36, 0.0, 0.09, 1.0);
    }
    else if (self.tint == FPPopoverGreenTint) {
        CGContextSetRGBFillColor(ctx, 0.18, 0.30, 0.03, 1.0);
    }

    CGContextFillRect(ctx, CGRectMake(0, end.y, self.bounds.size.width, self.bounds.size.height - end.y));

    [self drawOuterBorders: ctx contentPath: contentPath];
    [self drawContentViewBorders: ctx];
    CGContextRestoreGState(ctx);
}

- (void) drawOuterBorders: (CGContextRef) ctx contentPath: (CGPathRef) contentPath {

    CGFloat red = 0.0, green = 0.0, blue = 0.0, alpha = 0.0;
    CGFloat components[4];
    [self getRGBComponents: components forColor: strokeColor];
    red = components[0];
    green = components[1];
    blue = components[2];
    alpha = components[3];



    //internal border
    CGContextBeginPath(ctx);
    CGContextAddPath(ctx, contentPath);
    CGContextSetRGBStrokeColor(ctx, red, green, blue, alpha);
    //CGContextSetShadowWithColor(ctx, CGSizeMake(0, 0), 2.0, [UIColor blackColor].CGColor);

    CGContextSetLineWidth(ctx, 1);
    CGContextSetLineCap(ctx, kCGLineCapRound);
    CGContextSetLineJoin(ctx, kCGLineJoinRound);
    CGContextStrokePath(ctx);
    CGPathRelease(contentPath);

    //external border
    CGPathRef externalBorderPath = [self newContentPathWithBorderWidth: 1.0 arrowDirection: _arrowDirection];
    CGContextBeginPath(ctx);
    CGContextAddPath(ctx, externalBorderPath);
    CGContextSetRGBStrokeColor(ctx, red, green, blue, alpha);
    // CGContextSetShadowWithColor(ctx, CGSizeMake(0, 0), 2.0, [UIColor blackColor].CGColor);
    CGContextSetLineWidth(ctx, 1);
    CGContextSetLineCap(ctx, kCGLineCapRound);
    CGContextSetLineJoin(ctx, kCGLineJoinRound);
    CGContextStrokePath(ctx);
    CGPathRelease(externalBorderPath);
}

- (void) drawContentViewBorders: (CGContextRef) ctx {

    CGFloat red = 0.0, green = 0.0, blue = 0.0, alpha = 0.0;
    CGFloat components[4];
    [self getRGBComponents: components forColor: innerStrokeColor];
    red = components[0];
    green = components[1];
    blue = components[2];
    alpha = components[3];

    //firstLine

    CGFloat innerCornerRadius = cornerRadius;
    CGRect cvRect = _contentView.frame;
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect: cvRect cornerRadius: innerCornerRadius];
    CGPathRef borderPath = bezierPath.CGPath;
    CGContextBeginPath(ctx);
    CGContextAddPath(ctx, borderPath);
    CGContextSetRGBStrokeColor(ctx, red, green, blue, alpha / 2);
    CGContextSetLineWidth(ctx, 1);
    CGContextSetLineCap(ctx, kCGLineCapRound);
    CGContextSetLineJoin(ctx, kCGLineJoinRound);
    CGContextStrokePath(ctx);

    //secondLine
    cvRect.origin.x -= 1;
    cvRect.origin.y -= 1;
    cvRect.size.height += 2;
    cvRect.size.width += 2;
    bezierPath = [UIBezierPath bezierPathWithRoundedRect: cvRect cornerRadius: innerCornerRadius];
    CGPathRef borderPath2 = bezierPath.CGPath;

    CGContextBeginPath(ctx);
    CGContextAddPath(ctx, borderPath);
    CGContextSetRGBStrokeColor(ctx, red, green, blue, alpha);
    CGContextSetLineWidth(ctx, 1);
    CGContextSetLineCap(ctx, kCGLineCapRound);
    CGContextSetLineJoin(ctx, kCGLineJoinRound);
    CGContextStrokePath(ctx);
}

- (void) setupInnerShadow {

    innerShadow.layer.masksToBounds = YES;
    innerShadow.layer.cornerRadius = cornerRadius;
    innerShadow.layer.shadowRadius = cornerRadius;
    innerShadow.layer.borderWidth = 1.0;

    innerShadow.layer.shadowOpacity = 1.0;
    innerShadow.layer.shadowOffset = CGSizeMake(1, 1);
}


- (void) setupViews {
    //content posizion and size
    CGRect contentRect = _contentView.frame;
    CGRect titleRect = CGRectMake(borderWidth, borderWidth, self.bounds.size.width - (borderWidth * 2), 20);

    if (_arrowDirection == FPPopoverArrowDirectionUp) {
        contentRect.origin = CGPointMake(borderWidth, 60);
        contentRect.size = CGSizeMake(self.bounds.size.width - (borderWidth * 2), self.bounds.size.height - 70);

        titleRect.origin = CGPointMake(borderWidth, DP_POPOVER_ARROW_HEIGHT + borderWidth);
    }
    else if (_arrowDirection == FPPopoverArrowDirectionDown) {
        contentRect.origin = CGPointMake(borderWidth, 40);
        contentRect.size = CGSizeMake(self.bounds.size.width - (borderWidth * 2), self.bounds.size.height - 70);
    }

    else if (_arrowDirection == FPPopoverArrowDirectionRight) {
        contentRect.origin = CGPointMake(borderWidth, 40);
        contentRect.size = CGSizeMake(self.bounds.size.width - 40, self.bounds.size.height - 50);
    }

    else if (_arrowDirection == FPPopoverArrowDirectionLeft) {
        contentRect.origin = CGPointMake(borderWidth + DP_POPOVER_ARROW_HEIGHT, 40);
        contentRect.size = CGSizeMake(self.bounds.size.width - 40, self.bounds.size.height - 50);
    }

    CGFloat newHeight;
    CGFloat newWidth = self.bounds.size.width - (borderWidth * 3);

    if (self.title == nil || self.title.length == 0) {
        if (_arrowDirection == FPPopoverArrowDirectionUp) {

            newHeight = self.bounds.size.height - (borderWidth * 3) + 1;
            contentRect.origin = CGPointMake(titleRect.origin.x, titleRect.origin.y + 1);
            contentRect.size = CGSizeMake(self.bounds.size.width - (borderWidth * 2), newHeight);
        }

        else if (_arrowDirection == FPPopoverArrowDirectionDown) {

            newHeight = self.bounds.size.height - titleRect.origin.y - (borderWidth * 2);

            contentRect.origin = titleRect.origin;
            contentRect.size = CGSizeMake(self.bounds.size.width - (borderWidth * 2), newHeight);
        }
        else if (_arrowDirection == FPPopoverArrowDirectionRight) {
            contentRect.origin = titleRect.origin;
            contentRect.size = CGSizeMake(newWidth, self.bounds.size.height - (borderWidth * 2));
        }

        else if (_arrowDirection == FPPopoverArrowDirectionLeft) {
            contentRect.origin = CGPointMake(borderWidth + DP_POPOVER_ARROW_HEIGHT, borderWidth);
            contentRect.size = CGSizeMake(newWidth, self.bounds.size.height - (borderWidth * 2));
        }
    }

    _contentView.frame = contentRect;
    _contentView.layer.cornerRadius = cornerRadius;
    _contentView.clipsToBounds = YES;
    _contentView.layer.masksToBounds = YES;

    _titleLabel.frame = titleRect;
    _titleLabel.text = self.title;

    innerShadow.frame = contentRect;
    [self setupInnerShadow];
}


- (void) getRGBComponents: (CGFloat [4]) components forColor: (UIColor *) color {
    CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char resultingPixel[4];
    CGContextRef context = CGBitmapContextCreate(&resultingPixel,
            1,
            1,
            8,
            4,
            rgbColorSpace,
            kCGImageAlphaNoneSkipLast);
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, CGRectMake(0, 0, 1, 1));
    CGContextRelease(context);
    CGColorSpaceRelease(rgbColorSpace);

    for (int component = 0; component < 4; component++) {
        components[component] = resultingPixel[component] / 255.0f;
    }
}


@end