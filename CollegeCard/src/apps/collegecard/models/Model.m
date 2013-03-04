//
// Created by dpostigo on 9/20/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "Model.h"
#import "Cocoafish.h"
#import "UIImage+Utils.h"
#import "TTTTimeIntervalFormatter.h"
#import "NSDate+JMSimpleDate.h"


@implementation Model {
    NSMutableDictionary *propertySlugs;
    TTTTimeIntervalFormatter *intervalFormatter;
}


@synthesize currentPlace;
@synthesize merchantEvents;
@synthesize currentEvent;
@synthesize dateFormatter;


+ (Model *) sharedModel {
    static Model *_instance = nil;

    @synchronized (self) {
        if (_instance == nil) {
            _instance = [[self alloc] init];
        }
    }

    return _instance;
}


- (id) init {
    self = [super init];
    if (self) {

        propertySlugs = [[NSMutableDictionary alloc] init];
        [propertySlugs setObject: @"First Name" forKey: @"first_name"];
        [propertySlugs setObject: @"Last Name" forKey: @"last_name"];
        [propertySlugs setObject: @"Your School" forKey: @"college"];
        [propertySlugs setObject: @"Graduation Date" forKey: @"graduationDate"];
        [propertySlugs setObject: @"Major" forKey: @"major"];
        [propertySlugs setObject: @"Birth Date" forKey: @"birthDate"];
        [propertySlugs setObject: @"Gender" forKey: @"gender"];

        [propertySlugs setObject: @"Store Name" forKey: @"name"];
        [propertySlugs setObject: @"Address" forKey: @"address"];
        [propertySlugs setObject: @"City" forKey: @"city"];
        [propertySlugs setObject: @"State" forKey: @"state"];
        [propertySlugs setObject: @"Zip Code" forKey: @"postal_code"];
    }

    return self;
}


- (BOOL) isLoggedIn {
    CCUser *user = [[Cocoafish defaultCocoafish] getCurrentUser];
    return (user != nil);
}


- (CCUser *) currentUser {
    return [[Cocoafish defaultCocoafish] getCurrentUser];
}


- (NSDateFormatter *) dateFormatter {
    if (!dateFormatter) {

        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateStyle = NSDateFormatterMediumStyle;
        dateFormatter.dateFormat = @"EEEE, LLLL d, yyyy\nh:m a ";
    }
    return dateFormatter;
}


- (NSString *) timeStringForEvent: (CCEvent *) event {

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"h:m a";

    NSString *endDayString = [self.timeIntervalFormatter simpleDayString: event.endTime];

    if (event.endTime.hasPassed) {
        return [NSString stringWithFormat: @"Ended %@", endDayString];
    }

    else if (event.startTime.hasPassed) {
        return [NSString stringWithFormat: @"Ends %@", endDayString];
    }

    else {

        NSString *startDayString = [event.startTime relativeFutureString];
        return [NSString stringWithFormat: @"Starts %@", startDayString];
    }
}


- (TTTTimeIntervalFormatter *) timeIntervalFormatter {
    if (intervalFormatter == nil) {
        intervalFormatter = [[TTTTimeIntervalFormatter alloc] init];
        intervalFormatter.usesIdiomaticDeicticExpressions = YES;
    }
    return intervalFormatter;
}


- (UIImageView *) nextImageView {
    return [[UIImageView alloc] initWithImage: [UIImage newImageFromResource: @"arrow-right-dark.png"]];
}


- (NSString *) slugForProperty: (NSString *) property {
    return [propertySlugs objectForKey: property];
}


- (NSString *) propertyForSlug: (NSString *) slug {
    return [[propertySlugs allKeysForObject: slug] objectAtIndex: 0];
}

@end