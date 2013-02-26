//
// Created by dpostigo on 10/4/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "BasicCocoaLayer.h"
#import "CCDirector.h"
#import "CCRenderTexture.h"
#import "CCScene.h"
#import "CGPointExtension.h"

@implementation BasicCocoaLayer {
}

@synthesize globalSize;
@synthesize textureSize;
@synthesize panningEnabled;
@synthesize rightBoundary;
@synthesize shouldPan;
@synthesize delegates;

- (id) init {
    self = [super init];
    if (self) {
        self.delegates = [[NSMutableArray alloc] init];
        globalSize = [CCDirector sharedDirector].winSize;


        self.panningEnabled = YES;

        if (panningEnabled) {
            textureSize = CGSizeMake(globalSize.width * 2, globalSize.height);

        } else {

            textureSize = CGSizeMake(globalSize.width, globalSize.height);
        }

        rightBoundary = globalSize.width * 0.9;
    }

    return self;
}

- (UIImage *) defaultScreenshot {
    return [self screenshotWithStartNode: self];
}

- (UIImage *) screenshotWithStartNode: (CCNode *) startNode {
    [CCDirector sharedDirector].nextDeltaTimeZero = YES;

    CGSize winSize = globalSize;
    CCRenderTexture *rtx = [CCRenderTexture renderTextureWithWidth: winSize.width height: winSize.height];
    [rtx beginWithClear: 1.0 g: 1.0 b: 1.0 a: 0.0];
    [startNode visit];
    [rtx end];

    return [rtx getUIImage];
}

- (UIImage *) screenShot {
    return [self screenShotWithSize: globalSize];
}

