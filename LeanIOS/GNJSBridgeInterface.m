//
//  GNJSBridgeInterface.m
//  GonativeIO
//
//  
// Copyright © 2021-2022 WindCloud Australia. All rights reserved.
//

#import "GNJSBridgeInterface.h"
#import <Foundation/Foundation.h>

@implementation GNJSBridgeInterface : NSObject

-(instancetype) init
{
    self = [super init];
    return self;
}

- (void)userContentController:(nonnull WKUserContentController *)userContentController didReceiveScriptMessage:(nonnull WKScriptMessage *)message {
    if([message.body isKindOfClass:[NSDictionary class]]){
        [self.wvc handleJSBridgeFunctions:(NSDictionary*)message.body];
    } else if ([message.body isKindOfClass:[NSString class]]){
        NSURL *url = [NSURL URLWithString:(NSString*) message.body];
        if(!url) return;
        [self.wvc handleJSBridgeFunctions:url];
    }
}

@end
