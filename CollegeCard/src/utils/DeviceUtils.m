//
// Created by dpostigo on 12/10/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "DeviceUtils.h"


@implementation DeviceUtils {
}


+ (BOOL) isPad {
    BOOL iPadDevice = NO;

    // Is userInterfaceIdiom available?
    if ([[UIDevice currentDevice] respondsToSelector: @selector(userInterfaceIdiom)]) {
        // Is device an iPad?
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
            iPadDevice = YES;
    }

    return iPadDevice;
}

@end