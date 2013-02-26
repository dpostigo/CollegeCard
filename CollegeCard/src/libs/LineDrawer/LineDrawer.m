//
// Created by dpostigo on 9/21/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "cocos2d.h"
#import "LineDrawer.h"
#import "LinePoint.h"

#define MAX_SIZE 4.5f
#define MIN_SIZE 0.5f

@implementation LineDrawer {

    float textureHeight;
    BOOL recentlyCleared;
    int playbackIndex;
    LineAction *currentAction;
}

@synthesize points;
@synthesize velocities;
@synthesize savedPoints;

@synthesize lineStyle;
@synthesize previousLineStyle;

@synthesize thickness;
@synthesize thicknessMax;
@synthesize pointProximity;

@synthesize hasCurrentLine;
@synthesize allowsTouchDispatcher;

@synthesize lineColor;
@synthesize erasingColor;
@synthesize defaultLineColor;
@synthesize velocityDivider;
@synthesize cachedSavedPoints;
@synthesize drawing;
@synthesize canRedo;
@synthesize canUndo;
@synthesize backgroundLayer;
@synthesize undoneActions;

@synthesize discreteLines;
@synthesize lineActions;
@synthesize renderTexture;
@synthesize theClearingColor;

- (void) setLineStyle: (LineDrawerStyle) lineStyle1 {

    lineStyle = lineStyle1;
    lineColor = defaultLineColor;

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
            self.isErasing = YES;
            break;
    }
}

- (void) setIsErasing: (BOOL) isErasing1 {
    isErasing = isErasing1;
    if (isErasing) {
        previousLineStyle = lineStyle;
        self.lineStyle = LineDrawerStyleSuperThick;
        self.lineColor = erasingColor;
    }

    else {
        self.lineStyle = previousLineStyle;
        self.lineColor = defaultLineColor;
    }
}

- (id) initWithClearingColor: (UIColor *) aClearingColor {
    self = [super init];
    if (self) {

        self.canUndo = NO;
        self.canRedo = NO;

        self.lineStyle = LineDrawerStyleThickRetina;
        self.clearingColor = aClearingColor;

        lineColor = ccc4f(0, 0, 0, 1);
        defaultLineColor = ccc4f(0, 0, 0, 1);

        erasingColor = ccc4f(colorRed, colorGreen, colorBlue, colorAlpha);


        pointProximity = 1.5;
        textureHeight = (768 - 20) / 2;

        savedPoints = [[NSMutableArray alloc] init];
        points = [[NSMutableArray alloc] init];
        velocities = [[NSMutableArray alloc] init];

        self.undoneActions = [[NSMutableArray alloc] init];
        self.lineActions = [[NSMutableArray alloc] init];

        shaderProgram_ = [[CCShaderCache sharedShaderCache] programForKey: kCCShader_PositionColor];
        overdraw = 1.0;

        self.lineStyle = LineDrawerStyleThick;
        [self initRenderTexture];

        self.isTouchEnabled = YES;
    }
    return self;
}



#pragma mark RenderTexture


- (void) initRenderTexture {

    self.renderTexture = [[CCRenderTexture alloc] initWithWidth: (int) textureSize.width height: (int) textureSize.height pixelFormat: kCCTexture2DPixelFormat_RGBA8888];
    renderTexture.anchorPoint = ccp(0, 0);
    renderTexture.position = ccp(textureSize.width / 2, textureHeight);



    [renderTexture beginWithClear: colorRed g: colorGreen b: colorBlue a: colorAlpha];
    [renderTexture end];
    [self addChild: renderTexture];
    //[[renderTexture sprite] setBlendFunc: (ccBlendFunc) {GL_ONE_MINUS_SRC_COLOR, GL_SRC_COLOR}];
}

- (void) setClearingColor: (UIColor *) clearingColor1 {
    [super setClearingColor: clearingColor1];

    erasingColor = ccc4f(colorRed, colorGreen, colorBlue, colorAlpha);
    //[self clearRenderTexture];
    //[renderTexture end];
}

