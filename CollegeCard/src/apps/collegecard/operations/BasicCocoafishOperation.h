//
// Created by dpostigo on 2/24/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "CCRequest.h"
#import "Model.h"
#import "CCResponse.h"


@interface BasicCocoafishOperation : CCRequest {
    Model *_model;
}


- (void) requestDoneWithResponse: (CCResponse *) response;

@end