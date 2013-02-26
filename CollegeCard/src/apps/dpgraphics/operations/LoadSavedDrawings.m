//
// Created by dpostigo on 9/20/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "LoadSavedDrawings.h"
#import "Drawing.h"

@implementation LoadSavedDrawings {
}

- (void) main {
    [super main];
    NSLog(@"Looking for saved drawings...");

    NSArray *array;
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey: DRAWINGS];



    if (data != nil) {
        array = [NSKeyedUnarchiver unarchiveObjectWithData: data];
        _model.drawings = [[NSMutableArray alloc] initWithArray: array];
    }

    for (Drawing *drawing in _model.drawings) {
        UIImage *thumbnailImage = [UIImage imageWithData: [NSData dataWithContentsOfFile: drawing.thumbnailPath]];
        drawing.thumbnailImage = thumbnailImage;
    }


    NSLog(@"Loaded %u drawings", [_model.drawings count]);
    [_model notifyDelegates: @selector(drawingsDidLoad:) object: [NSMutableArray arrayWithArray: _model.drawings]];
}

@end