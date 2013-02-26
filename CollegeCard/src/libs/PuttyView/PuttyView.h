//
//  PuttyView.h
//
//  Created by Tyler Neylon on 6/16/10.
//  Copyleft 2010.
//
//  This is a view that can be dragged around
//  or resized using the lower-right corner.
//

#import <Foundation/Foundation.h>


@interface PuttyView : UIView {

    CGPoint touchStart;
@private
    // strong
    UIView *contentView;  // Retained as a subview.

    BOOL isResizing;
    BOOL resizable;
}


@property(nonatomic, retain) UIView *contentView;
@property(nonatomic) BOOL resizable;
@property(nonatomic) CGPoint touchStart;

@end
