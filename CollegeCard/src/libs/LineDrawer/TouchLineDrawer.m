/*
 * Smooth drawing: http://merowing.info
 *
 * Copyright (c) 2012 Krzysztof Zabłocki
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 */


#import "cocos2d.h"
#import "TouchLineDrawer.h"
#import "CCNode+SFGestureRecognizers.h"

@implementation TouchLineDrawer {
    BOOL allowSwipe;
    BOOL isPanning;
    BOOL isClearing;
    BOOL canDraw;
}

@synthesize eraserDrawer;

+ (id) node {
    return [[self alloc] initWithClearingColor: ccc4f(0, 0, 0, 0)];
}

- (id) initWithClearingColor: (ccColor4F) aClearingColor {
    self = [super initWithClearingColor: aClearingColor];
    if (self) {

        self.allowsTouchDispatcher = YES;
        [self addGestureRecognizers];
    }

    return self;
}

- (void) setEraserDrawer: (TouchLineDrawer *) eraserDrawer1 {
    eraserDrawer = eraserDrawer1;
    [eraserDrawer subscribeDelegate: self];
}

- (void) lineDrawerEndedDrawingWithAction: (LineAction *) lineAction {
    [lineActions addObject: lineAction];
}

- (void) setIsErasing: (BOOL) isErasing1 {
    [super setIsErasing: isErasing1];

    if (isErasing && eraserDrawer != nil) {
    }
}

- (void) undoAction: (LineAction *) lineAction {
    if (eraserDrawer != nil && [eraserDrawer.lineActions containsObject: lineAction]) {
        [eraserDrawer undoAction: lineAction];
    }
    [super undoAction: lineAction];
}

- (void) redoAction: (LineAction *) lineAction {
    if (eraserDrawer != nil && [eraserDrawer.undoneActions containsObject: lineAction]) {
        [eraserDrawer redoAction: lineAction];
    }
    [super redoAction: lineAction];
}

- (void) redrawActions {
    if (eraserDrawer != nil) {
        [eraserDrawer redrawActions];
    }
    [super redrawActions];
}

- (void) onEnter {
    [[CCDirector sharedDirector].touchDispatcher addTargetedDelegate: self priority: 0 swallowsTouches: YES];
    [super onEnter];
}

- (void) onExit {
    [[CCDirector sharedDirector].touchDispatcher removeAllDelegates];
    [super onExit];
}

- (void) setBlending {
    [super setBlending];

    if (eraserDrawer == nil) {
        glBlendFuncSeparate(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA, GL_ONE, GL_ONE_MINUS_SRC_COLOR);
    }

    else {
        glBlendFuncSeparate(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA, GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
    }
}


#pragma mark Gesture recognizers

- (void) addGestureRecognizers {
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget: self action: @selector(handlePanGesture:)];
    panGestureRecognizer.maximumNumberOfTouches = 1;
    [self addGestureRecognizer: panGestureRecognizer];

    UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget: self action: @selector(handleLongPress:)];
    longPressGestureRecognizer.numberOfTouchesRequired = 1;
    [self addGestureRecognizer: longPressGestureRecognizer];

    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(handleTapGesture:)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    //[self addGestureRecognizer: tapGestureRecognizer];
}


#pragma mark - Math

#pragma mark - GestureRecognizers

- (void) handleSwipeGestureUp: (UISwipeGestureRecognizer *) swipeGesture {

    if (swipeGesture.state == UIGestureRecognizerStateBegan) {
        CGPoint location = [swipeGesture locationInView: swipeGesture.view];
        NSLog(@"NSStringFromCGPoint(location) = %@", NSStringFromCGPoint(location));
        if (location.y > (768 * 0.5)) {

            NSLog(@"%s", __PRETTY_FUNCTION__);
            allowSwipe = YES;
        } else {
            allowSwipe = NO;
        }
    }

    else if (swipeGesture.state == UIGestureRecognizerStateEnded) {

        if (allowSwipe) {
            allowSwipe = NO;

            [self notifyDelegates: @selector(showTools:) object: nil];
        }
    }
}

- (void) handleSwipeGestureDown: (UISwipeGestureRecognizer *) swipeGesture {

    NSLog(@"%s", __PRETTY_FUNCTION__);

    [self notifyDelegates: @selector(hideTools:) object: nil];
}

- (void) handleTapGesture: (UITapGestureRecognizer *) tapGestureRecognizer {

    NSLog(@"%s", __PRETTY_FUNCTION__);

    const CGPoint point = [[CCDirector sharedDirector] convertToGL: [tapGestureRecognizer locationInView: tapGestureRecognizer.view]];
    float size = 3;

    [points removeAllObjects];
    [velocities removeAllObjects];

    [self startNewLineFrom: point withSize: size];
    [self addPoint: CGPointMake(point.x, point.y + 2) withSize: size];
    [self endLineAt: CGPointMake(point.x, point.y + 4) withSize: size];
}

- (void) handlePanGesture: (UIPanGestureRecognizer *) panGestureRecognizer {

    const CGPoint point = [[CCDirector sharedDirector] convertToGL: [panGestureRecognizer locationInView: panGestureRecognizer.view]];
    float size = [self extractSize: panGestureRecognizer];

    if (panGestureRecognizer.state == UIGestureRecognizerStateBegan) {
        NSLog(@"panGestureRecognizer StateBegan");
        isPanning = YES;


        //NSLog(@"Beginning point = %@", NSStringFromCGPoint(point));
        if (hasCurrentLine) {
            NSLog(@"hasCurrentLine");
            [self addPoint: point withSize: size checkProximity: YES];
        }
        else {

            [points removeAllObjects];
            [velocities removeAllObjects];

            [self startNewLineFrom: point withSize: size];
            [self addPoint: point withSize: size];
            [self addPoint: point withSize: size];
            [self lineDrawingDidBegin];
        }
    }

    if (panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        //! skip points that are too close
        //NSLog(@"changed point = %@", NSStringFromCGPoint(point));
        if (!hasCurrentLine) NSLog(@"Doesn't have current line.");
        [self addPoint: point withSize: size checkProximity: YES];
    }

    if (panGestureRecognizer.state == UIGestureRecognizerStateEnded) {
        isPanning = NO;
        [self endLineAt: point withSize: size];
        [self lineDrawingDidEnd];
    }
}

