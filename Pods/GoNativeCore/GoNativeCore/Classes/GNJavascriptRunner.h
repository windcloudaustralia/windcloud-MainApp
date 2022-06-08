//
//  GNJavascriptRunner.h
//  Pods
//
//  Created by Hunaid Hassan on 07.07.21.
//

@protocol GNJavascriptRunner;

@protocol GNJavascriptRunner<NSObject>

- (void)runJavascript:(NSString *)script;
- (void)loadUrl:(NSURL *)url;

@end
