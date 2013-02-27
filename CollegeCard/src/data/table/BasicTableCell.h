//
// Created by dpostigo on 12/6/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>


@interface BasicTableCell : UITableViewCell {

    IBOutlet UILabel *__textLabel;
    IBOutlet UILabel *__detailTextLabel;
    IBOutlet UIImageView *imageView;
    IBOutlet UIButton *button;
}


@property(nonatomic, strong) UILabel *__textLabel;
@property(nonatomic, strong) UILabel *__detailTextLabel;
@property(nonatomic, strong) UIImageView *imageView;
@property(nonatomic, strong) UIButton *button;

@end