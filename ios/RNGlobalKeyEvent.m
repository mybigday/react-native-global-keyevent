
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

#pragma mark - iOS < 13.4 supports

- (NSArray *)keys {
   return @[
       @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"0",
       @"a", @"b", @"c", @"d", @"e", @"f", @"g", @"h", @"i", @"j", @"k", @"l", @"m", @"n", @"o", @"p", @"q", @"r", @"s", @"t", @"u", @"v", @"w", @"x", @"y", @"z",
       @"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z",
       @"!", @"~", @"\r", @"\t", @"\b", @"-", @"+", @"*", @"/", @"=", @",", @".",
       UIKeyInputLeftArrow,
       UIKeyInputRightArrow,
       UIKeyInputUpArrow,
       UIKeyInputDownArrow,
       UIKeyInputPageUp,
       UIKeyInputPageDown,
       UIKeyInputEscape,
   ];
}

- (NSMutableArray<UIKeyCommand *> *)keyCommands:(SEL)selector {
    NSMutableArray *commands = [NSMutableArray new];
    if (self.hasListeners) {
        NSArray *keys = [self keys];
        for (NSString* key in keys) {
            [commands addObject: [UIKeyCommand keyCommandWithInput:@"" modifierFlags:UIKeyModifierAlphaShift action:selector]];
            [commands addObject: [UIKeyCommand keyCommandWithInput:@"" modifierFlags:UIKeyModifierShift action:selector]];
            [commands addObject: [UIKeyCommand keyCommandWithInput:@"" modifierFlags:UIKeyModifierControl action:selector]];
            [commands addObject: [UIKeyCommand keyCommandWithInput:@"" modifierFlags:UIKeyModifierAlternate action:selector]];
            [commands addObject: [UIKeyCommand keyCommandWithInput:@"" modifierFlags:UIKeyModifierCommand action:selector]];
            [commands addObject: [UIKeyCommand keyCommandWithInput:@"" modifierFlags:UIKeyModifierNumericPad action:selector]];

            [commands addObject: [UIKeyCommand keyCommandWithInput:key modifierFlags:UIKeyModifierAlphaShift action:selector]];
            [commands addObject: [UIKeyCommand keyCommandWithInput:key modifierFlags:UIKeyModifierShift action:selector]];
            [commands addObject: [UIKeyCommand keyCommandWithInput:key modifierFlags:UIKeyModifierControl action:selector]];
            [commands addObject: [UIKeyCommand keyCommandWithInput:key modifierFlags:UIKeyModifierAlternate action:selector]];
            [commands addObject: [UIKeyCommand keyCommandWithInput:key modifierFlags:UIKeyModifierCommand action:selector]];
            [commands addObject: [UIKeyCommand keyCommandWithInput:key modifierFlags:UIKeyModifierNumericPad action:selector]];

            NSArray *modifiers = @[
                [NSNumber numberWithInt:UIKeyModifierAlphaShift],
                [NSNumber numberWithInt:UIKeyModifierShift],
                [NSNumber numberWithInt:UIKeyModifierControl],
                [NSNumber numberWithInt:UIKeyModifierAlternate],
                [NSNumber numberWithInt:UIKeyModifierCommand],
                [NSNumber numberWithInt:UIKeyModifierNumericPad]
            ];
            for (int i = 0; i < modifiers.count; i++) {
                [commands addObject: [UIKeyCommand keyCommandWithInput:key modifierFlags:[modifiers[i] intValue] action:selector]];
                NSInteger sum = [modifiers[i] intValue];
                for (int j = i + 1; j < modifiers.count; j++) {
                    NSInteger combination = [modifiers[i] intValue] + [modifiers[j] intValue];
                    sum += [modifiers[j] intValue];
                    if (combination != sum) {
                        [commands addObject: [UIKeyCommand keyCommandWithInput:key modifierFlags:sum action:selector]];
                    }
                    [commands addObject: [UIKeyCommand keyCommandWithInput:key modifierFlags:combination action:selector]];
                }
            }
            [commands addObject: [UIKeyCommand keyCommandWithInput:key modifierFlags:0 action:selector]];
        }
    }
    return commands;
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

