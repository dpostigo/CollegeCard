//
// Created by dpostigo on 10/23/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "MainViewController.h"

@implementation MainViewController {
}


@synthesize containerView;
@synthesize navigationController;

- (id) initWithCoder: (NSCoder *) aDecoder {
    self = [super initWithCoder: aDecoder];
    if (self) {

    }

    return self;
}



- (void) prepareDataSource {
    [super prepareDataSource];
    NSLog(@"%s", __PRETTY_FUNCTION__);

    TableSection *tableSection = [[TableSection alloc] initWithTitle: @"Main"];
    [dataSource addObject: tableSection];
    NSArray *plist = [self loadFromPropertyList: @"categories"];


    for (NSString *string in plist) {
        NSLog(@"string = %@", string);

        TableRowObject *tableRowObject = [[TableRowObject alloc] initWithTextLabel: string];
        [tableSection.rows addObject: tableRowObject];
    }

    NSLog(@"[dataSource count] = %u", [dataSource count]);
}



- (void) viewDidLoad {
    [super viewDidLoad];



    [self prepareDataSource];


    table.delegate = self;
    table.dataSource = self;




}

- (UITableViewCell *) newCellForRow: (TableRowObject *) rowObject inTableSection: (TableSection *) tableSection withIdentifier: (NSString *) identifier {
    UITableViewCell *cell = [table dequeueReusableCellWithIdentifier: NSStringFromClass([self class])];
    return cell;
}

- (void) didSelectCellAtRow: (TableRowObject *) rowObject tableSection: (TableSection *) tableSection {

    if ([rowObject.textLabel isEqualToString: @"GradientView"]) {


        UIViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier: @"GradientViewController"];
        [self.navigationController pushViewController: controller animated: YES];



    }

}

- (void) prepareForSegue: (UIStoryboardSegue *) segue sender: (id) sender {
    [super prepareForSegue: segue sender: sender];


    if ([segue.identifier isEqualToString: @"embedSegue"]) {
        self.navigationController = segue.destinationViewController;
    }
}


@end