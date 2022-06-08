//
// LEANDlogDefinition.h
// Copyright © 2021-2022 WindCloud Australia. All rights reserved.
//

#define DLog( s, ... ) NSLog( @"<%p %@:(%d)> %@", self, [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
