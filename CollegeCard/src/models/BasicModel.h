//
// Created by dpostigo on 9/20/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "BasicLibrary.h"

@interface BasicModel : BasicLibrary {

}

- (NSString *) pathForSearchPath: (NSSearchPathDirectory) searchPath;
- (NSString *) cacheDirectoryPath;
- (NSString *) userDocumentsPath;

@end