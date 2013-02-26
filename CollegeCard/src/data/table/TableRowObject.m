//
// Created by dpostigo on 9/3/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "TableRowObject.h"

@implementation TableRowObject


@synthesize textLabel;

@synthesize detailTextLabel;

@synthesize isLoading;

@synthesize content;
@synthesize image;
@synthesize intContent;
@synthesize floatContent;
@synthesize stringContent;


- (id) init {
    self = [super init];
    if (self) {

    }

    return self;
}

- (id) initWithTextLabel: (NSString *) aTextLabel detailTextLabel: (NSString *) aDetailTextLabel {
    self = [super init];
    if (self) {
        textLabel = aTextLabel;

        detailTextLabel = aDetailTextLabel;
    }

    return self;
}

- (id) initWithTextLabel: (NSString *) aTextLabel {
    self = [super init];
    if (self) {
        textLabel = aTextLabel;
    }

    return self;
}

- (id) initWithContent: (id) aContent {
    self = [super init];
    if (self) {
        content = aContent;
    }

    return self;
}




@end