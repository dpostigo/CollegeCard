//
// Created by dpostigo on 9/21/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "cocos2d.h"
#import "OldLineDrawer.h"
#import "LinePoint.h"

#define MAX_SIZE 4.5f
#define MIN_SIZE 0.5f

@implementation OldLineDrawer {

    BOOL recentlyCleared;
    int playbackIndex;
}

@synthesize points;
@synthesize velocities;

@synthesize lineStyle;
@synthesize previousLineStyle;

@synthesize thickness;
@synthesize thicknessMax;
@synthesize pointProximity;

@synthesize hasCurrentLine;
@synthesize allowsTouchDispatcher;

@synthesize velocityDivider;
@synthesize drawing;
@synthesize canRedo;
@synthesize canUndo;
@synthesize backgroundLayer;
@synthesize undoneActions;

@synthesize discreteLines;
@synthesize lineActions;
@synthesize theClearingColor;
@synthesize sceneDelegate;

- (void) setLineStyle: (LineDrawerStyle) lineStyle1 {

    lineStyle = lineStyle1;
    lineColor = defaultLineColor;




    if (lineStyle == LineDrawerStyleEraser) {
        self.isErasing = YES;
        return;
    }

    else {
        isErasing = NO;

        lineStyle = previousLineStyle;
        lineColor = defaultLineColor;
        [self notifyDelegates: @selector(lineDrawerDidEndErasing) object: nil];


    }



    switch (lineStyle) {

        case LineDrawerStyleThin:
            overdraw = 0.8;
            thickness = 0.5;
            thicknessMax = 4.0;
            pointProximity = 1.5;
            velocityDivider = 166;
            break;

        case LineDrawerStyleThick:
            overdraw = 1.0;
            thickness = 1.0;
            thicknessMax = 4.5f;
            pointProximity = 1.5;
            velocityDivider = 166;
            break;

        case LineDrawerStyleThinRetina:
        case LineDrawerStyleUndefined:
            overdraw = 0.8;
            thickness = 0.5;
            thicknessMax = 4.0;
            pointProximity = 0.25;
            velocityDivider = 166;
            break;

        case LineDrawerStyleThickRetina:
            overdraw = 1.0;
            thickness = 1.0;
            thicknessMax = 4.5f;
            pointProximity = 0.25;
            velocityDivider = 166;
            break;

        case LineDrawerStyleMessy:
            overdraw = 1.0;
            thickness = 2.0;
            thicknessMax = 4.5f;
            pointProximity = 0.25;
            velocityDivider = 100.0;
            break;

        case LineDrawerStyleSuperThick :
            overdraw = 1.0;
            thickness = 5.0;
            thicknessMax = 5.5f;
            pointProximity = 0.25;
            velocityDivider = 200.0;
            break;

        case LineDrawerStyleEraser :

            break;
    }
}

- (void) setIsErasing: (BOOL) isErasing1 {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    isErasing = isErasing1;


    if (isErasing) {
        previousLineStyle = lineStyle;
        self.lineStyle = LineDrawerStyleSuperThick;
        self.lineColor = erasingColor;
        [self notifyDelegates: @selector(lineDrawerDidBeginErasing) object: nil];
    }

    else {
        lineStyle = previousLineStyle;
        self.lineColor = defaultLineColor;
        [self notifyDelegates: @selector(lineDrawerDidEndErasing) object: nil];
    }

}

- (id) initWithClearingColor: (ccColor4F) aClearingColor {
    self = [super initWithClearingColor: aClearingColor];
    if (self) {

        self.canUndo = NO;
        self.canRedo = NO;
        self.lineStyle = LineDrawerStyleThickRetina;
        self.isTouchEnabled = YES;

        pointProximity = 1.5;

        points = [[NSMutableArray alloc] init];
        velocities = [[NSMutableArray alloc] init];
        self.undoneActions = [[NSMutableArray alloc] init];
        self.lineActions = [[NSMutableArray alloc] init];

    }
    return self;
}



#pragma mark RenderTexture



