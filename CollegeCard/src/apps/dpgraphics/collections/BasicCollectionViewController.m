//
// Created by dpostigo on 10/11/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "BasicCollectionViewController.h"
#import "TableSection.h"
#import "TableRowObject.h"
#import "BasicCollectionCell.h"

@implementation BasicCollectionViewController {
}

@synthesize dataSource;
@synthesize collection;

- (id) initWithCoder: (NSCoder *) aDecoder {
    self = [super initWithCoder: aDecoder];
    if (self) {
        NSLog(@"%s", __PRETTY_FUNCTION__);

        collection.delegate = self;
        collection.dataSource = self;
    }

    return self;
}



#pragma mark Helpers

- (TableSection *) tableSectionForString: (NSString *) string {
    TableSection *theSection = nil;
    for (TableSection *tableSection in dataSource) {
        if ([tableSection.title isEqualToString: string]) {
            theSection = tableSection;
            break;
        }
    }
    return theSection;
}


- (TableRowObject *) tableRowForString: (NSString *) string inTableSection: (TableSection *) tableSection {
    TableRowObject *theRow;

    for (TableRowObject *tableRow in tableSection.rows) {
        if ([tableRow.textLabel isEqualToString: string]) {
            theRow = tableRow;
            break;
        }
    }
    return theRow;

}

- (BasicCollectionCell *) cellForTableRow: (TableRowObject *) tableRow inTableSection: (TableSection *) tableSection {

    NSUInteger sectionIndex = [dataSource indexOfObject: tableSection];
    NSUInteger rowIndex = [tableSection.rows indexOfObject: tableRow];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow: rowIndex inSection: sectionIndex];


    BasicCollectionCell *cell = (BasicCollectionCell *) [collection cellForItemAtIndexPath: indexPath];
    return cell;

}



#pragma mark Core functions

- (BasicCollectionCell *) createCollectionCellAtIndexPath: (NSIndexPath *) indexPath {
    return nil;
}

- (void) formatDisplay: (BasicCollectionCell *) aCell tableSection: (TableSection *) tableSection tableRow: (TableRowObject *) tableRow {

    aCell.imageView.image = nil;

    if (tableRow.image != nil) {
        aCell.imageView.image = tableRow.image;
    }

    aCell.textLabel.text = tableRow.textLabel;
}

- (void) formatData: (BasicCollectionCell *) aCell tableSection: (TableSection *) tableSection tableRow: (TableRowObject *) tableRow {
}


- (void) didSelectCell: (BasicCollectionCell *) aCell tableRow: (TableRowObject *) tableRow {

}
- (void) didSelectCell: (BasicCollectionCell *) aCell tableSection: (TableSection *) tableSection tableRow: (TableRowObject *) tableRow {
}
- (void) didSelect: (TableSection *) tableSection tableRow: (TableRowObject *) tableRow {
}




- (void) didSelectCellAtIndexPath: (NSIndexPath *) indexPath tableSection: (TableSection *) tableSection {

}
- (void) didSelectCellAtIndexPath: (NSIndexPath *) indexPath tableSection: (TableSection *) tableSection  tableRow: (TableRowObject *) tableRow {

}





#pragma mark UICollectionView

- (NSInteger) collectionView: (UICollectionView *) collectionView1 numberOfItemsInSection: (NSInteger) section {
    TableSection *tableSection = [dataSource objectAtIndex: section];
    return [tableSection.rows count];
}

- (NSInteger) numberOfSectionsInCollectionView: (UICollectionView *) collectionView1 {
    return [dataSource count];
}

- (UICollectionViewCell *) collectionView: (UICollectionView *) collectionView1 cellForItemAtIndexPath: (NSIndexPath *) indexPath {
    BasicCollectionCell *cell = [self createCollectionCellAtIndexPath: indexPath];
    TableSection *tableSection = [dataSource objectAtIndex: indexPath.section];
    TableRowObject *tableRow = [tableSection.rows objectAtIndex: indexPath.row];

    [self formatDisplay: cell tableSection: tableSection tableRow: tableRow];
    [self formatData: cell tableSection: tableSection tableRow: tableRow];

    return cell;
}






#pragma mark Selection



- (void) collectionView: (UICollectionView *) collectionView1 didSelectItemAtIndexPath: (NSIndexPath *) indexPath {

    TableSection *tableSection = [dataSource objectAtIndex: indexPath.section];
    TableRowObject *tableRow = [tableSection.rows objectAtIndex: indexPath.row];

    BasicCollectionCell *cell = (BasicCollectionCell *) [collectionView1 cellForItemAtIndexPath: indexPath];

    [self didSelect: tableSection tableRow: tableRow];
    [self didSelectCell: cell tableRow: tableRow];
    [self didSelectCell: cell tableSection: tableSection tableRow: tableRow];

    [self didSelectCellAtIndexPath: indexPath tableSection: tableSection];
    [self didSelectCellAtIndexPath: indexPath tableSection: tableSection tableRow: tableRow];
}



#pragma mark Highlighting

- (void) collectionView: (UICollectionView *) collectionView didHighlightItemAtIndexPath: (NSIndexPath *) indexPath {

    TableSection *tableSection = [dataSource objectAtIndex: indexPath.section];
    TableRowObject *tableRow = [tableSection.rows objectAtIndex: indexPath.row];

    [self didHighlightCellAtIndexPath: indexPath tableSection: tableSection];
    [self didHighlightCellAtIndexPath: indexPath tableSection: tableSection tableRow: tableRow];



}

- (void) didHighlightCellAtIndexPath: (NSIndexPath *) indexPath tableSection: (TableSection *) tableSection {

}

- (void) didHighlightCellAtIndexPath: (NSIndexPath *) indexPath tableSection: (TableSection *) tableSection tableRow: (TableRowObject *) tableRow {

}

@end