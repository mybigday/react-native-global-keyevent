
#import <Foundation/Foundation.h>
#import "RNGlobalKeyEvent.h"

NSString* const keyUp = @"@RNGlobalKeyEvnet_keyUp";
NSString* const keyDown = @"@RNGlobalKeyEvnet_keyDown";

@implementation RNGlobalKeyEvent

#pragma mark - RNGlobalKeyEvent implementation

RCT_EXPORT_MODULE();

+ (BOOL)requiresMainQueueSetup
{
  return NO;
}

static RNGlobalKeyEvent *sharedInstance = nil;

+ (id)allocWithZone:(NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [super allocWithZone:zone];
    });
    return sharedInstance;
}

+ (id)getSingletonInstance {
    if (sharedInstance == nil || sharedInstance.invalidated) {
        sharedInstance = [[self alloc] init];
    }
    return sharedInstance;
}

- (BOOL)isListening {
    return self.hasListeners;
}

- (void)sendKeyUp:(NSString *)keyString modifierFlags:(UIKeyModifierFlags)modifierFlags {
    if (self.hasListeners && self.bridge) {
        [super sendEventWithName:keyUp body:@{@"pressedKey": keyString, @"modifierFlags": @(modifierFlags)}];
    }
}


- (void)sendKeyDown:(NSString *)keyString modifierFlags:(UIKeyModifierFlags)modifierFlags {
    if (self.hasListeners && self.bridge) {
        [super sendEventWithName:keyDown body:@{@"pressedKey": keyString, @"modifierFlags": @(modifierFlags)}];
    }
}

#pragma mark - RCTEventEmitter implementation

- (NSArray<NSString *> *)supportedEvents {
    return @[keyUp, keyDown];
}

- (void)startObserving {
    self.hasListeners = YES;
}

- (void)stopObserving {
    self.hasListeners = NO;
}

- (void) invalidate {
    self.invalidated = YES;
}

@end

