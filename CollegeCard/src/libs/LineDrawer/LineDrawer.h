//
// Created by dpostigo on 9/21/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "BasicLineDrawer.h"
#import "LineDrawerStyle.h"
#import "Drawing.h"
#import "LineAction.h"

@interface LineDrawer : BasicLineDrawer {

    CCLayerColor *backgroundLayer;
    CCRenderTexture *renderTexture;
    NSMutableArray *points;
    NSMutableArray *velocities;
    NSMutableArray *savedPoints;
    NSMutableArray *cachedSavedPoints;
    float thickness;
    float thicknessMax;
    float pointProximity;
    float velocityDivider;
    BOOL hasCurrentLine;
    BOOL allowsTouchDispatcher;
    LineDrawerStyle lineStyle;
    LineDrawerStyle previousLineStyle;
    ccColor4F lineColor;
    ccColor4F defaultLineColor;
    ccColor4F erasingColor;
    ccColor4F theClearingColor;
    __unsafe_unretained Drawing *drawing;
    NSMutableArray *undoneActions;
    NSMutableArray *discreteLines;
    NSMutableArray *lineActions;
    BOOL canRedo;
    BOOL canUndo;
}

@property(nonatomic, strong) CCLayerColor *backgroundLayer;
@property(nonatomic, strong) NSMutableArray *points;
@property(nonatomic, strong) NSMutableArray *velocities;
@property(nonatomic, strong) NSMutableArray *savedPoints;
@property(nonatomic) LineDrawerStyle lineStyle;
@property(nonatomic) LineDrawerStyle previousLineStyle;
@property(nonatomic) float thickness;
@property(nonatomic) float thicknessMax;
@property(nonatomic) float pointProximity;
@property(nonatomic) BOOL hasCurrentLine;
@property(nonatomic) BOOL allowsTouchDispatcher;
@property(nonatomic) BOOL isErasing;
@property(nonatomic) ccColor4F lineColor;
@property(nonatomic) ccColor4F erasingColor;
@property(nonatomic) ccColor4F defaultLineColor;
@property(nonatomic) float velocityDivider;
@property(nonatomic, strong) NSMutableArray *cachedSavedPoints;
@property(nonatomic, assign) Drawing *drawing;
@property(nonatomic) BOOL canRedo;
@property(nonatomic) BOOL canUndo;
@property(nonatomic, strong) NSMutableArray *undoneActions;
@property(nonatomic, strong) NSMutableArray *discreteLines;
@property(nonatomic, strong) NSMutableArray *lineActions;
@property(nonatomic, strong) CCRenderTexture *renderTexture;
@property(nonatomic) ccColor4F theClearingColor;
- (id) initWithClearingColor: (UIColor *) aClearingColor;
- (void) draw;
- (void) clearCanvas;
- (void) performLineAction: (LineActionType) lineActionType;
- (void) undo;
- (void) redo;
- (void) playback;
- (void) startNewLineFrom: (CGPoint) newPoint withSize: (CGFloat) aSize;
- (void) addPoint: (CGPoint) newPoint withSize: (CGFloat) size;
- (void) addPoint: (CGPoint) newPoint withSize: (CGFloat) size checkProximity: (BOOL) checkProx;
- (void) endLineAt: (CGPoint) aEndPoint withSize: (CGFloat) aSize;
- (float) extractSize: (UIPanGestureRecognizer *) panGestureRecognizer;
- (void) panCanvas: (UITouch *) touch;

@end