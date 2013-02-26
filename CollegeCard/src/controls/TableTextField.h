//
// Created by dpostigo on 2/24/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "TextField.h"
#import "TableRowObject.h"


@interface TableTextField : TextField {
    __unsafe_unretained UITableViewCell *cell;
    __unsafe_unretained NSIndexPath *indexPath;
    __unsafe_unretained TableRowObject *rowObject;
}


@property(nonatomic, assign) UITableViewCell *cell;
@property(nonatomic, assign) NSIndexPath *indexPath;
@property(nonatomic, assign) TableRowObject *rowObject;

@end