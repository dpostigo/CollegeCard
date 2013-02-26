//
// Created by dpostigo on 9/20/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "Drawing.h"

@implementation Drawing {
}

@synthesize dateCreated;

@synthesize wasModified;

@synthesize image;

@synthesize imagePath;

@synthesize thumbnailImage;

@synthesize thumbnailPath;
@synthesize savedPoints;
@synthesize erasurePoints;
@synthesize actions;


- (id) init {
    self = [super init];
    if (self) {
        self.dateCreated = [NSDate date];
        self.wasModified = YES;
        self.savedPoints = [[NSMutableArray alloc] init];
        self.actions = [[NSMutableArray alloc] init];
    }

    return self;
}


- (id) initWithCoder: (NSCoder *) decoder {
    self = [super init];
    if (self) {

        self.dateCreated = [decoder decodeObjectForKey: @"dateCreated"];
        self.imagePath = [decoder decodeObjectForKey: @"imagePath"];
        self.thumbnailPath = [decoder decodeObjectForKey: @"thumbnailPath"];
        self.savedPoints = [[NSMutableArray alloc] init];
        self.actions = [[NSMutableArray alloc] init];

        NSArray *pointsArray = [decoder decodeObjectForKey: @"savedPoints"];
        [savedPoints addObjectsFromArray: pointsArray];

        NSArray *actionsArray = [decoder decodeObjectForKey: @"actions"];
        [actions addObjectsFromArray: actionsArray];


    }
    return self;
}


- (void) encodeWithCoder: (NSCoder *) encoder {
    [encoder encodeObject: dateCreated forKey: @"dateCreated"];
    [encoder encodeObject: savedPoints forKey: @"savedPoints"];
    [encoder encodeObject: actions forKey: @"actions"];

    if (imagePath != nil) [encoder encodeObject: imagePath forKey: @"imagePath"];
    if (thumbnailPath != nil) [encoder encodeObject: thumbnailPath forKey: @"thumbnailPath"];
}


- (void) setImage: (UIImage *) image1 {
    image = image1;
    thumbnailImage = [self imageWithImage: image scaledToSize: CGSizeMake(PANEL_WIDTH * 2, PANEL_WIDTH * 0.75 * 2)];
}


- (UIImage *) imageWithImage: (UIImage *) anImage scaledToSize: (CGSize) newSize {
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [anImage drawInRect: CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end