- (void) setClearingColor: (ccColor4F) clearingColor1 {
    [super setClearingColor: clearingColor1];
    erasingColor = clearingColor;

    //[self clearRenderTexture];
    //[renderTexture end];
}

- (void) clearCanvas {
    [self clearRenderTexture];
    [renderTexture end];

    LineAction *action = [[LineAction alloc] initWithActionType: LineActionTypeWipe];
    [lineActions addObject: action];
}



#pragma mark Tool Actions

- (void) undo {
    if ([lineActions count] > 0) {

        self.canRedo = YES;

        LineAction *lastAction = [lineActions lastObject];
        [self undoAction: lastAction];

        [self redrawActions];
        if ([lineActions count] == 0) self.canUndo = NO;
    }

    else {
        self.canUndo = NO;
    }
}

- (void) undoAction: (LineAction *) lineAction {
    [lineActions removeObject: lineAction];
    [undoneActions addObject: lineAction];
}

- (void) redo {

    if ([undoneActions count] > 0) {
        LineAction *action = [undoneActions lastObject];
        [self redoAction: action];
        [self redrawActions];

        if ([undoneActions count] == 0)
            self.canRedo = NO;
    }

    else {
        NSLog(@"CANNOT REDO NO MORE.");
        self.canRedo = NO;
    }
}

- (void) redoAction: (LineAction *) lineAction {

    [undoneActions removeObject: lineAction];
    [lineActions addObject: lineAction];
}

- (void) performLineAction: (LineActionType) lineActionType {
    switch (lineActionType) {
        case LineActionTypeUndo :
            [self undo];
            break;
        case LineActionTypeRedo :
            [self redo];
            break;

        case LineActionTypePlayback :
            [self playback];
            break;

        default:
            //null
            break;
    }
}

- (void) redrawActions {
    [self clearRenderTexture];
    [renderTexture end];

    redrawing = YES;
    for (LineAction *action in lineActions) {
        [self redrawAction: action];
    }
    redrawing = NO;
    self.isErasing = NO;
}

- (void) redrawAction: (LineAction *) action {

    if (action.type == LineActionTypeDiscreteLine) {
        finishingLine = YES;
        connectingLine = NO;

        NSMutableArray *linePoints = [[NSMutableArray alloc] initWithArray: action.linePoints];
        [self redrawDiscreteLine: linePoints];
    }

    else if (action.type == LineActionTypeWipe) {

        [self clearRenderTexture];
        [renderTexture end];
    }
}


#pragma mark Playback

- (void) playback {
    [self clearRenderTexture];
    [renderTexture end];
    redrawing = YES;

    playbackIndex = 0;
    [self schedule: @selector(playbackTick)];

    redrawing = NO;
    self.isErasing = NO;
}

- (void) playbackTick {

    if (playbackIndex == [lineActions count]) {
        [self unschedule: @selector(playbackTick)];
    }

    else {
        LineAction *action = [lineActions objectAtIndex: playbackIndex];
        [self redrawAction: action];
        playbackIndex++;
    }
}



#pragma mark Setters
- (void) setLineActions: (NSMutableArray *) lineActions1 {
    lineActions = lineActions1;
    if ([lineActions count] > 0) {
        self.canUndo = YES;
    }
    else {
        self.canUndo = NO;
    }

    self.canRedo = NO;
    [self redrawActions];
}



#pragma mark Playback Draw
- (void) playbackDrawTick {

    if ([discreteLines count] == 0) {
        [self unschedule: @selector(playbackDrawTick)];
        self.discreteLines = [[NSMutableArray alloc] init];
    } else {
        NSMutableArray *linePoints = [discreteLines objectAtIndex: 0];
        [discreteLines removeObject: linePoints];
        [self redrawDiscreteLine: linePoints];

        connectingLine = NO;
    }
}




#pragma mark - Lines

