//
//  GNEventEmitter.m
//  GoNativeCore
//
//  Created by Hunaid Hassan on 07.07.21.
//

#import "GNEventEmitter.h"

@implementation GNEventEmitter

- (NSString *)createJSForCallback:(NSString *)name, ... NS_REQUIRES_NIL_TERMINATION {
    va_list args;
    va_start(args, name);
    
    id arg = nil;
    NSMutableArray *params = [NSMutableArray new];
    while ((arg = va_arg(args, id)) != nil) {
        [params addObject:arg];
    }
    
    NSString * js = [self createJSForCallback:name params:params];
    
    va_end(args);
    return js;
}

- (NSString *)createJSForCallback:(NSString *)name params:(NSArray *)params {
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:[@[name] arrayByAddingObjectsFromArray:params]
                                                       options:0
                                                         error:nil];
    if (!jsonData) {
        return nil;
    }
    NSString * jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    return [NSString stringWithFormat:@"function gonative_do_callback() {"
     "var args = Array.from(arguments);"
     "var fnName = args.shift();"
     "if (typeof window[fnName] !== 'function') { return };"
        "try{"
            "var callBackFn = window[fnName];"
            "callBackFn(...args);"
        "}catch(ignored){}"
     "}"
     "gonative_do_callback(...%@)", jsonString];
}

@end
