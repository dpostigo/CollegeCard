//
// Created by dpostigo on 2/28/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "TableRowObject.h"


@interface UserDetailRowObject : TableRowObject {
    BOOL isCustomField;
}


@property(nonatomic) BOOL isCustomField;
- (id) initWithTextLabel: (NSString *) aTextLabel detailTextLabel: (NSString *) aDetailTextLabel isCustomField: (BOOL) aIsCustomField;

@end