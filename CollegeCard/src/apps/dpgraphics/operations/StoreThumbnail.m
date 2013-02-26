//
// Created by dpostigo on 9/20/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "StoreThumbnail.h"
#import "Drawing.h"
#import "LinePoint.h"

@implementation StoreThumbnail {
}

@synthesize drawing;

- (void) main {
    [super main];


    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"MM-d-yyyy-Hmss";


    NSMutableArray *drawings = [[NSMutableArray alloc] initWithArray: _model.drawings];


    for (Drawing *drawing in drawings) {

        if (drawing.wasModified && drawing.thumbnailImage != nil) {

            NSLog(@"SAVING A DRAWING.");

            NSString *imageString = [dateFormatter stringFromDate: drawing.dateCreated];
            imageString = [imageString stringByReplacingOccurrencesOfString: @" " withString: @""];
            imageString = [NSString stringWithFormat: @"thumbnail-%@-%u.png", imageString, [_model.drawings indexOfObject: drawing]];

            NSString *path = [NSString stringWithFormat: @"%@/%@", _model.cacheDirectoryPath, imageString];
            [UIImagePNGRepresentation(drawing.image) writeToFile: path atomically: YES];
            drawing.thumbnailPath = path;
            drawing.wasModified = NO;

            NSLog(@"saved path = %@", path);
        }
    }


}


- (void) testArchiving {

    NSMutableArray *fakeArray = [[NSMutableArray alloc] init];
    LinePoint *linePoint = [[LinePoint alloc] init];
    linePoint.position = CGPointMake(0, 1);

    [fakeArray addObject: linePoint];

    NSData *fakeData = [NSKeyedArchiver archivedDataWithRootObject: fakeArray];
    [[NSUserDefaults standardUserDefaults] setObject: fakeData forKey: LINE_POINTS];

    NSData *fakeDataUnarchive = [[NSUserDefaults standardUserDefaults] objectForKey: LINE_POINTS];
    NSArray *fakeUnarchivedArray = [NSKeyedUnarchiver unarchiveObjectWithData: fakeDataUnarchive];

    NSLog(@"fakeUnarchivedArray = %@", fakeUnarchivedArray);

    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey: DRAWINGS];
    if (data != nil) {
        NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithData: data];

        for (Drawing *drawing in array) {
            NSLog(@"drawing = %@", drawing);
            NSLog(@"drawing.savedPoints = %u", [drawing.savedPoints count]);
            // NSLog(@"drawing.pointsData = %@", drawing.pointsData);
        }
    }
}

@end