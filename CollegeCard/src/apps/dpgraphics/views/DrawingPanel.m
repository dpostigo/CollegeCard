//
// Created by dpostigo on 9/19/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "DrawingPanel.h"

@implementation DrawingPanel {
}

@synthesize director;
@synthesize scene;

- (id) initWithFrame: (CGRect) frame {
    self = [super initWithFrame: frame];
    if (self) {

        minimumScale = MIN_PANEL_SCALE + 0.0;

        self.clipsToBounds = NO;
        self.director = (CCDirectorIOS *) [CCDirector sharedDirector];

        CCGLView *glView = [CCGLView viewWithFrame: panel.bounds pixelFormat: kEAGLColorFormatRGB565 depthFormat: 0 preserveBackbuffer: NO sharegroup: nil multiSampling: NO numberOfSamples: 0];
        glView.backgroundColor = [UIColor colorWithString: @"f5f4f0"];
        glView.multipleTouchEnabled = YES;
        glView.hidden = YES;
        [panel addSubview: glView];
        [director setView: glView];
        [self startTextures];
    }

    return self;
}

- (void) startTextures {
    //[CCTexture2D setDefaultAlphaPixelFormat: kCCTexture2DPixelFormat_RGBA8888];
    [CCTexture2D setDefaultAlphaPixelFormat: kCCTexture2DPixelFormat_RGBA4444];
    [CCTexture2D PVRImagesHavePremultipliedAlpha: NO];
}

- (void) initSceneWithDrawing: (Drawing *) aDrawing {
    scene = [[LineScene alloc] initWithDrawing: aDrawing];
    [scene.lineDrawer subscribeDelegate: delegate];

    if (director.runningScene == nil) {
        [director pushScene: scene];
    }

    else {
        [director replaceScene: scene];
    }
}

- (void) cleanup {
    [director popScene];
}

@end