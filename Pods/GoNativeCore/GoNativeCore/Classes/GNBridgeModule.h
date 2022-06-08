//
//  GNBridgeModule.h
//  GoNativeCore
//
//  Created by James Coates on 21.06.21.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>
#import "GNDefines.h"
#import "GNJavascriptRunner.h"

@class GNBridge;
@protocol GNBridgeMethod;

@protocol GNBridgeModule <NSObject>

#define GN_EXPORT_MODULE() \
GN_EXTERN void GNRegisterModule(Class); \
+ (void)load { GNRegisterModule(self); }

#define GN_CONCAT(A, B) A ## B

#define GN_EXTERN_MODULE(objc_name, objc_supername) \
objc_name : objc_supername \
@end \
@interface objc_name (GNExternModule) <GNBridgeModule> \
@end \
@implementation objc_name (GNExternModule) \
GN_EXTERN void GNRegisterModule(Class); \
__attribute__((constructor)) static void \
GN_CONCAT(initialize_, objc_name)() { GNRegisterModule([objc_name class]); }

@optional
- (BOOL)runner:(id<GNJavascriptRunner>)runner shouldLoadRequestWithURL:(NSURL*)url withData:(NSDictionary*)query;
- (void)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options;
- (void)applicationWillResignActive:(UIApplication *)application;
- (void)applicationDidEnterBackground:(UIApplication *)application;
- (void)applicationWillEnterForeground:(UIApplication *)application;
- (void)applicationWillTerminate:(UIApplication *)application;
- (void)applicationDidBecomeActive:(UIApplication *)application;
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo;
- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity;
- (void)runnerDidLoad:(id<GNJavascriptRunner>)runner;
- (void)runnerWillAppear:(id<GNJavascriptRunner>)runner;
- (void)runnerWillDisappear:(id<GNJavascriptRunner>)runner;
- (void)hideWebViewWithRunner:(id<GNJavascriptRunner>)runner;
- (void)switchToWebView:(UIView*)newView withRunner:(id<GNJavascriptRunner>)runner;
- (void)runner:(id<GNJavascriptRunner>)runner willTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator;
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation withRunner:(id<GNJavascriptRunner>)runner;
@end
