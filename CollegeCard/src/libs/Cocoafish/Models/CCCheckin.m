//
//  CCCheckin.m
//  Demo
//
//  Created by Wei Kong on 12/17/10.
//  Copyright 2011 Cocoafish Inc. All rights reserved.
//

#import "CCCheckin.h"
#import "CCUser.h"
#import "CCPlace.h"
#import "CCEvent.h"


@interface CCCheckin ()


@property(nonatomic, retain, readwrite) CCUser *user;
@property(nonatomic, retain, readwrite) CCPlace *place;
@property(nonatomic, retain, readwrite) NSString *message;
@property(nonatomic, retain, readwrite) CCEvent *event;

@end


@implementation CCCheckin


@synthesize user = _user;
@synthesize place = _place;
@synthesize message = _message;
@synthesize event = _event;


- (id) initWithJsonResponse: (NSDictionary *) jsonResponse {
    self = [super initWithJsonResponse: jsonResponse];
    if (self) {
        self.message = [jsonResponse objectForKey: CC_JSON_MESSAGE];
        @try {
            _user = [[CCUser alloc] initWithJsonResponse: [jsonResponse objectForKey: CC_JSON_USER]];
            _place = [[CCPlace alloc] initWithJsonResponse: [jsonResponse objectForKey: CC_JSON_PLACE]];
            _event = [[CCEvent alloc] initWithJsonResponse: [jsonResponse objectForKey: @"event"]];
        }
        @catch (NSException *e) {
            CCLog(@"Error: Failed to parse checkin object. Reason: %@", [e reason]);
            self = nil;
            return self;
        }
        if (self.user == nil || self.place == nil) {
            CCLog(@"invalid checkin object from server: %@", jsonResponse);
            self = nil;
            return self;
        }
    }
    return self;
}


+ (NSString *) modelName {
    return @"checkin";
}


+ (NSString *) jsonTag {
    return @"checkins";
}


- (void) dealloc {
    self.user = nil;
    self.place = nil;
    self.message = nil;
    self.event = nil;
}

@end