- (UIImage *) screenShotWithSize: (CGSize) size {

    //Create un buffer for pixels

    NSLog(@"%s", __PRETTY_FUNCTION__);
    NSLog(@"size = %@", NSStringFromCGSize(size));
    GLuint bufferLength = (GLuint) (size.width * size.height * 4);
    GLubyte *buffer = (GLubyte *) malloc(bufferLength);



    //Read Pixels from OpenGL
    glReadPixels(0, 0, size.width, (GLsizei) size.height, GL_RGBA, GL_UNSIGNED_BYTE, buffer);

    //Make data provider with data.
    CGDataProviderRef provider = CGDataProviderCreateWithData(NULL, buffer, bufferLength, NULL);

    //Configure image
    int bitsPerComponent = 8;
    int bitsPerPixel = 32;
    int bytesPerRow = (int) (size.width * 4);
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    CGImageRef imageRef = CGImageCreate(size.width, size.height, bitsPerComponent, bitsPerPixel, bytesPerRow, colorSpaceRef, kCGBitmapByteOrderDefault, provider, NULL, NO, kCGRenderingIntentDefault);
    uint32_t *pixels = (uint32_t *) malloc(bufferLength);
    CGContextRef context = CGBitmapContextCreate(pixels, size.width, size.height, 8, size.width * 4, CGImageGetColorSpace(imageRef), kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGContextTranslateCTM(context, 0, size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextDrawImage(context, CGRectMake(0.0, 0.0, size.width, size.height), imageRef);
    CGImageRef cgImage = CGBitmapContextCreateImage(context);
    UIImage *screenshot = [UIImage imageWithCGImage: cgImage];
    CGImageRelease(cgImage);
    UIGraphicsEndImageContext();


    //free memory
    CGColorSpaceRelease(colorSpaceRef);
    CGDataProviderRelease(provider);
    CGImageRelease(imageRef);
    CGContextRelease(context);

    free(buffer);
    free(pixels);

    return screenshot;
}

- (UIImage *) getGLScreenshot {

    CGSize size = globalSize;
    NSInteger myDataLength = size.width * size.height * 4;

    // allocate array and read pixels into it.
    GLubyte *buffer = (GLubyte *) malloc(myDataLength);
    glReadPixels(0, 0, size.width, size.height, GL_RGBA, GL_UNSIGNED_BYTE, buffer);

    // gl renders "upside down" so swap top to bottom into new array.
    // there's gotta be a better way, but this works.
    GLubyte *buffer2 = (GLubyte *) malloc(myDataLength);
    for (int y = 0; y < size.height; y++) {
        for (int x = 0; x < size.width * 4; x++) {
            int index = (int) ((size.height - 1 - y) * size.width * 4 + x);
            int index2 = (int) (y * 4 * size.width + x);
            buffer2[index] = buffer[index2];
        }
    }

    // make data provider with data.
    CGDataProviderRef provider = CGDataProviderCreateWithData(NULL,
            buffer2, myDataLength, NULL);

    // prep the ingredients
    int bitsPerComponent = 8;
    int bitsPerPixel = 32;
    int bytesPerRow = 4 * size.width;
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    CGBitmapInfo bitmapInfo = kCGBitmapByteOrderDefault;
    CGColorRenderingIntent renderingIntent = kCGRenderingIntentDefault;

    // make the cgimage
    CGImageRef imageRef = CGImageCreate(size.width, size.height, bitsPerComponent,
            bitsPerPixel, bytesPerRow, colorSpaceRef, bitmapInfo, provider,
            NULL, NO, renderingIntent);

    // then make the uiimage from that
    UIImage *myImage = [UIImage imageWithCGImage: imageRef];
    return myImage;
}

- (UIImage *) retinaScreenShot {
    [CCDirector sharedDirector].nextDeltaTimeZero = YES;

    CGSize winSize = [CCDirector sharedDirector].winSizeInPixels;
    //winSize = CGSizeMake(winSize.width * 2, winSize.height * 2);


    CCLayerColor *whitePage = [CCLayerColor layerWithColor: ccc4(255, 255, 255, 0) width: winSize.width height: winSize.height];
    whitePage.position = ccp(winSize.width / 2, winSize.height / 2);

    CCRenderTexture *aTexture = [CCRenderTexture renderTextureWithWidth: (int) winSize.width height: (int) winSize.height];
    [aTexture begin];
    [whitePage visit];
    [[[CCDirector sharedDirector] runningScene] visit];
    [aTexture end];

    UIImage *bigImage = [aTexture getUIImage];
    NSLog(@"bigImage.size.width = %f", bigImage.size.width);
    return bigImage;
}

- (UIImage *) takeScreenshot: (ccTime) dt {
    CCLOG(@"tar screenshot");

    UIView *eagleView = (UIView *) [[CCDirector sharedDirector] view];
    GLint backingWidth, backingHeight;

    // Bind the color renderbuffer used to render the OpenGL ES view
    // If your application only creates a single color renderbuffer which is already bound at this point,
    // this call is redundant, but it is needed if you're dealing with multiple renderbuffers.
    // Note, replace "_colorRenderbuffer" with the actual name of the renderbuffer object defined in your class.
    // In Cocos2D the render-buffer is already binded (and it's a private property...).
    //	glBindRenderbufferOES(GL_RENDERBUFFER_OES, _colorRenderbuffer);

    // Get the size of the backing CAEAGLLayer
    glGetRenderbufferParameteriv(GL_RENDERBUFFER, GL_RENDERBUFFER_WIDTH, &backingWidth);
    glGetRenderbufferParameteriv(GL_RENDERBUFFER, GL_RENDERBUFFER_HEIGHT, &backingHeight);

    NSInteger x = 0, y = 0, width = backingWidth, height = backingHeight;
    NSInteger dataLength = width * height * 4;
    GLubyte *data = (GLubyte *) malloc(dataLength * sizeof(GLubyte));

    // Read pixel data from the framebuffer
    glPixelStorei(GL_PACK_ALIGNMENT, 4);
    glReadPixels(x, y, width, height, GL_RGBA, GL_UNSIGNED_BYTE, data);

    // Create a CGImage with the pixel data
    // If your OpenGL ES content is opaque, use kCGImageAlphaNoneSkipLast to ignore the alpha channel
    // otherwise, use kCGImageAlphaPremultipliedLast
    CGDataProviderRef ref = CGDataProviderCreateWithData(NULL, data, dataLength, NULL);
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    CGImageRef iref = CGImageCreate(
            width,
            height,
            8,
            32,
            width * 4,
            colorspace,
            // Fix from Apple implementation
            // (was: kCGBitmapByteOrder32Big | kCGImageAlphaPremultipliedLast).
            kCGBitmapByteOrderDefault,
            ref,
            NULL,
            true,
            kCGRenderingIntentDefault
    );

    // OpenGL ES measures data in PIXELS
    // Create a graphics context with the target size measured in POINTS
    NSInteger widthInPoints, heightInPoints;
    if (NULL != UIGraphicsBeginImageContextWithOptions) {
        // On iOS 4 and later, use UIGraphicsBeginImageContextWithOptions to take the scale into consideration
        // Set the scale parameter to your OpenGL ES view's contentScaleFactor
        // so that you get a high-resolution snapshot when its value is greater than 1.0
        CGFloat scale = eagleView.contentScaleFactor;
        widthInPoints = width / scale;
        heightInPoints = height / scale;
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(widthInPoints, heightInPoints), NO, scale);
    }
    else {
        // On iOS prior to 4, fall back to use UIGraphicsBeginImageContext
        widthInPoints = width;
        heightInPoints = height;
        UIGraphicsBeginImageContext(CGSizeMake(widthInPoints, heightInPoints));
    }

    CGContextRef cgcontext = UIGraphicsGetCurrentContext();

    // UIKit coordinate system is upside down to GL/Quartz coordinate system
    // Flip the CGImage by rendering it to the flipped bitmap context
    // The size of the destination area is measured in POINTS
    CGContextSetBlendMode(cgcontext, kCGBlendModeCopy);
    CGContextDrawImage(cgcontext, CGRectMake(0.0, 0.0, widthInPoints, heightInPoints), iref);

    // Retrieve the UIImage from the current context
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();

    // Clean up
    free(data);
    CFRelease(ref);
    CFRelease(colorspace);
    CGImageRelease(iref);

    return image;
}





- (void) subscribeDelegate: (id) aDelegate {
    [delegates addObject: aDelegate];

}

- (void) unsubscribeDelegate: (id) aDelegate {
    [delegates removeObject: aDelegate];
}

- (void) notifyDelegates: (SEL) aSelector object: (id) obj {
    for (id delegate in delegates) {
        if ([delegate respondsToSelector: aSelector]) {
            [delegate performSelectorOnMainThread: aSelector withObject: obj waitUntilDone: NO];
        }
    }
}


@end