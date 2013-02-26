//
// Created by dpostigo on 9/19/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "CCDirectorIOS.h"
#import "ScalingPanel.h"
#import "Toolbox.h"
#import "LineScene.h"


@interface DrawingPanel : ScalingPanel {
    __unsafe_unretained CCDirectorIOS *director;
    LineScene *scene;
}

@property(nonatomic, strong) LineScene *scene;
@property(nonatomic, assign) CCDirectorIOS *director;

- (id) initWithFrame: (CGRect) frame;
- (void) initSceneWithDrawing: (Drawing *) aDrawing;
- (void) cleanup;

@end