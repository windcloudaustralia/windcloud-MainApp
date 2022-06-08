//
//  GNBridge.m
//  GoNativeCore
//
//  Created by Hunaid Hassan on 21.06.21.
//

#import "GNBridge.h"
#import "GNBridgeModule.h"
#import "GNEventEmitter.h"

#define APPLICATION_CALLBACK(fn_name) \
-(void)fn_name:(UIApplication *)application { \
    for(id<GNBridgeModule> moduleProvider in self->moduleProviders) { \
        if([moduleProvider respondsToSelector:@selector(fn_name:)]) { \
            [moduleProvider fn_name:application]; \
        } \
    } \
}

#define RUNNER_CALLBACK(fn_name) \
-(void)fn_name:(id<GNJavascriptRunner>)runner { \
    for(id<GNBridgeModule> moduleProvider in self->moduleProviders) { \
        if([moduleProvider respondsToSelector:@selector(fn_name:)]) { \
            [moduleProvider fn_name:runner]; \
        } \
    } \
}

static NSMutableArray<Class> *GNModuleClasses;
static dispatch_queue_t GNModuleClassesSyncQueue;
NSArray<Class> *GNGetModuleClasses(void) {
    if(GNModuleClasses == nil) {
        return [NSArray new];
    }
    __block NSArray<Class> *result;
    dispatch_sync(GNModuleClassesSyncQueue, ^{
      result = [GNModuleClasses copy];
    });
    return result;
}

void GNRegisterModule(Class);
void GNRegisterModule(Class moduleClass) {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        GNModuleClasses = [NSMutableArray new];
        GNModuleClassesSyncQueue = dispatch_queue_create("io.gonative.ModuleClassesSyncQueue", DISPATCH_QUEUE_CONCURRENT);
    });
    
    //TODO: Add assertion to see if class confirms to protocol
    
    dispatch_barrier_async(GNModuleClassesSyncQueue, ^{
      [GNModuleClasses addObject:moduleClass];
    });
}

@implementation GNBridge {
    NSArray<id<GNBridgeModule>> *moduleProviders;
}
- (instancetype)init {
    if ([super init]) {
        [self setUp];
    }
    
    return self;
}

- (void)setUp {
    [self initializeModules:GNGetModuleClasses()];
}

-(void)initializeModules:(NSArray<Class> *)modules {
    NSArray *moduleClassesCopy = [modules copy];
    NSMutableArray<id<GNBridgeModule>> *moduleProviders = [NSMutableArray new];
    for(Class moduleClass in moduleClassesCopy) {
        id moduleProvider = [moduleClass new];
        if ([moduleProvider isKindOfClass:[GNEventEmitter class]]) {
            [moduleProvider setBridge:self];
        }
        [moduleProviders addObject:moduleProvider];
    }
    
    self->moduleProviders = moduleProviders;
}

- (BOOL)runner:(id<GNJavascriptRunner>)runner shouldLoadRequestWithURL:(NSURL *)url withData:(NSDictionary *)query {
    for(id<GNBridgeModule> moduleProvider in self->moduleProviders) {
        if([moduleProvider respondsToSelector:@selector(runner:shouldLoadRequestWithURL:withData:)]) {
            if (![moduleProvider runner:runner shouldLoadRequestWithURL:url withData:query]) {
                return NO;
            }
        }
    }
    return YES;
}

- (void)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    for(id<GNBridgeModule> moduleProvider in self->moduleProviders) {
        if([moduleProvider respondsToSelector:@selector(application:didFinishLaunchingWithOptions:)]) {
            [moduleProvider application:application didFinishLaunchingWithOptions:launchOptions];
        }
    }
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    for(id<GNBridgeModule> moduleProvider in self->moduleProviders) {
        if([moduleProvider respondsToSelector:@selector(application:openURL:options:)]) {
            if ([moduleProvider application:application openURL:url options:options]) {
                return YES;
            }
        }
    }
    
    return NO;
}

- (void)loadUserScriptsForContentController:(WKUserContentController *)userController {
    for(id<GNBridgeModule> moduleProvider in self->moduleProviders) {
        NSBundle *frameworkBundle = [NSBundle bundleForClass:[moduleProvider class]];
        
        NSString *className = NSStringFromClass([moduleProvider class]);
        NSString *bundleName = [className stringByReplacingOccurrencesOfString:@"GN" withString:@""];
        NSString *jsBundle = [NSString stringWithFormat:@"%@JS.bundle", bundleName];
        NSURL *bundleURL = [[frameworkBundle resourceURL] URLByAppendingPathComponent:jsBundle];
        NSBundle *bundle = [NSBundle bundleWithURL:bundleURL];
        
        NSString *polyfillPath = [bundle pathForResource:@"polyfill" ofType:@"js"];
        NSString *scriptSource = [NSString stringWithContentsOfFile:polyfillPath encoding:NSUTF8StringEncoding error:nil];
        WKUserScript * userScript = [[WKUserScript alloc] initWithSource:scriptSource injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:YES];
        [userController addUserScript:userScript];
    }
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    for(id<GNBridgeModule> moduleProvider in self->moduleProviders) {
        if([moduleProvider respondsToSelector:@selector(application:didReceiveRemoteNotification:)]) {
            [moduleProvider application:application didReceiveRemoteNotification:userInfo];
        }
    }
}

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity {
    for(id<GNBridgeModule> moduleProvider in self->moduleProviders) {
        if([moduleProvider respondsToSelector:@selector(application:continueUserActivity:)]) {
            if ([moduleProvider application:application continueUserActivity:userActivity]) {
                return YES;
            }
        }
    }
    
    return NO;
}

- (void)switchToWebView:(UIView*)newView withRunner:(id<GNJavascriptRunner>)runner {
    for(id<GNBridgeModule> moduleProvider in self->moduleProviders) {
        if([moduleProvider respondsToSelector:@selector(switchToWebView:withRunner:)]) {
            [moduleProvider switchToWebView:newView withRunner:runner];
        }
    }
}

- (void)runner:(id<GNJavascriptRunner>)runner willTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    for(id<GNBridgeModule> moduleProvider in self->moduleProviders) {
        if([moduleProvider respondsToSelector:@selector(runner:willTransitionToSize:withTransitionCoordinator:)]) {
            [moduleProvider runner:runner willTransitionToSize:size withTransitionCoordinator:coordinator];
        }
    }
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation withRunner:(id<GNJavascriptRunner>)runner; {
    for(id<GNBridgeModule> moduleProvider in self->moduleProviders) {
        if([moduleProvider respondsToSelector:@selector(webView:didFinishNavigation:withRunner:)]) {
            [moduleProvider webView:webView didFinishNavigation:navigation withRunner:runner];
        }
    }
}

APPLICATION_CALLBACK(applicationWillTerminate)
APPLICATION_CALLBACK(applicationDidEnterBackground)
APPLICATION_CALLBACK(applicationWillResignActive)
APPLICATION_CALLBACK(applicationWillEnterForeground)
APPLICATION_CALLBACK(applicationDidBecomeActive)

RUNNER_CALLBACK(runnerDidLoad)
RUNNER_CALLBACK(runnerWillAppear)
RUNNER_CALLBACK(runnerWillDisappear)
RUNNER_CALLBACK(hideWebViewWithRunner)

@end
