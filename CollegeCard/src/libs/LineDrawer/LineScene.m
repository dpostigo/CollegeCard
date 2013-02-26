//
// Created by dpostigo on 10/4/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "LineScene.h"

@implementation LineScene {
}

@synthesize lineDrawer;
@synthesize backgroundSprite;
@synthesize drawing;
@synthesize drawer;
@synthesize eraserDrawer;

- (id) init {
    self = [super init];
    if (self) {
    }

    return self;
}

- (id) initWithDrawing: (__unsafe_unretained Drawing *) aDrawing {
    self = [super init];
    if (self) {
        drawing = aDrawing;

        [self option2];
    }

    return self;
}

- (void) updateDrawing {

    NSLog(@"%s", __PRETTY_FUNCTION__);

    NSLog(@"drawing.wasModified = %d", drawing.wasModified);
    if (drawing.wasModified) {
        NSLog(@"Drawing was modified.");

        UIImage *image;
        NSMutableArray *lineActions = [[NSMutableArray alloc] init];
        if (drawer != nil) {
            [lineActions addObjectsFromArray: drawer.lineActions];


        }

        else {
            image = [lineDrawer defaultScreenshot];
        }

        [lineActions addObjectsFromArray: lineDrawer.lineActions];
        drawing.actions = lineActions;
        drawing.image = image;

        NSLog(@"[lineDrawer.lineActions count] = %u", [lineDrawer.lineActions count]);
        NSLog(@"[drawer.lineActions count] = %u", [drawer.lineActions count]);

        NSLog(@"[drawing.actions count] = %u", [drawing.actions count]);
    }
}

//- (void) option1 {
//
//    ccBlendFunc blendFunc4 = {GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA};
//
//    lineDrawer = [[TouchLineDrawer alloc] initWithClearingColor: [UIColor whiteColor]];
//    [self addChild: lineDrawer];
//
//    if ([drawing.actions count] > 0) {
//        self.drawer = [[TouchLineDrawer alloc] initWithClearingColor: [UIColor clearColor]];
//        drawer.isTouchEnabled = NO;
//        drawer.lineActions = drawing.actions;
//        [self addChild: drawer];
//
//        [drawer.renderTexture.sprite setBlendFunc: blendFunc4];
//    }
//}


/*
- (void) lineDrawerDidBeginErasing {

    NSLog(@"%s", __PRETTY_FUNCTION__);
    lineDrawer.isTouchEnabled = NO;
    eraserDrawer.isTouchEnabled = YES;
}

- (void) lineDrawerDidEndErasing {

    NSLog(@"%s", __PRETTY_FUNCTION__);
    eraserDrawer.isTouchEnabled = NO;
    lineDrawer.isTouchEnabled = YES;
}
*/

- (void) option2 {


    ccBlendFunc blendFunc4 = {GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA};
    ccBlendFunc blendFunc5 = {GL_SRC_COLOR, GL_ONE_MINUS_SRC_COLOR};
    ccBlendFunc blendFunc6 = {GL_ZERO, GL_ONE_MINUS_SRC_COLOR};
    ccBlendFunc blendFunc7 = {GL_ZERO, GL_ONE_MINUS_SRC_ALPHA};
    ccBlendFunc blendFunc8 = {GL_ONE, GL_ONE_MINUS_SRC_ALPHA};
    ccBlendFunc blendFunc9 = {GL_ONE, GL_ONE_MINUS_SRC_COLOR};
    ccBlendFunc blendFunc10 = {GL_ZERO, GL_ONE_MINUS_CONSTANT_COLOR};
    ccBlendFunc blendFunc11 = {GL_ZERO, GL_SRC_COLOR};



    ccColor4F bgColor = ccc4f(245/255.0f, 244/255.0f, 240/255.0f, 1);
    //bgColor = ccc4f(0, 0, 1, 1);
    //bgColor = ccc4f(1, 1, 1, 1);
    ccColor4F clearColor = ccc4f(1, 1, 1, 0);
    ccColor4F whiteColor = ccc4f(1, 1, 1, 1);

    NSLog(@"[drawing.actions count] = %u", [drawing.actions count]);
    if ([drawing.actions count] > 0) {
        self.drawer = [[TouchLineDrawer alloc] initWithClearingColor: bgColor];
        drawer.isTouchEnabled = NO;
        drawer.lineActions = drawing.actions;
        [self addChild: drawer];

        lineDrawer = [[TouchLineDrawer alloc] initWithClearingColor: whiteColor];
        [lineDrawer.renderTexture.sprite setBlendFunc: blendFunc10];
        lineDrawer.erasingColor = ccc4f(1.0, 1.0, 1.0, 1.0);
        lineDrawer.drawing = drawing;
        [lineDrawer subscribeDelegate: self];
        [self addChild: lineDrawer];

        eraserDrawer = [[TouchLineDrawer alloc] initWithClearingColor: clearColor];
        eraserDrawer.erasingColor = bgColor;
        eraserDrawer.isTouchEnabled = NO;
        eraserDrawer.isErasing = YES;
        [eraserDrawer.renderTexture.sprite setBlendFunc: blendFunc4];
        //[self addChild: eraserDrawer];

        lineDrawer.eraserDrawer = eraserDrawer;
    }

    else {

        lineDrawer = [[TouchLineDrawer alloc] initWithClearingColor: bgColor];
        [self addChild: lineDrawer];
    }
}


- (void) simpleOption {


    //lineDrawer = [[TouchLineDrawer alloc] initWithClearingColor: ccc4f(1, 1, 1, 1)];
    //[self addChild: lineDrawer];


/*
    if ([drawing.actions count] > 0) {
        self.drawer = [[TouchLineDrawer alloc] initWithClearingColor: [UIColor blueColor]];
        drawer.isTouchEnabled = NO;
        drawer.lineActions = drawing.actions;
        [self addChild: drawer];

        lineDrawer = [[TouchLineDrawer alloc] initWithClearingColor: [UIColor clearColor]];
        [lineDrawer.renderTexture.sprite setBlendFunc: blendFunc7];
        lineDrawer.erasingColor = ccc4f(1.0, 1.0, 1.0, 1.0);
        [self addChild: lineDrawer];

    }

    else {
    }
    */

}



- (void) initBackground {
    CGRect rect = self.boundingBox;
    CCSprite *sprite = [CCSprite spriteWithFile: @"paper-grid2.png" rect: rect];
    [self addChild: sprite];

    sprite.position = ccp(rect.size.width / 2, rect.size.height / 2);
    [sprite setBlendFunc: (ccBlendFunc) {GL_SRC_COLOR, GL_ONE_MINUS_DST_COLOR}];
    [sprite setBlendFunc: (ccBlendFunc) {GL_ONE_MINUS_DST_COLOR, GL_SRC_COLOR}];
}

- (void) initTestImages {

    /*
    CCTexture2D *paddleTexture = [[CCTextureCache sharedTextureCache] addImage: @"add-button.png"];
    Paddle *paddle = [Paddle paddleWithTexture: paddleTexture];

    paddle.position = CGPointMake(160, 500);
    //[self addChild: paddle];
     */

}

@end