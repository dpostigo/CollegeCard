//
// Created by dpostigo on 2/28/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "UserDetailRowObject.h"


@implementation UserDetailRowObject {
}


@synthesize isCustomField;


- (id) initWithTextLabel: (NSString *) aTextLabel detailTextLabel: (NSString *) aDetailTextLabel isCustomField: (BOOL) aIsCustomField {
    self = [super init];
    if (self) {
        textLabel = aTextLabel;
        detailTextLabel = aDetailTextLabel;
        isCustomField = aIsCustomField;
    }

    return self;
}




@end