- (void) startNewLineFrom: (CGPoint) newPoint withSize: (CGFloat) aSize {
    self.canUndo = YES;
    self.canRedo = NO;
    self.undoneActions = [[NSMutableArray alloc] init];
    drawing.wasModified = YES;

    if (currentAction != nil) {
        NSLog(@"previous action line points = %u", [currentAction.linePoints count]);
    }

    LineAction *action = [[LineAction alloc] initWithActionType: LineActionTypeDiscreteLine];
    [lineActions addObject: action];
    currentAction = action;

    recentlyCleared = NO;
    hasCurrentLine = YES;
    connectingLine = NO;
    [self addPoint: newPoint withSize: aSize isStarting: YES isEnding: NO];
}

- (void) endLineAt: (CGPoint) aEndPoint withSize: (CGFloat) aSize {

    NSLog(@"%s", __PRETTY_FUNCTION__);
    [self addPoint: aEndPoint withSize: aSize isStarting: NO isEnding: YES];

    hasCurrentLine = NO;
    finishingLine = YES;
    //currentAction = nil;




    NSLog(@"currentAction = %@", currentAction);
    NSLog(@"[lineActions count] = %u", [lineActions count]);
}

- (void) addPoint: (CGPoint) newPoint withSize: (CGFloat) size isStarting: (BOOL) isStarting isEnding: (BOOL) isEnding {

    LinePoint *point = [[LinePoint alloc] init];
    point.position = newPoint;
    point.width = size * thickness;

    point.startingPoint = isStarting;
    point.endingPoint = isEnding;
    point.lineStyle = self.lineStyle;
    point.isErasure = self.isErasing;

    [points addObject: point];
    [currentAction.linePoints addObject: point];
}

- (void) addPoint: (CGPoint) newPoint withSize: (CGFloat) size {
    [self addPoint: newPoint withSize: size isStarting: NO isEnding: NO];
}

- (void) addPoint: (CGPoint) newPoint withSize: (CGFloat) size checkProximity: (BOOL) checkProx {
    if (checkProx) {

        float eps = pointProximity;
        if ([points count] > 0) {
            float length = ccpLength(ccpSub([(LinePoint *) [points lastObject] position], newPoint));
            if (length < eps) {
                return;
            }

            else {
                [self addPoint: newPoint withSize: size];
            }
        }
    } else {

        [self addPoint: newPoint withSize: size];
    }
}





#pragma mark Draw


- (void) draw {
    [self drawDiscreteLine: points];
}





#pragma mark Helpers



- (float) extractSize: (UIPanGestureRecognizer *) panGestureRecognizer {
    //! result of trial & error

    float size;
    if (lineStyle == LineDrawerStyleSuperThick) {
        float vel = ccpLength([panGestureRecognizer velocityInView: panGestureRecognizer.view]);
        size = vel / velocityDivider;
        size = clampf(size, 1.0, thicknessMax);
        [velocities addObject: [NSNumber numberWithFloat: size]];
        size = thickness;
    }

    else {

        float vel = ccpLength([panGestureRecognizer velocityInView: panGestureRecognizer.view]);
        size = vel / velocityDivider;
        size = clampf(size, 0.0001f, thicknessMax);
        size = thicknessMax - size;
        [velocities addObject: [NSNumber numberWithFloat: size]];
    }

    return size;
}



#pragma mark Panning the canvas


- (void) panCanvas: (UITouch *) touch {

    CGPoint touchLocation = [self convertTouchToNodeSpace: touch];
    CGPoint oldTouchLocation = [touch previousLocationInView: touch.view];
    oldTouchLocation = [[CCDirector sharedDirector] convertToGL: oldTouchLocation];
    oldTouchLocation = [self convertToNodeSpace: oldTouchLocation];

    CGPoint translation = ccpSub(touchLocation, oldTouchLocation);
    [self panForTranslation: translation];
}

- (CGPoint) boundLayerPos: (CGPoint) newPos {
    CGSize winSize = [CCDirector sharedDirector].winSize;
    CGPoint retval = newPos;
    retval.x = MIN(retval.x, 0);
    retval.x = MAX(retval.x, renderTexture.contentSize.width + winSize.width);
    retval.y = self.position.y;
    return retval;
}

- (void) panForTranslation: (CGPoint) translation {

    CGPoint newPos = ccpAdd(self.position, translation);
    self.position = [self boundLayerPos: newPos];
}

@end