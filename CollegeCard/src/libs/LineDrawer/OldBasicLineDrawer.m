//
// Created by dpostigo on 10/18/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "OldBasicLineDrawer.h"
#import "LinePoint.h"

@implementation OldBasicLineDrawer {
}

@synthesize renderTexture;
@synthesize lineColor;
@synthesize erasingColor;
@synthesize textureHeight;

- (id) initWithClearingColor: (ccColor4F) aClearingColor {
    self = [super init];
    if (self) {

        self.clearingColor = aClearingColor;

        lineColor = ccc4f(0, 0, 0, 1);
        defaultLineColor = ccc4f(0, 0, 0, 1);
        erasingColor = ccc4f(1, 1, 1, 1);


        [self createRenderTexture];
    }

    return self;
}



- (void) createRenderTexture {
    textureHeight = (768 - 20) / 2;

    self.renderTexture = [[CCRenderTexture alloc] initWithWidth: (int) textureSize.width height: (int) textureSize.height pixelFormat: kCCTexture2DPixelFormat_RGBA8888];
    renderTexture.anchorPoint = ccp(0, 0);
    renderTexture.position = ccp(textureSize.width / 2, textureHeight);

    [renderTexture beginWithClear: clearingColor.r g: clearingColor.g b: clearingColor.b a: clearingColor.a];
    [renderTexture end];
    [self addChild: renderTexture];
    //[[renderTexture sprite] setBlendFunc: (ccBlendFunc) {GL_ONE_MINUS_SRC_COLOR, GL_SRC_COLOR}];
}


- (void) clearRenderTexture {
    [renderTexture beginWithClear: clearingColor.r g: clearingColor.g b: clearingColor.b a: clearingColor.a];
}



- (void) instantRedraw: (NSMutableArray *) linePoints {

    NSMutableArray *discreteLines = [self getDiscreteLines: linePoints];

    redrawing = YES;

    for (NSMutableArray *line in discreteLines) {
        finishingLine = YES;
        connectingLine = NO;
        [self redrawDiscreteLine: line];
    }

    redrawing = NO;
    self.isErasing = NO;
}

- (NSMutableArray *) getDiscreteLines: (NSMutableArray *) linePoints {

    NSLog(@"points = %u", [linePoints count]);

    NSMutableArray *points1 = [[NSMutableArray alloc] initWithArray: linePoints];
    NSMutableArray *discreteLines = [[NSMutableArray alloc] init];

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
    return discreteLines;
}


- (void) redrawDiscreteLine: (NSMutableArray *) linePoints {
    LinePoint *firstPoint = [linePoints objectAtIndex: 0];
    self.isErasing = firstPoint.isErasure;
    [self drawDiscreteLine: linePoints];
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

@end