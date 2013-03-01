//
//  CCUser.m
//  Demo
//
//  Created by Wei Kong on 12/16/10.
//  Copyright 2011 Cocoafish Inc. All rights reserved.
//

#import "CCUser.h"
#import "CCPhoto.h"
#import "Cocoafish.h"
#import "CCDownloadManager.h"


/*@interface CCUser ()
 
 @property (nonatomic, retain, readwrite) NSString *email;
 @property (nonatomic, retain, readwrite) NSString *username;
 @property (nonatomic, retain, readwrite) NSString *firstName;
 @property (nonatomic, retain, readwrite) NSString *lastName;
 //@property (nonatomic, readwrite) Boolean facebookAuthorized;
 @property (nonatomic, retain, readwrite) NSString *facebookAccessToken;
 
 @end*/

@interface CCExternalAccount ()


@property(nonatomic, retain, readwrite) NSString *externalId;
@property(nonatomic, retain, readwrite) NSString *externalType;
@property(nonatomic, retain, readwrite) NSString *token;
@end


@implementation CCUser


@synthesize email = _email;
@synthesize username = _username;
@synthesize firstName = _firstName;
@synthesize lastName = _lastName;
@synthesize role = _role;
@synthesize externalAccounts = _externalAccounts;
@synthesize stats = _stats;
@synthesize checkins;


- (CCPlaceCocoafish *) merchantPlace {
    return [self.customFields objectForKey: @"major"];
}


- (BOOL) isMerchant {
    return [[self.customFields objectForKey: @"isMerchant"] boolValue];
}


- (NSString *) firstName {
    if (_firstName == nil) return @"Joe";
    return _firstName;
}


- (NSArray *) savedPlaces {
    NSArray *array = [self.customFields objectForKey: @"savedPlaces"];
    if (array == nil) {
        return [NSArray array];
    }
    return array;
}


- (BOOL) isSavedPlace: (NSString *) savedId {
    return [self.savedPlaces containsObject: savedId];
}


- (NSString *) displayName {
    return [NSString stringWithFormat: @"%@ %@", _firstName, _lastName];
}


- (NSString *) placeId {
    return [self.customFields objectForKey: @"placeId"];
}


- (NSString *) college {
    return [self.customFields objectForKey: @"college"];
}


- (NSString *) birthDate {
    return [self.customFields objectForKey: @"birthDate"];
}


- (NSString *) gender {
    return [self.customFields objectForKey: @"gender"];
}


- (NSString *) graduationDate {
    NSString *string = [self.customFields objectForKey: @"graduationDate"];
    if (string == nil) return @"Your graduation date";
    return string;
}


- (NSString *) major {
    return [self.customFields objectForKey: @"major"];
}


- (id) initWithJsonResponse: (NSDictionary *) jsonResponse {
    self = [super initWithJsonResponse: jsonResponse];
    if (self) {

        self.email = [jsonResponse objectForKey: CC_JSON_USER_EMAIL];
        self.username = [jsonResponse objectForKey: CC_JSON_USERNAME];
        self.firstName = [jsonResponse objectForKey: CC_JSON_USER_FIRST];
        self.lastName = [jsonResponse objectForKey: CC_JSON_USER_LAST];
        self.role = [jsonResponse objectForKey: @"role"];
        self.stats = [jsonResponse objectForKey: @"stats"];
        self.externalAccounts = [CCPhoto arrayWithJsonResponse: jsonResponse class: [CCExternalAccount class]];

        /*    if (self.firstName == nil && self.lastName == nil && self.username == nil) {
         CCLog(@"Invalid user object from server: %@", jsonResponse);
         [self release];
         self = nil;
         return self;
         }*/

    }
    return self;
}


- (id) initWithId: (NSString *) objectId first: (NSString *) first last: (NSString *) last email: (NSString *) email username: (NSString *) username {
    if (objectId == nil || (email == nil && username == nil)) {
        [self release];
        return nil;
    }
    if ((self = [super initWithId: objectId])) {
        self.firstName = first;
        self.lastName = last;
        self.email = email;
        self.username = username;
    }
    return self;
}


/*- (NSString *)description {
 return [NSString stringWithFormat:@"CCUser:\n\temail: %@\n\tuserName: %@\n\tfirst: %@\n\tlast: %@\n\tfacebookAccessToken :%@\n%@",
 self.email, self.username, self.firstName, self.lastName, self.facebookAccessToken, [super description]];
 }
 
 -(id)copyWithZone:(NSZone *)zone  
 {
 CCUser *copy = [super copyWithZone:zone];
 copy.email = [_email copy];
 copy.username = [_username copy];
 copy.firstName = [_firstName copy];
 copy.lastName = [_lastName copy];
 copy.facebookAccessToken = [_facebookAccessToken copy];
 copy.role = [_role copy];
 return copy;
 }*/

+ (NSString *) modelName {
    return @"user";
}


+ (NSString *) jsonTag {
    return @"users";
}


- (void) dealloc {
    self.email = nil;
    self.username = nil;
    self.firstName = nil;
    self.lastName = nil;
    self.role = nil;
    self.stats = nil;
    self.externalAccounts = nil;
    [checkins release];
    [super dealloc];
}

@end


@implementation CCExternalAccount


@synthesize externalId = _externalId;
@synthesize externalType = _externalType;
@synthesize token = _token;


- (id) initWithJsonResponse: (NSDictionary *) jsonResponse {
    self = [super initWithJsonResponse: jsonResponse];
    if (self) {

        self.token = [jsonResponse objectForKey: @"token"];
        self.externalId = [jsonResponse objectForKey: @"external_id"];
        self.externalType = [jsonResponse objectForKey: @"external_type"];
    }
    return self;
}


+ (NSString *) modelName {
    return @"external_account";
}


+ (NSString *) jsonTag {
    return @"external_accounts";
}


- (void) dealloc {
    self.externalId = nil;
    self.externalType = nil;
    self.token = nil;

    [super dealloc];
}

@end

