//
// Created by dpostigo on 9/20/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

@interface Drawing : NSObject <NSCoding> {

    NSMutableArray *savedPoints;
    NSMutableArray *erasurePoints;

    NSMutableArray *actions;


    UIImage *image;
    UIImage *thumbnailImage;

    NSString *imagePath;
    NSString *thumbnailPath;

    NSDate *dateCreated;
    BOOL wasModified;
}

@property(nonatomic, strong) UIImage *image;
@property(nonatomic, strong) NSDate *dateCreated;
@property(nonatomic, strong) NSString *imagePath;
@property(nonatomic) BOOL wasModified;
@property(nonatomic, strong) UIImage *thumbnailImage;
@property(nonatomic, strong) NSString *thumbnailPath;
@property(nonatomic, strong) NSMutableArray *savedPoints;
@property(nonatomic, strong) NSMutableArray *erasurePoints;
@property(nonatomic, strong) NSMutableArray *actions;
- (id) initWithCoder: (NSCoder *) decoder;
- (void) encodeWithCoder: (NSCoder *) encoder;

@end