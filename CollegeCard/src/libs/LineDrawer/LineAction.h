//
// Created by dpostigo on 10/10/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

typedef enum {
    LineActionTypeWipe,
    LineActionTypeDiscreteLine,
    LineActionTypeUndo,
    LineActionTypeRedo,
    LineActionTypePlayback
} LineActionType;

@interface LineAction : NSObject <NSCoding> {
    LineActionType type;
    NSMutableArray *linePoints;

}

@property(nonatomic) LineActionType type;
@property(nonatomic, strong) NSMutableArray *linePoints;

- (id) initWithActionType: (LineActionType) anActionType;

@end