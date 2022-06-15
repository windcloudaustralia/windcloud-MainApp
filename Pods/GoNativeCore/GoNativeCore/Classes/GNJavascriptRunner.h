//
//  GNJavascriptRunner.h
//  Pods
//
//  Created by Wind Cloud AU on 07.07.21.
//

@protocol GNJavascriptRunner;

@protocol GNJavascriptRunner<NSObject>

- (void)runJavascript:(NSString *)script;
- (void)loadUrl:(NSURL *)url;

@end
