//
// Created by dpostigo on 10/16/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "BasicLineDrawer.h"
#import "LinePoint.h"

@implementation BasicLineDrawer {
}

@synthesize overdraw;
@synthesize redrawing;
@synthesize connectingLine;
@synthesize finishingLine;
@synthesize isErasing;
@synthesize prevC;
@synthesize prevD;
@synthesize prevG;
@synthesize prevI;
@synthesize circlesPoints;
@synthesize clearingColor;
@synthesize colorRed;
@synthesize colorGreen;
@synthesize colorBlue;
@synthesize colorAlpha;

- (void) setClearingColor: (UIColor *) backgroundColor1 {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    clearingColor = backgroundColor1;

    colorRed = 0.0;
    colorGreen = 0.0;
    colorBlue = 0.0;
    colorAlpha = 1.0;

    if (clearingColor == [UIColor blueColor]) {
        colorBlue = 1.0;
        colorAlpha = 1.0;
        NSLog(@"blue color");
        NSLog(@"colorRed = %f", colorRed);
        NSLog(@"colorGreen = %f", colorGreen);
        NSLog(@"colorBlue = %f", colorBlue);
    }

    else if (clearingColor == [UIColor clearColor]) {
        colorRed = 1.0;
        colorGreen = 1.0;
        colorBlue = 1.0;
        colorAlpha = 0.0;
    }

    else if (clearingColor == [UIColor whiteColor]) {
        colorRed = 1.0;
        colorGreen = 1.0;
        colorBlue = 1.0;
        colorAlpha = 1.0;
    }

    else {

        CGFloat components[4];
        [UIColor getRGBComponents: components forColor: clearingColor];

        colorRed = components[0];
        colorGreen = components[1];
        colorBlue = components[2];
        colorAlpha = components[3];
    }
}



#pragma mark - Drawing

#define ADD_TRIANGLE(A, B, C, Z) vertices[index].pos = A, vertices[index++].z = Z, vertices[index].pos = B, vertices[index++].z = Z, vertices[index].pos = C, vertices[index++].z = Z

- (void) drawLines: (NSArray *) linePoints withColor: (ccColor4F) color {

    unsigned int numberOfVertices = ([linePoints count] - 1) * 18;
    LineVertex *vertices = calloc(sizeof(LineVertex), numberOfVertices);
    CGPoint prevPoint = [(LinePoint *) [linePoints objectAtIndex: 0] position];
    float prevValue = [(LinePoint *) [linePoints objectAtIndex: 0] width];
    float curValue;
    int index = 0;
    for (int i = 1; i < [linePoints count]; ++i) {
        LinePoint *pointValue = [linePoints objectAtIndex: i];
        CGPoint curPoint = [pointValue position];
        curValue = [pointValue width];

        //! equal points, skip them
        if (ccpFuzzyEqual(curPoint, prevPoint, 0.0001f)) {
            continue;
        }

        CGPoint dir = ccpSub(curPoint, prevPoint);
        CGPoint perpendicular = ccpNormalize(ccpPerp(dir));
        CGPoint A = ccpAdd(prevPoint, ccpMult(perpendicular, prevValue / 2));
        CGPoint B = ccpSub(prevPoint, ccpMult(perpendicular, prevValue / 2));
        CGPoint C = ccpAdd(curPoint, ccpMult(perpendicular, curValue / 2));
        CGPoint D = ccpSub(curPoint, ccpMult(perpendicular, curValue / 2));

        //! continuing line

        if (redrawing) {
            if (connectingLine || index > 0) {
                A = prevC;
                B = prevD;
            } else {
                //! circle at start of line, revert direction
                [circlesPoints addObject: pointValue];
                [circlesPoints addObject: [linePoints objectAtIndex: i - 1]];
            }
        } else {
            if (connectingLine || index > 0) {
                A = prevC;
                B = prevD;
            } else if (index == 0) {
                //! circle at start of line, revert direction
                [circlesPoints addObject: pointValue];
                [circlesPoints addObject: [linePoints objectAtIndex: i - 1]];
            }
        }


        ADD_TRIANGLE(A, B, C, 1.0f);
        ADD_TRIANGLE(B, C, D, 1.0f);

        prevD = D;
        prevC = C;
        if (finishingLine && (i == [linePoints count] - 1)) {
            [circlesPoints addObject: [linePoints objectAtIndex: i - 1]];
            [circlesPoints addObject: pointValue];
            finishingLine = NO;
        }
        prevPoint = curPoint;
        prevValue = curValue;

        //! Add overdraw
        CGPoint F = ccpAdd(A, ccpMult(perpendicular, overdraw));
        CGPoint G = ccpAdd(C, ccpMult(perpendicular, overdraw));
        CGPoint H = ccpSub(B, ccpMult(perpendicular, overdraw));
        CGPoint I = ccpSub(D, ccpMult(perpendicular, overdraw));

        //! end vertices of last line are the start of this one, also for the overdraw
        if (connectingLine || index > 6) {
            F = prevG;
            H = prevI;
        }

        prevG = G;
        prevI = I;

        ADD_TRIANGLE(F, A, G, 2.0f);
        ADD_TRIANGLE(A, G, C, 2.0f);
        ADD_TRIANGLE(B, H, D, 2.0f);
        ADD_TRIANGLE(H, D, I, 2.0f);
    }

    [self fillLineTriangles: vertices count: index withColor: color];

    if (index > 0) {
        connectingLine = YES;
    }

    free(vertices);
}

