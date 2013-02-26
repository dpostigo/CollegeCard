//
//  CCCheckin.h
//  Demo
//
//  Created by Wei Kong on 12/17/10.
//  Copyright 2011 Cocoafish Inc. All rights reserved.
//

#import "CCObjectWithPhoto.h"

@class CCUser;
@class CCPlaceCocoafish;
@class CCEvent;
@interface CCCheckin : CCObjectWithPhoto {
@private
	CCUser *_user;
	CCPlaceCocoafish *_place;
    CCEvent *_event;
	NSString *_message;
}

@property (nonatomic, retain, readonly) CCUser *user;
@property (nonatomic, retain, readonly) CCPlaceCocoafish *place;
@property (nonatomic, retain, readonly) CCEvent *event;
@property (nonatomic, retain, readonly) NSString *message;

@end
