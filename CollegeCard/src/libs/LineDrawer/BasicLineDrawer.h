//
// Created by dpostigo on 10/16/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "BasicCocoaLayer.h"
#import "cocos2d.h"


typedef struct _LineVertex {
    CGPoint pos;
    float z;
    ccColor4F color;
} LineVertex;



@interface BasicLineDrawer : BasicCocoaLayer {

    float overdraw;

    BOOL redrawing;
    BOOL connectingLine;
    BOOL finishingLine;
    BOOL isErasing;


    CGPoint prevC, prevD;
    CGPoint prevG;
    CGPoint prevI;


    NSMutableArray *circlesPoints;

    float colorRed;
    float colorGreen;
    float colorBlue;
    float colorAlpha;
    UIColor *clearingColor;
}

@property(nonatomic) float overdraw;
@property(nonatomic) BOOL redrawing;
@property(nonatomic) BOOL connectingLine;
@property(nonatomic) BOOL finishingLine;
@property(nonatomic) BOOL isErasing;
@property(nonatomic) CGPoint prevC;
@property(nonatomic) CGPoint prevD;
@property(nonatomic) CGPoint prevG;
@property(nonatomic) CGPoint prevI;
@property(nonatomic, strong) NSMutableArray *circlesPoints;
@property(nonatomic, strong) UIColor *clearingColor;
@property(nonatomic) float colorRed;
@property(nonatomic) float colorGreen;
@property(nonatomic) float colorBlue;
@property(nonatomic) float colorAlpha;
- (void) drawLines: (NSArray *) linePoints withColor: (ccColor4F) color;
- (void) setBlending;
- (void) fillLineTriangles: (LineVertex *) vertices count: (NSUInteger) count withColor: (ccColor4F) color;
- (void) fillLineEndPointAt: (CGPoint) center direction: (CGPoint) aLineDir radius: (CGFloat) radius andColor: (ccColor4F) color;
- (NSMutableArray *) calculateSmoothLinePointsWithLine: (NSMutableArray *) linePoints;

@end