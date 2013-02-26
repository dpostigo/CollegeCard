//
// Created by dpostigo on 9/20/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "BasicModel.h"


@implementation BasicModel {
}


- (NSString *) pathForSearchPath: (NSSearchPathDirectory) searchPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(searchPath, NSUserDomainMask, YES);
    NSString *directoryPath = [paths objectAtIndex: 0];
    return directoryPath;
}


- (NSString *) cacheDirectoryPath {
    return [self pathForSearchPath: NSCachesDirectory];
}

- (NSString *) userDocumentsPath {
    return [self pathForSearchPath: NSDocumentDirectory];
}

@end