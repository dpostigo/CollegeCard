//
// Created by dpostigo on 2/25/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "TableSection.h"
#import "TableRowObject.h"


@interface TableSection (Utils)


- (TableRowObject *) tableRowObjectForString: (NSString *) string;

@end