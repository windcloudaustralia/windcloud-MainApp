//
//  GNDefines.h
//  Pods
//
//  Created by Wind Cloud AU on 1.02.22.
//

#if __OBJC__
#  import <Foundation/Foundation.h>
#endif

#if defined(__cplusplus)
#define GN_EXTERN extern "C" __attribute__((visibility("default")))
#define GN_EXTERN_C_BEGIN extern "C" {
#define GN_EXTERN_C_END }
#else
#define GN_EXTERN extern __attribute__((visibility("default")))
#define GN_EXTERN_C_BEGIN
#define GN_EXTERN_C_END
#endif
