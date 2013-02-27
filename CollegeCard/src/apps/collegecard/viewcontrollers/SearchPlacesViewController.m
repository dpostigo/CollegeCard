//
// Created by dpostigo on 2/26/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "SearchPlacesViewController.h"
#import "SearchPlacesOperation.h"





@implementation SearchPlacesViewController {
}


- (void) prepareDataSource {
    TableSection *tableSection = [[TableSection alloc] initWithTitle: @""];
    [tableSection.rows addObject: [[TableRowObject alloc] initWithTextLabel: ENTER_SEARCH_KEY]];
    [dataSource addObject: tableSection];
}




#pragma mark UISearchBar -

- (void) searchBarTextDidBeginEditing: (UISearchBar *) searchBar {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}


- (void) searchBarTextDidEndEditing: (UISearchBar *) searchBar {
    NSString *searchString = searchBar.text;
    [_queue addOperation: [[SearchPlacesOperation alloc] initWithPlaceName: searchString]];
}


- (void) searchBarSearchButtonClicked: (UISearchBar *) searchBar {
    [searchBar resignFirstResponder];
}

@end