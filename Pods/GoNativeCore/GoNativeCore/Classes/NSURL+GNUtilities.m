//
//  NSURL.m
//  GoNativeCore
//
//  Created by Hunaid Hassan on 18.10.21.
//

#import "NSURL+GNUtilities.h"

@implementation NSURL (GNUtilities)

- (NSURL * _Nonnull)URLByAppendingQueryParams:(NSDictionary * _Nonnull) params {
    NSURLComponents *components = [NSURLComponents componentsWithURL:self resolvingAgainstBaseURL:NO];
    NSMutableArray *queryItems = (components.queryItems ? :@[]).mutableCopy;
    [params enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [queryItems addObject:[NSURLQueryItem queryItemWithName:key value:obj]];
    }];
    components.queryItems = queryItems;
    
    return components.URL;
}

@end
