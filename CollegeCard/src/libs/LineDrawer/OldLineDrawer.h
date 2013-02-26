//
// Created by dpostigo on 9/21/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "VeryBasicLineDrawer.h"
#import "LineDrawerStyle.h"
#import "Drawing.h"
#import "LineAction.h"
#import "OldBasicLineDrawer.h"

@interface OldLineDrawer : OldBasicLineDrawer {

    CCLayerColor *backgroundLayer;
    NSMutableArray *points;
    NSMutableArray *velocities;
    float thickness;
    float thicknessMax;
    float pointProximity;
    float velocityDivider;
    BOOL hasCurrentLine;
    BOOL allowsTouchDispatcher;
    LineDrawerStyle lineStyle;
    LineDrawerStyle previousLineStyle;
    ccColor4F theClearingColor;
    __unsafe_unretained Drawing *drawing;
    NSMutableArray *undoneActions;
    NSMutableArray *discreteLines;
    NSMutableArray *lineActions;
    BOOL canRedo;
    BOOL canUndo;
    __unsafe_unretained id sceneDelegate;

    LineAction *currentAction;

}

@property(nonatomic, strong) CCLayerColor *backgroundLayer;
@property(nonatomic, strong) NSMutableArray *points;
@property(nonatomic, strong) NSMutableArray *velocities;
@property(nonatomic) LineDrawerStyle lineStyle;
@property(nonatomic) LineDrawerStyle previousLineStyle;
@property(nonatomic) float thickness;
@property(nonatomic) float thicknessMax;
@property(nonatomic) float pointProximity;
@property(nonatomic) BOOL hasCurrentLine;
@property(nonatomic) BOOL allowsTouchDispatcher;
@property(nonatomic) BOOL isErasing;
@property(nonatomic) float velocityDivider;
@property(nonatomic, assign) Drawing *drawing;
@property(nonatomic) BOOL canRedo;
@property(nonatomic) BOOL canUndo;
@property(nonatomic, strong) NSMutableArray *undoneActions;
@property(nonatomic, strong) NSMutableArray *discreteLines;
@property(nonatomic, strong) NSMutableArray *lineActions;

@property(nonatomic) ccColor4F theClearingColor;
@property(nonatomic, assign) id sceneDelegate;
- (id) initWithClearingColor: (ccColor4F) aClearingColor;
- (void) draw;
- (void) clearCanvas;
- (void) redoAction: (LineAction *) lineAction;
- (void) performLineAction: (LineActionType) lineActionType;
- (void) redrawActions;
- (void) undo;
- (void) undoAction: (LineAction *) lineAction;
- (void) redo;
- (void) playback;
- (void) startNewLineFrom: (CGPoint) newPoint withSize: (CGFloat) aSize;
- (void) addPoint: (CGPoint) newPoint withSize: (CGFloat) size;
- (void) addPoint: (CGPoint) newPoint withSize: (CGFloat) size checkProximity: (BOOL) checkProx;
- (void) endLineAt: (CGPoint) aEndPoint withSize: (CGFloat) aSize;
- (float) extractSize: (UIPanGestureRecognizer *) panGestureRecognizer;
- (void) panCanvas: (UITouch *) touch;

@end