//
// Created by dpostigo on 3/3/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "PlacePictureOperation.h"
#import "CCPhoto.h"


@implementation PlacePictureOperation {
}


@synthesize image;


- (id) initWithImage: (UIImage *) anImage {

    NSMutableDictionary *paramDict = [[NSMutableDictionary alloc] init];
    [paramDict setObject: [Model sharedModel].currentUser.placeId forKey: @"place_id"];
    self = [super initWithDelegate: nil httpMethod: @"PUT" baseUrl: @"places/update.json" paramDict: paramDict];
    if (self) {
        image = anImage;
        [self addPhotoUIImage: image paramDict: nil];
    }

    return self;
}


- (void) requestDoneWithResponse: (CCResponse *) response {
    [super requestDoneWithResponse: response];

    if ([response.meta.status isEqualToString: @"ok"]) {

        NSArray *places = [response getObjectsOfType:[CCPlace class]];
        CCPlace *place = [places objectAtIndex: 0];
        NSLog(@"place.photo.thumbURL = %@", place.photo.thumbURL);

        _model.currentPlace = place;
        [_model notifyDelegates: @selector(placePictureUpdated) object: nil];

        //        NSArray *users = [response getObjectsOfType: [CCUser class]];
//        CCUser *user = [users objectAtIndex: 0];
//        NSLog(@"user.photo.thumbURL = %@", user.photo.thumbURL);
//        [_model notifyDelegates: @selector(pictureOperationSucceeded) object: nil];
//        [_model notifyDelegates: @selector(userPictureUpdated) object: nil];
    } else {
        NSLog(@"Problem.");
    }
}

@end