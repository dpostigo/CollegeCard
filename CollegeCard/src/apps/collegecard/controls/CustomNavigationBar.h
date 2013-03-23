//
// Created by dpostigo on 3/11/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>


@interface CustomNavigationBar : UINavigationBar {
    UIImageView *navigationBarBackgroundImage;
    CGFloat backButtonCapWidth;
    IBOutlet UINavigationController *navigationController;
}


@property(nonatomic, retain) UIImageView *navigationBarBackgroundImage;
@property(nonatomic, retain) IBOutlet UINavigationController *navigationController;
- (void) setBackgroundWith: (UIImage *) backgroundImage;
- (void) clearBackground;
+ (UIButton *) buttonWithImage: (UIImage *) backButtonImage highlight: (UIImage *) backButtonHighlightImage leftCapWidth: (CGFloat) capWidth;
- (UIButton *) backButtonWith: (UIImage *) backButtonImage highlight: (UIImage *) backButtonHighlightImage leftCapWidth: (CGFloat) capWidth;
- (void) setText: (NSString *) text onBackButton: (UIButton *) backButton;

@end