//
// Created by dpostigo on 10/4/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "CCScene.h"
#import "TouchLineDrawer.h"

@interface LineScene : CCScene {

    __unsafe_unretained Drawing *drawing;
    TouchLineDrawer *drawer;
    TouchLineDrawer *lineDrawer;
    TouchLineDrawer *eraserDrawer;
    CCSprite *backgroundSprite;


}

@property(nonatomic, strong) TouchLineDrawer *lineDrawer;
@property(nonatomic, strong) CCSprite *backgroundSprite;
@property(nonatomic, assign) Drawing *drawing;
@property(nonatomic, strong) TouchLineDrawer *drawer;
@property(nonatomic, strong) TouchLineDrawer *eraserDrawer;
- (id) initWithDrawing: (__unsafe_unretained Drawing *) aDrawing;
- (void) updateDrawing;

@end