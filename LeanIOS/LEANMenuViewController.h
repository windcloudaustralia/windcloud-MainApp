//
//  LEANMenuViewController.h
// Copyright © 2021-2022 WindCloud Australia. All rights reserved.
//
//  Created by Weiyin He on 2/7/14.
//  Copyright (c) 2014 GoNative.io LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REFrostedViewController.h"
#import "LEANLoginManager.h"

@interface LEANMenuViewController : UITableViewController
- (void)updateMenuWithStatus:(NSString*)status;
- (void)parseProfilePickerJSON:(NSString*)json;
@end