- (void) setBlending {
    //glBlendFuncSeparate(GL_ONE, GL_ZERO, GL_ONE, GL_ZERO);
    //glBlendFuncSeparate(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA, GL_ONE, GL_ZERO);
    // glBlendFuncSeparate(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA, GL_ZERO, GL_ONE_MINUS_SRC_ALPHA);
    //glBlendFuncSeparate(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA, GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
    //glBlendFuncSeparate(GL_ZERO, GL_ZERO, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    //glBlendFuncSeparate(GL_ONE, GL_ZERO, GL_ONE, GL_ZERO);
    glBlendFuncSeparate(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA, GL_ONE, GL_ONE_MINUS_SRC_COLOR);


    //glBlendFuncSeparate(GL_ONE, GL_ONE_MINUS_SRC_ALPHA, GL_ONE, GL_ONE_MINUS_SRC_COLOR);




    //glBlendFuncSeparate(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA, GL_ZERO, GL_ONE_MINUS_SRC_ALPHA);

    // glBlendFuncSeparate(GL_SRC_COLOR, GL_ONE_MINUS_SRC_ALPHA, GL_ONE, GL_ONE_MINUS_SRC_COLOR);
}

- (void) fillLineTriangles: (LineVertex *) vertices count: (NSUInteger) count withColor: (ccColor4F) color {
    [shaderProgram_ use];
    [shaderProgram_ setUniformForModelViewProjectionMatrix];

    ccGLEnableVertexAttribs(kCCVertexAttribFlag_Position | kCCVertexAttribFlag_Color);

    ccColor4F fullColor = color;
    fullColor.a = 1;

    ccColor4F fadeOutColor = color;
    fadeOutColor.a = 0;

    if (isErasing) {
        fullColor.a = 1;
        fadeOutColor.a = 0;
    }

    for (int i = 0; i < count / 18; ++i) {
        for (int j = 0; j < 6; ++j) {
            vertices[i * 18 + j].color = color;
        }

        //! FAG
        vertices[i * 18 + 6].color = fadeOutColor;
        vertices[i * 18 + 7].color = fullColor;
        vertices[i * 18 + 8].color = fadeOutColor;

        //! AGD
        vertices[i * 18 + 9].color = fullColor;
        vertices[i * 18 + 10].color = fadeOutColor;
        vertices[i * 18 + 11].color = fullColor;

        //! BHC
        vertices[i * 18 + 12].color = fullColor;
        vertices[i * 18 + 13].color = fadeOutColor;
        vertices[i * 18 + 14].color = fullColor;

        //! HCI
        vertices[i * 18 + 15].color = fadeOutColor;
        vertices[i * 18 + 16].color = fullColor;
        vertices[i * 18 + 17].color = fadeOutColor;
    }

    glVertexAttribPointer(kCCVertexAttrib_Position, 3, GL_FLOAT, GL_FALSE, sizeof(LineVertex), &vertices[0].pos);
    glVertexAttribPointer(kCCVertexAttrib_Color, 4, GL_FLOAT, GL_FALSE, sizeof(LineVertex), &vertices[0].color);

    [self setBlending];
    glDrawArrays(GL_TRIANGLES, 0, (GLsizei) count);

    for (unsigned int i = 0; i < [circlesPoints count] / 2; ++i) {
        LinePoint *prevPoint = [circlesPoints objectAtIndex: i * 2];
        LinePoint *curPoint = [circlesPoints objectAtIndex: i * 2 + 1];
        CGPoint dirVector = ccpNormalize(ccpSub(curPoint.position, prevPoint.position));

        [self fillLineEndPointAt: curPoint.position direction: dirVector radius: curPoint.width * 0.005f andColor: color];
    }
    [circlesPoints removeAllObjects];
}

