#import "QualtricsFlutterPlugin.h"
#if __has_include(<qualtrics_flutter/qualtrics_flutter-Swift.h>)
#import <qualtrics_flutter/qualtrics_flutter-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "qualtrics_flutter-Swift.h"
#endif

@implementation QualtricsFlutterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftQualtricsFlutterPlugin registerWithRegistrar:registrar];
}
@end
