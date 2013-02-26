//
// Created by dpostigo on 9/24/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>


@protocol ToolboxDelegate


- (void) buttonTappedAtIndex: (NSUInteger) index;
- (void) buttonTappedForString: (NSString *) string;

@end;

@interface Toolbox : UIView {

    BOOL isOpen;
    NSMutableArray *buttons;
    NSMutableArray *strings;
    NSMutableArray *labels;
    __unsafe_unretained id<ToolboxDelegate> delegate;

    NSMutableArray *controls;

}

@property(nonatomic, assign) id<ToolboxDelegate> delegate;
@property(nonatomic, strong) NSMutableArray *buttons;
@property(nonatomic) BOOL isOpen;
@property(nonatomic, strong) NSMutableArray *strings;
@property(nonatomic, strong) NSMutableArray *controls;
@property(nonatomic, strong) NSMutableArray *labels;
- (id) initWithFrame: (CGRect) frame;
- (void) addButton: (NSString *) textLabel;
- (void) setSelectedButtonIndex: (NSUInteger) index1;

@end