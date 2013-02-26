//
// Created by dpostigo on 9/24/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "BasicAQGridViewController.h"
#import "AQGridView.h"
#import "TableRowObject.h"

@implementation BasicAQGridViewController {


}

@synthesize dataSource;
@synthesize grid;

- (void) awakeFromNib {
    [super awakeFromNib];



}

- (void) prepareDataSource {
    grid.delegate = self;
    grid.dataSource = self;

    self.dataSource = [[NSMutableArray alloc] init];

}



- (AQGridViewCell *) cellForRow: (TableRowObject *) tableRow identifier: (NSString *) identifier {

    AQGridViewCell *cell = [[AQGridViewCell alloc] initWithFrame: CGRectMake(0, 0, PANEL_WIDTH, PANEL_WIDTH * 0.75) reuseIdentifier: identifier];

    return cell;

}

- (void) formatCell: (AQGridViewCell *) cell forRow: (TableRowObject *) tableRow {

}


- (NSUInteger) numberOfItemsInGridView: (AQGridView *) gridView1 {
    return [dataSource count];
}

- (AQGridViewCell *) gridView: (AQGridView *) gridView1 cellForItemAtIndex: (NSUInteger) index {

    TableRowObject *rowObject = [dataSource objectAtIndex: index];
    NSString *identifier = [NSString stringWithFormat: @"cell-%u", index];
    AQGridViewCell *cell = [grid dequeueReusableCellWithIdentifier: identifier];

    if (cell == nil) {
        cell = [self cellForRow: rowObject identifier: identifier];

    }
    [self formatCell: cell forRow: rowObject];

    return cell;
}



@end