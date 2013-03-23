//
//  AppDelegate.m
//  Household Draft
//
//  Created by Daniela Postigo on 10/16/12.
//  Copyright (c) 2012 Daniela Postigo. All rights reserved.
//

#import "AppDelegate.h"
#import "Cocoafish.h"
#import "CustomNavigationBar.h"
#import "UIImage+Utils.h"


#define COCOAFISH_OAUTH_CONSUMER_KEY @"1bvShAd2i4AshRo0fVzbwcio5M9NKCSf"
#define COCOAFISH_OAUTH_CONSUMER_SECRET @"OC867rVFpe55Lt4uB3hX2inhbEeMdbUB"


@implementation AppDelegate


- (void) customizeAppearance {

    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys: [UIColor whiteColor], UITextAttributeTextColor, [UIFont fontWithName: @"HelveticaNeue-Regular" size: 10.0], UITextAttributeFont, nil]];

    NSMutableDictionary *fontDict = [[NSMutableDictionary alloc] init];
    [fontDict setObject: [UIColor whiteColor] forKey: UITextAttributeTextColor];
    [fontDict setObject: [UIFont fontWithName: @"Rockwell" size: 20.0] forKey: UITextAttributeFont];
    [[UINavigationBar appearance] setTitleTextAttributes: fontDict];

    NSMutableDictionary *smallFont = [[NSMutableDictionary alloc] init];
    [smallFont setObject: [UIColor whiteColor] forKey: UITextAttributeTextColor];
    [smallFont setObject: [UIFont fontWithName: @"HelveticaNeue-Bold" size: 11.0] forKey: UITextAttributeFont];
    [[UIBarButtonItem appearance] setTitleTextAttributes: smallFont forState: UIControlStateNormal];




}



- (BOOL) application: (UIApplication *) application didFinishLaunchingWithOptions: (NSDictionary *) launchOptions {

#ifdef TESTFLIGHT_ENABLED
    //    [TestFlight takeOff: TESTFLIGHT_TOKEN];
#endif

    [Cocoafish initializeWithOauthConsumerKey: COCOAFISH_OAUTH_CONSUMER_KEY consumerSecret: COCOAFISH_OAUTH_CONSUMER_SECRET customAppIds: nil];
    [Cocoafish defaultCocoafish].loggingEnabled = NO;
    [self customizeAppearance];
    return YES;
}


- (void) applicationWillResignActive: (UIApplication *) application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}


- (void) applicationDidEnterBackground: (UIApplication *) application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void) applicationWillEnterForeground: (UIApplication *) application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}


- (void) applicationDidBecomeActive: (UIApplication *) application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void) applicationWillTerminate: (UIApplication *) application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.

}

@end
