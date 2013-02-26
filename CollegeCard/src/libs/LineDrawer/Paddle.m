/* TouchesTest (c) Valentin Milea 2009
 */
#import "Paddle.h"
#import "cocos2d.h"

@implementation Paddle

- (CGRect) rectInPixels {
    CGSize s = [texture_ contentSizeInPixels];
    return CGRectMake(-s.width / 2, -s.height / 2, s.width, s.height);
}

- (CGRect) rect {
    CGSize s = [texture_ contentSize];
    return CGRectMake(-s.width / 2, -s.height / 2, s.width, s.height);
}

+ (id) paddleWithTexture: (CCTexture2D *) aTexture {
    return [[self alloc] initWithTexture: aTexture];
}



- (id) initWithTexture: (CCTexture2D *) aTexture {
    self = [super initWithTexture: aTexture];
    if (self) {

        state = kPaddleStateUngrabbed;
    }

    return self;
}



- (void) onEnter {
    CCDirector *director = [CCDirector sharedDirector];

    [[director touchDispatcher] addTargetedDelegate: self priority: 0 swallowsTouches: YES];
    [super onEnter];
}

- (void) onExit {
    CCDirector *director = [CCDirector sharedDirector];

    [[director touchDispatcher] removeDelegate: self];
    [super onExit];
}

- (BOOL) containsTouchLocation: (UITouch *) touch {
    CGPoint p = [self convertTouchToNodeSpaceAR: touch];
    CGRect r = [self rectInPixels];
    NSLog(@"NSStringFromCGRect(r) = %@", NSStringFromCGRect(r));
    NSLog(@"NSStringFromCGPoint(p) = %@", NSStringFromCGPoint(p));
    return CGRectContainsPoint(r, p);
}

- (BOOL) ccTouchBegan: (UITouch *) touch withEvent: (UIEvent *) event {
    NSLog(@"%s", __PRETTY_FUNCTION__);

    if (state != kPaddleStateUngrabbed) {
        NSLog(@"returning no 1");
        return NO;
    }
    if (![self containsTouchLocation: touch]) {
        NSLog(@"does not contain point");
        return NO;
    }

    state = kPaddleStateGrabbed;
    return YES;
}

- (void) ccTouchMoved: (UITouch *) touch withEvent: (UIEvent *) event {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    // If it weren't for the TouchDispatcher, you would need to keep a reference
    // to the touch from touchBegan and check that the current touch is the same
    // as that one.
    // Actually, it would be even more complicated since in the Cocos dispatcher
    // you get NSSets instead of 1 UITouch, so you'd need to loop through the set
    // in each touchXXX method.

    NSAssert(state == kPaddleStateGrabbed, @"Paddle - Unexpected state!");

    CGPoint touchPoint = [touch locationInView: [touch view]];
    touchPoint = [[CCDirector sharedDirector] convertToGL: touchPoint];

    self.position = CGPointMake(touchPoint.x, self.position.y);
}

- (void) ccTouchEnded: (UITouch *) touch withEvent: (UIEvent *) event {
    NSAssert(state == kPaddleStateGrabbed, @"Paddle - Unexpected state!");

    state = kPaddleStateUngrabbed;
}
@end
