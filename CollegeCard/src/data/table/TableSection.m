//
// Created by dpostigo on 9/2/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "TableSection.h"


@implementation TableSection {
}


@synthesize title;
@synthesize rows;
@synthesize showsHeader;


- (id) init {
    return [self initWithTitle: @"Main"];
}


- (id) initWithTitle: (NSString *) aTitle rows: (NSMutableArray *) aRows {
    self = [super init];
    if (self) {
        title = aTitle;
        rows = aRows;
    }

    return self;
}


- (id) initWithTitle: (NSString *) aTitle {
    self = [super init];
    if (self) {
        title = aTitle;
        self.rows = [[NSMutableArray alloc] init];
    }

    return self;
}


- (NSUInteger) count {
    return [rows count];
}

@end