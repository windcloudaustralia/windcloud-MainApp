//
//  GNUtilities.m
//  GoNativeCore
//
//  Created by Hunaid Hassan on 18.10.21.
//

#import "GNUtilities.h"

@implementation GNUtilities

+(NSDictionary*)parseQueryParamsWithUrl:(NSURL*)url
{
    NSString *query = url.query;
    if (!query) return @{};
    
    NSMutableDictionary *result = [NSMutableDictionary dictionary];

    NSArray * queryComponents = [query componentsSeparatedByString:@"&"];
    for (NSString *keyValue in queryComponents) {
        NSArray *pairComponents = [keyValue componentsSeparatedByString:@"="];
        if (pairComponents.count != 2) continue;
        
        NSString *key = [[pairComponents firstObject] stringByRemovingPercentEncoding];
        NSString *value = [[pairComponents lastObject] stringByRemovingPercentEncoding];
        result[key] = value;
    }
    
    return result;
}

@end
