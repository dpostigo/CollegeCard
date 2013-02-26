//
// Created by dpostigo on 9/18/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

@interface PanelContainer : UIView {

    UIScrollView *scrollView;

}

@property(nonatomic, strong) UIScrollView *scrollView;

- (id) initWithFrame: (CGRect) frame;

@end