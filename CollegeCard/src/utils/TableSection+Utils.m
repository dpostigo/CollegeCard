//
// Created by dpostigo on 2/25/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "TableSection+Utils.h"


@implementation TableSection (Utils)



- (TableRowObject *) tableRowObjectForString: (NSString *) string {
    for (TableRowObject *rowObject in self.rows) {
        if ([rowObject.textLabel isEqualToString: string]) {
            return rowObject;
        }
    }
    return nil;
}

@end