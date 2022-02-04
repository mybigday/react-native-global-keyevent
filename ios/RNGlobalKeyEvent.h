#import <UIKit/UIKit.h>
#import <React/RCTBridgeModule.h>
#import <React/RCTEventEmitter.h>

@interface RNGlobalKeyEvent : RCTEventEmitter <RCTBridgeModule>

@property (nonatomic) BOOL hasListeners;
@property (nonatomic) BOOL invalidated;

+ (id)allocWithZone:(NSZone *)zone;

+ (id)getSingletonInstance;

- (BOOL)isListening;

- (void)sendKeyUp:(NSString *)keyString modifierFlags:(UIKeyModifierFlags)modifierFlags;
- (void)sendKeyDown:(NSString *)keyString modifierFlags:(UIKeyModifierFlags)modifierFlags;

@end