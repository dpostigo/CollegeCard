//
// Created by dpostigo on 9/3/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

@interface TableRowObject : NSObject {

    NSString *stringContent;
    NSString *textLabel;
    NSString *detailTextLabel;
    UIImage *image;
    __unsafe_unretained id content;
    int intContent;
    float floatContent;
    BOOL isLoading;
}

@property(nonatomic, assign) id content;
@property(nonatomic, retain) NSString *textLabel;
@property(nonatomic, retain) NSString *detailTextLabel;
@property(nonatomic) BOOL isLoading;
@property(nonatomic, strong) UIImage *image;
@property(nonatomic) int intContent;
@property(nonatomic) float floatContent;
@property(nonatomic, retain) NSString *stringContent;
- (id) init;
- (id) initWithTextLabel: (NSString *) aTextLabel detailTextLabel: (NSString *) aDetailTextLabel;
- (id) initWithTextLabel: (NSString *) aTextLabel;
- (id) initWithContent: (id) aContent;

@end