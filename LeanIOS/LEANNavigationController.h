//
//  LEANNavigationController.h
// Copyright © 2021-2022 WindCloud Australia. All rights reserved.
//
//  Created by Weiyin He on 2/8/14.
//  Copyright (c) 2014 GoNative.io LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REFrostedViewController.h"

@interface LEANNavigationController : UINavigationController
@property BOOL sidebarEnabled;
- (void)panGestureRecognized:(UIPanGestureRecognizer *)sender;
@end
