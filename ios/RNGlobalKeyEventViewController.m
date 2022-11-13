#import "RNGlobalKeyEventViewController.h"
#import "RNGlobalKeyEvent.h"

@implementation RNGlobalKeyEventViewController

- (void) pressesBegan:(NSSet<UIPress *> *)presses withEvent:(UIPressesEvent *)event {
  if (@available(iOS 13.4, tvOS 13.4, *)) {
  } else {
    [super pressesBegan:presses withEvent: event];
    return;
  }
  RNGlobalKeyEvent *keyEvent = [RNGlobalKeyEvent getSingletonInstance];
  if (keyEvent == nil || ![keyEvent isListening]) {
    [super pressesBegan:presses withEvent: event];
    return;
  }

  UIPress *press = [presses anyObject];
  if (press == nil) {
    [super pressesBegan:presses withEvent: event];
    return;
  }
  UIKey *key = press.key;
  [keyEvent sendKeyDown:key.characters modifierFlags:key.modifierFlags];

  [super pressesBegan:presses withEvent: event];
}

- (void) pressesEnded:(NSSet<UIPress *> *)presses withEvent:(UIPressesEvent *)event {
  if (@available(iOS 13.4, tvOS 13.4, *)) {
  } else {
    [super pressesEnded:presses withEvent: event];
    return;
  }
  RNGlobalKeyEvent *keyEvent = [RNGlobalKeyEvent getSingletonInstance];
  if (keyEvent == nil || ![keyEvent isListening]) {
    [super pressesEnded:presses withEvent: event];
    return;
  }

  UIPress *press = [presses anyObject];
  if (press == nil) {
    [super pressesEnded:presses withEvent: event];
    return;
  }
  UIKey *key = press.key;
  [keyEvent sendKeyUp:key.characters modifierFlags:key.modifierFlags];

  [super pressesEnded:presses withEvent: event];
}

#pragma mark - iOS < 13.4 supports

- (NSMutableArray<UIKeyCommand *> *)keyCommands {
  if (@available(iOS 13.4, tvOS 13.4, *)) {
    return @[];
  }
  RNGlobalKeyEvent *keyEvent = [RNGlobalKeyEvent getSingletonInstance];
  return [keyEvent keyCommands:@selector(rnGlobalKeyInput:)];
}

- (void)rnGlobalKeyInput:(UIKeyCommand *)sender {
  RNGlobalKeyEvent *keyEvent = [RNGlobalKeyEvent getSingletonInstance];
  NSString *selected = sender.input;
  [keyEvent sendKeyUp:selected modifierFlags:sender.modifierFlags];
}

@end
