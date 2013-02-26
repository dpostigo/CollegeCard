//
// Created by dpostigo on 9/24/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "BasicViewController.h"
#import "AQGridView.h"

@class TableRowObject;

@interface BasicAQGridViewController : BasicViewController <AQGridViewDelegate, AQGridViewDataSource> {

    IBOutlet AQGridView *grid;

    NSMutableArray *dataSource;
}

@property(nonatomic, strong) NSMutableArray *dataSource;
@property(nonatomic, strong) AQGridView *grid;
- (void) prepareDataSource;
- (AQGridViewCell *) cellForRow: (TableRowObject *) tableRow identifier: (NSString *) identifier;
- (void) formatCell: (AQGridViewCell *) cell forRow: (TableRowObject *) tableRow;

@end