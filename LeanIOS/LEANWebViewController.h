//
//  LEANWebViewController.h
//  LeanIOS
//
//  Created by Weiyin He on 2/10/14.
// Copyright (c) 2014 GoNative.io LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "REFrostedViewController.h"
#import "LEANProfilePicker.h"
@class LEANTabManager;

static NSString *kLEANWebViewControllerUserStartedLoading = @"io.gonative.ios.WebViewController.started";
static NSString *kLEANWebViewControllerUserFinishedLoading = @"io.gonative.ios.WebViewController.finished";
static NSString *kLEANWebViewControllerClearPools = @"io.gonative.ios.WebViewController.clearPools";

@interface LEANWebViewController : UIViewController
@property BOOL checkLoginSignup;
@property LEANTabManager *tabManager;
@property NSURL *initialUrl;
@property UIView *initialWebview;
@property (class, nonatomic, readonly) NSInteger currentWindows;

- (IBAction) showMenu;
- (void) loadUrlString:(NSString*)url;
- (void) loadUrlAfterFilter:(NSURL*) url;
- (void) loadUrl:(NSURL*) url;
- (void) loadRequest:(NSURLRequest*) request;
- (void) loadUrl:(NSURL *)url andJavascript:(NSString*)js;
- (void) runJavascript:(NSString *) script;
- (void) logout;
- (void) showTabBarAnimated:(BOOL)animated;
- (void) hideTabBarAnimated:(BOOL)animated;
- (void) showToolbarAnimated:(BOOL)animated;
- (void) hideToolbarAnimated:(BOOL)animated;
- (void) sharePage: (id)sender;
- (void) sharePageWithUrl:(NSString*)url sender:(id)sender;
- (BOOL) canGoBack;
- (void) goBack;
- (BOOL) canGoForward;
- (void) goForward;
- (void) refreshPage;
- (void) setSharePopOverRect:(CGRect)rect;
- (void) handleJSBridgeFunctions:(id)data;
@end