- (void) handleLongPress: (UILongPressGestureRecognizer *) longPressGestureRecognizer {
    [self clearCanvas];
}

- (void) ccTouchesBegan: (NSSet *) touches withEvent: (UIEvent *) event {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    [self checkTouchCount: touches];
}

- (void) ccTouchesCancelled: (NSSet *) touches withEvent: (UIEvent *) event {
    [self checkTouchCount: touches];
}

- (void) ccTouchesEnded: (NSSet *) touches withEvent: (UIEvent *) event {
    [self checkTouchCount: touches];
}

- (void) checkTouchCount: (NSSet *) touches {
    NSArray *array = [touches allObjects];
    if ([array count] == 1) {
        canDraw = YES;
    }

    else canDraw = NO;

    UITouch *touch = [array objectAtIndex: 0];
    CGPoint point = [[CCDirector sharedDirector] convertToGL: [touch locationInView: touch.view]];

    if (panningEnabled && point.x > rightBoundary) {
        shouldPan = YES;
        canDraw = NO;
    }
}

- (BOOL) ccTouchBegan: (UITouch *) touch withEvent: (UIEvent *) event {

    CGPoint point = [[CCDirector sharedDirector] convertToGL: [touch locationInView: touch.view]];

    NSLog(@"point.x = %f", point.x);
    NSLog(@"rightBoundary = %f", rightBoundary);

    if (canDraw) {
        float size = 1.0;

        [points removeAllObjects];
        [velocities removeAllObjects];

        [self startNewLineFrom: point withSize: size];
        [self addPoint: point withSize: size];
        [self addPoint: point withSize: size];
        [self lineDrawingDidBegin];

        return YES;
    }

    else {
        return NO;
    }
}

- (void) ccTouchMoved: (UITouch *) touch withEvent: (UIEvent *) event {
    //[super ccTouchMoved: touch withEvent: event];

    if (panningEnabled && shouldPan) {
        [self panCanvas: touch];
    }
}

- (void) ccTouchEnded: (UITouch *) touch withEvent: (UIEvent *) event {
    if (hasCurrentLine) {
        CGPoint point = [[CCDirector sharedDirector] convertToGL: [touch locationInView: touch.view]];
        float size = 1.0;

        [self endLineAt: point withSize: size];
        [self lineDrawingDidEnd];
    }

    shouldPan = NO;
}

- (void) ccTouchCancelled: (UITouch *) touch withEvent: (UIEvent *) event {
    //[super ccTouchCancelled: touch withEvent: event];

    if (hasCurrentLine && !isPanning) {
        CGPoint point = [[CCDirector sharedDirector] convertToGL: [touch locationInView: touch.view]];
        float size = 1.0;

        [self endLineAt: point withSize: size];
        [self lineDrawingDidEnd];
    }

    shouldPan = NO;
}



/*

- (BOOL) ccTouchBegan: (UITouch *) touch withEvent: (UIEvent *) event; {
    NSLog(@"%s", __PRETTY_FUNCTION__);

    if (isClearing) return NO;

    CGPoint point = [[CCDirector sharedDirector] convertToGL: [touch locationInView: touch.view]];
    float size = 1.0;

    [points removeAllObjects];
    [velocities removeAllObjects];

    [self startNewLineFrom: point withSize: size];
    [self addPoint: point withSize: size];
    [self addPoint: point withSize: size];
    [self lineDrawingDidBegin];
    return YES;


}


- (void) ccTouchMoved: (UITouch *) touch withEvent: (UIEvent *) event; {
    if (!isPanning && !isClearing) {
        CGPoint point = [[CCDirector sharedDirector] convertToGL: [touch locationInView: touch.view]];
        float size = 1.0;

        [self addPoint: point withSize: size checkProximity: YES];
    }
}


- (void) ccTouchEnded: (UITouch *) touch withEvent: (UIEvent *) event; {
    NSLog(@"%s", __PRETTY_FUNCTION__);

    if (!isPanning && !isClearing) {
        NSLog(@"Doing stuff");
        CGPoint point = [[CCDirector sharedDirector] convertToGL: [touch locationInView: touch.view]];
        float size = 1.0;

        [self endLineAt: point withSize: size];
        [self lineDrawingDidEnd];
    }
}

*/


#pragma mark Delegate communication


- (void) lineDrawingDidBegin {

    NSLog(@"%s", __PRETTY_FUNCTION__);
    [self notifyDelegates: @selector(lineDrawerBeganDrawing:) object: nil];
}

- (void) lineDrawingDidEnd {

    [self notifyDelegates: @selector(lineDrawerEndedDrawing:) object: nil];
    [self notifyDelegates: @selector(lineDrawerEndedDrawingWithAction:) object: currentAction];
}

- (void) setCanRedo: (BOOL) canRedo1 {
    canRedo = canRedo1;
    [self notifyDelegates: @selector(lineDrawerChangedRedo:) object: self];
}

- (void) setCanUndo: (BOOL) canUndo1 {
    canUndo = canUndo1;
    [self notifyDelegates: @selector(lineDrawerChangedUndo:) object: self];
}

@end