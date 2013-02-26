//
// Created by dpostigo on 10/4/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "CCLayer.h"

@interface BasicCocoaLayer : CCLayer {
    CGSize globalSize;
    CGSize textureSize;

    CGFloat rightBoundary;

    BOOL shouldPan;
    BOOL panningEnabled;

    NSMutableArray *delegates;

}

@property(nonatomic) CGSize globalSize;
@property(nonatomic) CGSize textureSize;
@property(nonatomic) BOOL panningEnabled;
@property(nonatomic) CGFloat rightBoundary;
@property(nonatomic) BOOL shouldPan;
@property(nonatomic, strong) NSMutableArray *delegates;
- (UIImage *) defaultScreenshot;
- (UIImage *) screenshotWithStartNode: (CCNode *) startNode;
- (UIImage *) screenShot;
- (UIImage *) screenShotWithSize: (CGSize) size;
- (void) subscribeDelegate: (id) aDelegate;
- (void) unsubscribeDelegate: (id) aDelegate;
- (void) notifyDelegates: (SEL) aSelector object: (id) obj;

@end