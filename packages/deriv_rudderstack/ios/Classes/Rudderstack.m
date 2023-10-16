#import "Rudderstack.h"
#import <Rudder/Rudder.h>

@implementation Rudderstack

- (void) setToken {
    [[[RSClient sharedInstance] getContext] putDeviceToken:_pushToken];
}

@end
