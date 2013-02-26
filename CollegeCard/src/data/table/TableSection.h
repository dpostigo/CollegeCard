//
// Created by dpostigo on 9/2/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>


@interface TableSection : NSObject {

    NSString *title;
    NSMutableArray *rows;
    BOOL showsHeader;
}


@property(nonatomic, retain) NSString *title;
@property(nonatomic, retain) NSMutableArray *rows;
@property(nonatomic) BOOL showsHeader;


- (id) initWithTitle: (NSString *) aTitle rows: (NSMutableArray *) aRows;
- (id) initWithTitle: (NSString *) aTitle;
- (NSUInteger) count;

@end