- (void) clearCanvas {
    [self clearRenderTexture];
    [renderTexture end];

    LineAction *action = [[LineAction alloc] initWithActionType: LineActionTypeWipe];
    [lineActions addObject: action];
}

- (void) clearRenderTexture {

    [renderTexture beginWithClear: colorRed g: colorGreen b: colorBlue a: colorAlpha];

}



#pragma mark Tool Actions

- (void) undo {


    NSLog(@"%s", __PRETTY_FUNCTION__);
    if ([lineActions count] > 0) {

        self.canRedo = YES;

        LineAction *lastAction = [lineActions lastObject];
        [lineActions removeObject: lastAction];
        [undoneActions addObject: lastAction];

        [self redrawActions];
        if ([lineActions count] == 0) self.canUndo = NO;
    }

    else {
        self.canUndo = NO;
    }
}

- (void) redo {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    NSLog(@"[undoneActions count] = %u", [undoneActions count]);
    if ([undoneActions count] > 0) {
        LineAction *action = [undoneActions lastObject];
        [undoneActions removeObject: action];
        [lineActions addObject: action];
        [self redrawActions];

        if ([undoneActions count] == 0)
            self.canRedo = NO;
    }

    else {
        NSLog(@"CANNOT REDO NO MORE.");
        self.canRedo = NO;
    }
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


#pragma mark Playblack

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

- (void) setPoints: (NSMutableArray *) points1 {
    [self instantRedraw: points1];
}

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



- (void) instantRedraw: (NSMutableArray *) linePoints {

    NSLog(@"[linePoints count] = %u", [linePoints count]);
    [self prepareForRedraw: linePoints];
    redrawing = YES;

    for (NSMutableArray *line in discreteLines) {
        finishingLine = YES;
        connectingLine = NO;
        [self redrawDiscreteLine: line];
    }

    redrawing = NO;
    self.isErasing = NO;
}

- (void) prepareForRedraw: (NSMutableArray *) linePoints {
    [savedPoints addObjectsFromArray: linePoints];
    [self findDiscreteLines: savedPoints];
}

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

- (void) redrawDiscreteLine: (NSMutableArray *) linePoints {
    LinePoint *firstPoint = [linePoints objectAtIndex: 0];
    self.isErasing = firstPoint.isErasure;

    [self drawDiscreteLine: linePoints];
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

- (void) addPoint: (CGPoint) newPoint withSize: (CGFloat) size {
    [self addPoint: newPoint withSize: size isStarting: NO isEnding: NO];
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
    [savedPoints addObject: point];


    [currentAction.linePoints addObject: point];
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

- (void) eraseLine: (NSMutableArray *) linePoints {
}

- (void) draw {
    [self drawDiscreteLine: points];
}

- (void) drawDiscreteLine: (NSMutableArray *) linePoints {
    [self drawDiscreteLine: linePoints withColor: self.lineColor];
}

- (void) drawErasureLine: (NSMutableArray *) linePoints {
    [self drawDiscreteLine: linePoints withColor: self.erasingColor];
}

- (void) drawDiscreteLine: (NSMutableArray *) linePoints withColor: (ccColor4F) color {
    [renderTexture begin];

    NSMutableArray *smoothedPoints = [self calculateSmoothLinePointsWithLine: linePoints];
    if (smoothedPoints) {
        [self drawLines: smoothedPoints withColor: color];
    }
    [renderTexture end];
}





#pragma mark Helpers



- (void) findDiscreteLines: (NSMutableArray *) linePoints {

    NSLog(@"points = %u", [linePoints count]);

    NSMutableArray *points1 = [[NSMutableArray alloc] initWithArray: linePoints];
    self.discreteLines = [[NSMutableArray alloc] init];

    while ([points1 count] > 0) {

        NSMutableArray *discreteLine = [[NSMutableArray alloc] init];

        for (LinePoint *point in points1) {
            [discreteLine addObject: point];
            if (point.endingPoint) {
                break;
            }
        }

        [points1 removeObjectsInArray: discreteLine];
        [discreteLines addObject: discreteLine];
    }

    NSLog(@"num of discreteLines = %u", [discreteLines count]);
}

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