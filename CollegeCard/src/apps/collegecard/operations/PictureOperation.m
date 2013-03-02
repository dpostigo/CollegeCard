//
// Created by dpostigo on 2/26/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "PictureOperation.h"
#import "CCResponse.h"
#import "CCPhoto.h"


@implementation PictureOperation {
}


@synthesize image;


- (id) initWithImage: (UIImage *) anImage {

    //    NSDictionary *paramDict = [NSDictionary dictionaryWithObject: _model.currentUser.objectId forKey: @"id"];

    self = [super initWithDelegate: nil httpMethod: @"PUT" baseUrl: @"users/update.json" paramDict: nil];
    if (self) {
        image = anImage;
        [self addPhotoUIImage: image paramDict: nil];
    }

    return self;
}


- (void) requestDoneWithResponse: (CCResponse *) response {
    [super requestDoneWithResponse: response];

    if ([response.meta.status isEqualToString: @"ok"]) {

        NSArray *users = [response getObjectsOfType: [CCUser class]];
        CCUser *user = [users objectAtIndex: 0];
        NSLog(@"user.photo.thumbURL = %@", user.photo.thumbURL);
        [_model notifyDelegates: @selector(pictureOperationSucceeded) object: nil];
        [_model notifyDelegates: @selector(userPictureUpdated) object: nil];
    } else {
        NSLog(@"Problem.");
    }
}

@end