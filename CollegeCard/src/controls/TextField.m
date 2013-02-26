//
// Created by dpostigo on 12/4/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "TextField.h"
#import "TextFieldDelegate.h"
#import "NSString+Utils.h"


@implementation TextField {
}


@synthesize isNumeric;
@synthesize characterLimit;
@synthesize mode;
@synthesize invalidView;


- (id) init {
    self = [super init];
    if (self) {

        //        characterLimit = -1;
    }

    return self;
}


- (id) initWithCoder: (NSCoder *) aDecoder {
    self = [super initWithCoder: aDecoder];
    if (self) {
        invalidView.alpha = 0;
    }

    return self;
}


- (BOOL) isValid {

    NSString *string = [self.text trimWhitespace];

    switch (mode) {
        case TextFieldModeDefault:
            if ([string isEqualToString: @""]) {
                return NO;
            }

            break;

        case TextFieldModeEmail :
            if (![self.text containsString: @"@"]) {
                return NO;
            } else {

                NSArray *array = [self.text componentsSeparatedByString: @"@"];
                string = [array objectAtIndex: 1];
                if (![string containsString: @"."]) {
                    return NO;
                } else {
                    array = [string componentsSeparatedByString: @"."];
                    string = [array objectAtIndex: 1];
                    if ([string length] < 1) {
                        return NO;
                    }
                }
            }
            break;

        case TextFieldModePhone:
            if ([self.text length] < 10) {
                return NO;
            }

            break;

        case TextFieldModeZip:
            if ([self.text length] < 5) {
                return NO;
            }
            break;
    }
    return YES;
}

@end