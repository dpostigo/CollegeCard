//
// Created by dpostigo on 9/21/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

@interface BasicView : UIView {
    __unsafe_unretained id delegate;

}

@property(nonatomic, assign) id delegate;

@end