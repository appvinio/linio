#import "LinioPlugin.h"
#if __has_include(<linio/linio-Swift.h>)
#import <linio/linio-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "linio-Swift.h"
#endif

@implementation LinioPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftLinioPlugin registerWithRegistrar:registrar];
}
@end
