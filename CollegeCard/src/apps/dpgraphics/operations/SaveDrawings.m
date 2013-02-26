//
// Created by dpostigo on 10/9/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "SaveDrawings.h"
#import "Drawing.h"

@implementation SaveDrawings {
}

- (void) main {
    [super main];

    NSMutableArray *drawings = [[NSMutableArray alloc] initWithArray: _model.drawings];

    NSData *data = [NSKeyedArchiver archivedDataWithRootObject: drawings];
    [[NSUserDefaults standardUserDefaults] setObject: data forKey: DRAWINGS];
    NSLog(@"Saved %u drawings.", [_model.drawings count]);
}

@end