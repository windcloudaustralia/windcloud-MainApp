//
//  LEANWebViewIntercept.h
// Copyright © 2021-2022 WindCloud Australia. All rights reserved.
//
//  Created by Weiyin He on 4/12/14.
// Copyright (c) 2014 GoNative.io LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LEANWebViewIntercept : NSURLProtocol
+(void)register;
@end

@interface LEANWebviewInterceptTracker : NSObject
@property NSURLRequest *currentRequest;
+ (LEANWebviewInterceptTracker*)sharedTracker;
@end
