//
//  LEANConfigUpdater.h
// Copyright © 2021-2022 WindCloud Australia. All rights reserved.
//
//  Created by Weiyin He on 7/22/14.
//  Copyright (c) 2014 GoNative.io LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LEANConfigUpdater : NSObject

+ (void)registerEvent:(NSString*)event data:(NSDictionary*)data;


@end