- (void) fillLineEndPointAt: (CGPoint) center direction: (CGPoint) aLineDir radius: (CGFloat) radius andColor: (ccColor4F) color {

    int numberOfSegments = 32;
    LineVertex *vertices = malloc(sizeof(LineVertex) * numberOfSegments * 9);
    float anglePerSegment = (float) (M_PI / (numberOfSegments - 1));

    //! we need to cover M_PI from this, dot product of normalized vectors is equal to cos angle between them... and if you include rightVec dot you get to know the correct direction :)
    CGPoint perpendicular = ccpPerp(aLineDir);
    float angle = acosf(ccpDot(perpendicular, CGPointMake(0, 1)));
    float rightDot = ccpDot(perpendicular, CGPointMake(1, 0));
    if (rightDot < 0.0f) {
        angle *= -1;
    }

    CGPoint prevPoint = center;
    CGPoint prevDir = ccp(sinf(0), cosf(0));
    for (unsigned int i = 0; i < numberOfSegments; ++i) {
        CGPoint dir = ccp(sinf(angle), cosf(angle));
        CGPoint curPoint = ccp(center.x + radius * dir.x, center.y + radius * dir.y);
        vertices[i * 9 + 0].pos = center;
        vertices[i * 9 + 1].pos = prevPoint;
        vertices[i * 9 + 2].pos = curPoint;

        //! fill rest of vertex data
        for (unsigned int j = 0; j < 9; ++j) {
            vertices[i * 9 + j].z = j < 3 ? 1.0f: 2.0f;
            vertices[i * 9 + j].color = color;
        }

        //! add overdraw
        vertices[i * 9 + 3].pos = ccpAdd(prevPoint, ccpMult(prevDir, overdraw));
        vertices[i * 9 + 3].color.a = 0;
        vertices[i * 9 + 4].pos = prevPoint;
        vertices[i * 9 + 5].pos = ccpAdd(curPoint, ccpMult(dir, overdraw));
        vertices[i * 9 + 5].color.a = 0;

        vertices[i * 9 + 6].pos = prevPoint;
        vertices[i * 9 + 7].pos = curPoint;
        vertices[i * 9 + 8].pos = ccpAdd(curPoint, ccpMult(dir, overdraw));
        vertices[i * 9 + 8].color.a = 0;

        prevPoint = curPoint;
        prevDir = dir;
        angle += anglePerSegment;
    }

    glVertexAttribPointer(kCCVertexAttrib_Position, 3, GL_FLOAT, GL_FALSE, sizeof(LineVertex), &vertices[0].pos);
    glVertexAttribPointer(kCCVertexAttrib_Color, 4, GL_FLOAT, GL_FALSE, sizeof(LineVertex), &vertices[0].color);
    glDrawArrays(GL_TRIANGLES, 0, numberOfSegments * 9);

    free(vertices);
}

- (NSMutableArray *) calculateSmoothLinePointsWithLine: (NSMutableArray *) linePoints {

    if ([linePoints count] > 2) {

        NSMutableArray *smoothedPoints = [NSMutableArray array];
        for (unsigned int i = 2; i < [linePoints count]; ++i) {
            LinePoint *prev2 = [linePoints objectAtIndex: i - 2];
            LinePoint *prev1 = [linePoints objectAtIndex: i - 1];
            LinePoint *cur = [linePoints objectAtIndex: i];
            CGPoint midPoint1 = ccpMult(ccpAdd(prev1.position, prev2.position), 0.5f);
            CGPoint midPoint2 = ccpMult(ccpAdd(cur.position, prev1.position), 0.5f);
            int segmentDistance = 2;
            float distance = ccpDistance(midPoint1, midPoint2);
            float tempMax = MAX(floorf(distance / segmentDistance), 32);
            int numberOfSegments = (int) MIN(128, tempMax);
            float t = 0.0f;
            float step = 1.0f / numberOfSegments;
            for (NSUInteger j = 0; j < numberOfSegments; j++) {
                LinePoint *newPoint = [[LinePoint alloc] init];
                newPoint.position = ccpAdd(ccpAdd(ccpMult(midPoint1, powf(1 - t, 2)), ccpMult(prev1.position, 2.0f * (1 - t) * t)), ccpMult(midPoint2, t * t));
                newPoint.width = powf(1 - t, 2) * ((prev1.width + prev2.width) * 0.5f) + 2.0f * (1 - t) * t * prev1.width + t * t * ((cur.width + prev1.width) * 0.5f);

                [smoothedPoints addObject: newPoint];
                t += step;
            }
            LinePoint *finalPoint = [[LinePoint alloc] init];
            finalPoint.position = midPoint2;
            finalPoint.width = (cur.width + prev1.width) * 0.5f;
            [smoothedPoints addObject: finalPoint];
        }
        //! we need to leave last 2 points for next draw
        [linePoints removeObjectsInRange: NSMakeRange(0, [linePoints count] - 2)];
        return smoothedPoints;
    } else {
        return nil;
    }
}

@end