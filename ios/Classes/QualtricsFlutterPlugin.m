#import "QualtricsFlutterPlugin.h"
#if __has_include(<flutter_qualtrics/flutter_qualtrics-Swift.h>)
#import <flutter_qualtrics/flutter_qualtrics-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_qualtrics-Swift.h"
#endif

@implementation QualtricsFlutterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftQualtricsFlutterPlugin registerWithRegistrar:registrar];
}
@end
