//
// Created by dpostigo on 7/22/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>


@interface HouseholdButton : UIButton {
    NSString *text;
}


@property(nonatomic, retain) NSString *text;
- (void) initialization;
- (void) setImage: (UIImage *) image;

@end