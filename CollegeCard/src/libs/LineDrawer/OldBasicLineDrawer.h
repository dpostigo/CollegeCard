//
// Created by dpostigo on 10/18/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "VeryBasicLineDrawer.h"

@interface OldBasicLineDrawer : VeryBasicLineDrawer {

    CCRenderTexture *renderTexture;

    ccColor4F lineColor;
    ccColor4F defaultLineColor;
    ccColor4F erasingColor;


    float textureHeight;


}

@property(nonatomic, strong) CCRenderTexture *renderTexture;
@property(nonatomic) ccColor4F lineColor;
@property(nonatomic) ccColor4F erasingColor;
@property(nonatomic) float textureHeight;
- (id) initWithClearingColor: (ccColor4F) aClearingColor;
- (void) createRenderTexture;
- (void) clearRenderTexture;
- (void) instantRedraw: (NSMutableArray *) linePoints;
- (void) redrawDiscreteLine: (NSMutableArray *) linePoints;
- (void) drawDiscreteLine: (NSMutableArray *) linePoints;
- (void) drawDiscreteLine: (NSMutableArray *) linePoints withColor: (ccColor4F) color;

@end