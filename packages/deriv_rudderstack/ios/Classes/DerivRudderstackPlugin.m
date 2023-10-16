#import "DerivRudderstackPlugin.h"
#if __has_include(<deriv_rudderstack/deriv_rudderstack-Swift.h>)
#import <deriv_rudderstack/deriv_rudderstack-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "deriv_rudderstack-Swift.h"
#endif

@implementation DerivRudderstackPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftDerivRudderstackPlugin registerWithRegistrar:registrar];
}
@end
