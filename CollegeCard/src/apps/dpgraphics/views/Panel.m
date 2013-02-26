//
// Created by dpostigo on 9/18/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <QuartzCore/QuartzCore.h>
#import "Panel.h"
#import "UIView+DrawingApp.h"

@implementation Panel {

}

@synthesize imageView;

@synthesize backgroundView;

@synthesize isEditing;

@synthesize editingImageView;

- (id) initWithFrame: (CGRect) frame {
    self = [super initWithFrame: frame];
    if (self) {

        self.clipsToBounds = NO;
        self.layer.masksToBounds = NO;

        self.backgroundView = [UIView newBasicViewWithFrame: self.frame];
        self.imageView = [[UIImageView alloc] initWithFrame: self.frame];

        backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

        [self addSubview: backgroundView];
        [self addSubview: imageView];


        self.editingImageView = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"delete-panel.png"]];
        [self addSubview: editingImageView];
        editingImageView.alpha = 0;
        [self rasterize];

    }

    return self;
}



- (void) setIsEditing: (BOOL) isEditing1 {
    isEditing = isEditing1;

        [UIView animateWithDuration: 0.5 animations: ^{

            if (isEditing) {

                editingImageView.alpha = 1;
                imageView.alpha = 1;
            }
            else {

                editingImageView.alpha = 0;
                imageView.alpha = 1;
            }
        }];


}



@end