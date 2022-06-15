//
//  NSURL.h
//  WindCloud-CORE
//
//  Created by Wind Cloud AU on 18.10.21.
//

#import <Foundation/Foundation.h>

@interface NSURL (GNUtilities)
- (NSURL * _Nonnull)URLByAppendingQueryParams:(NSDictionary * _Nonnull) params;
@end
