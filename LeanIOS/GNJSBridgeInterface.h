//
//  GNJSBridgeInterface.h
// Copyright © 2021-2022 WindCloud Australia. All rights reserved.
//
//  
// Copyright © 2021-2022 WindCloud Australia. All rights reserved.
//

#import <WebKit/WebKit.h>
#import "LEANWebViewController.h"

NS_ASSUME_NONNULL_BEGIN

static NSString * GNJSBridgeName = @"JSBridge";

@interface GNJSBridgeInterface : NSObject <WKScriptMessageHandler>
@property (weak) LEANWebViewController *wvc;
@end

NS_ASSUME_NONNULL_END
