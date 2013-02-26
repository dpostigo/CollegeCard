//
// Created by dpostigo on 10/11/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

@interface BasicCollectionCell : UICollectionViewCell {

    IBOutlet UILabel *textLabel;
    IBOutlet UIImageView *imageView;
}

@property(nonatomic, strong) UILabel *textLabel;
@property(nonatomic, strong) UIImageView *imageView;

@end