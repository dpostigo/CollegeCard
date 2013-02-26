//
// Created by dpostigo on 9/20/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "Model.h"

@implementation Model {

}

@synthesize drawings;
@synthesize usesGestures;
@synthesize directorLive;

+ (Model *) sharedModel {
    static Model *_instance = nil;

    @synchronized (self) {
        if (_instance == nil) {
            _instance = [[self alloc] init];
        }
    }

    return _instance;
}

- (id) init {
    self = [super init];
    if (self) {

        self.usesGestures = YES;
        self.drawings = [[NSMutableArray alloc] init];

    }

    return self;
}


@end