//
// Created by dpostigo on 9/24/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <QuartzCore/QuartzCore.h>
#import "Toolbox.h"

@implementation Toolbox {

}

@synthesize buttons;

@synthesize isOpen;

@synthesize delegate;
@synthesize strings;
@synthesize controls;
@synthesize labels;


- (id) initWithFrame: (CGRect) frame {
    self = [super initWithFrame: frame];
    if (self) {

        self.isOpen = NO;
        self.backgroundColor = [UIColor colorWithWhite: 0.0 alpha: 0.8];

        self.buttons = [[NSMutableArray alloc] init];
        self.strings = [[NSMutableArray alloc] init];
        self.labels = [[NSMutableArray alloc] init];
        [self rasterize];


        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(handleTap:)];
        [self addGestureRecognizer: tapGesture];
    }

    return self;
}




- (void) addButton: (NSString *) textLabel {
    UIButton *button = [self createButtonForTextLabel: textLabel];
    [button addTarget: self action: @selector(handleButtonTapped:) forControlEvents: UIControlEventTouchUpInside];
    [buttons addObject: button];
    [strings addObject: textLabel];
    [self addSubview: button];

}



- (UIButton *) createButtonForTextLabel: (NSString *) textLabel {


    UIView *background = [[UIView alloc] initWithFrame: CGRectMake(0, 0, 30, 30)];
    background.backgroundColor = [UIColor blackColor];
    background.layer.cornerRadius = 5.0;

    UILabel *label = [[UILabel alloc] initWithFrame: background.frame];
    label.backgroundColor = [UIColor clearColor];
    label.text = textLabel;
    label.font = [UIFont fontWithName: @"HelveticaNeue-Bold" size: 12.0];
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.textColor = [UIColor whiteColor];

    UIButton *button = [UIButton buttonWithType: UIButtonTypeCustom];
    button.frame = background.frame;

    CGFloat buttonPadding = 5;
    label.frame = CGRectMake(buttonPadding, buttonPadding, background.width - (buttonPadding*2), background.height - (buttonPadding*2));

    [labels addObject: label];
    [button addSubview: background];
    [button addSubview: label];
    background.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
    label.autoresizingMask = background.autoresizingMask;

    button.showsTouchWhenHighlighted = YES;
    return button;

}



- (void) handleButtonTapped: (id) sender {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}


- (void) handleTap: (UITapGestureRecognizer *) tapGesture {


    CGPoint location = [tapGesture locationInView: self];

    UIButton *selectedButton;
    for (UIButton *button in buttons) {
        if (CGRectContainsPoint(button.frame, location)) {
            selectedButton = button;
            break;

        }
    }


    if (selectedButton != nil) {
        NSUInteger index = [buttons indexOfObject: selectedButton];
        [self setSelectedButtonIndex: index];
    }
}


- (void) setSelectedButtonIndex: (NSUInteger) index {
    UIButton *selectedButton = [buttons objectAtIndex: index];

    for (UIButton *button in buttons) {
        button.alpha = 0.5;
    }
    selectedButton.alpha = 1;
    [delegate buttonTappedAtIndex: index];
    [delegate buttonTappedForString: [strings objectAtIndex: index]];

}

#pragma mark Helpers



- (void) layoutSubviews {
    [super layoutSubviews];

    CGFloat padding = 10;
    CGFloat prevX = padding;


    for (UIButton *button in buttons) {
        button.top = padding;
        button.height = self.height - (padding*2);
        button.width = button.height;
        button.left = prevX;
        prevX = button.right + padding;
    }
}

@end