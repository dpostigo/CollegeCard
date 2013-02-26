//
// Created by dpostigo on 10/11/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "BasicViewController.h"
#import "BasicCollectionCell.h"

@class TableSection;
@class TableRowObject;

@interface BasicCollectionViewController : BasicViewController <UICollectionViewDelegate, UICollectionViewDataSource> {

    NSMutableArray *dataSource;
    UICollectionView *collection;

}

@property(nonatomic, strong) NSMutableArray *dataSource;
@property(nonatomic, strong) UICollectionView *collection;


#pragma mark Helpers
- (TableSection *) tableSectionForString: (NSString *) string;
- (TableRowObject *) tableRowForString: (NSString *) string inTableSection: (TableSection *) tableSection;
- (BasicCollectionCell *) cellForTableRow: (TableRowObject *) tableRow inTableSection: (TableSection *) tableSection;




#pragma mark Core methods
- (BasicCollectionCell *) createCollectionCellAtIndexPath: (NSIndexPath *) indexPath;
- (void) formatDisplay: (BasicCollectionCell *) aCell tableSection: (TableSection *) tableSection tableRow: (TableRowObject *) tableRow;
- (void) formatData: (BasicCollectionCell *) aCell tableSection: (TableSection *) tableSection tableRow: (TableRowObject *) tableRow;
- (void) didSelectCell: (BasicCollectionCell *) aCell tableSection: (TableSection *) tableSection tableRow: (TableRowObject *) tableRow;
- (void) collectionView: (UICollectionView *) collectionView1 didSelectItemAtIndexPath: (NSIndexPath *) indexPath;
- (void) collectionView: (UICollectionView *) collectionView didHighlightItemAtIndexPath: (NSIndexPath *) indexPath;
- (void) didHighlightCellAtIndexPath: (NSIndexPath *) indexPath tableSection: (TableSection *) tableSection;
- (void) didHighlightCellAtIndexPath: (NSIndexPath *) indexPath tableSection: (TableSection *) tableSection tableRow: (TableRowObject *) tableRow;





#pragma mark UICollectionView
- (void) didSelect: (TableSection *) tableSection tableRow: (TableRowObject *) tableRow;
- (void) didSelectCell: (BasicCollectionCell *) aCell tableRow: (TableRowObject *) tableRow;
- (void) didSelectCellAtIndexPath: (NSIndexPath *) indexPath tableSection: (TableSection *) tableSection;
- (void) didSelectCellAtIndexPath: (NSIndexPath *) indexPath tableSection: (TableSection *) tableSection tableRow: (TableRowObject *) tableRow;

- (NSInteger) collectionView: (UICollectionView *) collectionView1 numberOfItemsInSection: (NSInteger) section;
- (NSInteger) numberOfSectionsInCollectionView: (UICollectionView *) collectionView1;
- (UICollectionViewCell *) collectionView: (UICollectionView *) collectionView1 cellForItemAtIndexPath: (NSIndexPath *) indexPath;


@end