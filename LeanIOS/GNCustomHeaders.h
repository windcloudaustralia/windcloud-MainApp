//
//  GNCustomHeaders.h
// Copyright © 2021-2022 WindCloud Australia. All rights reserved.
//
//  Created by Weiyin He on 5/1/17.
//  Copyright © 2017 GoNative.io LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GNCustomHeaders : NSObject
+(NSDictionary*)getCustomHeaders;
+(NSURLRequest*)modifyRequest:(NSURLRequest*)request;
+(BOOL)shouldModifyRequest:(NSURLRequest*)request;
@end
