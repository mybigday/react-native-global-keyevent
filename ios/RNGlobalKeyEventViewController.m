#import "RNGlobalKeyEventViewController.h"
#import "RNGlobalKeyEvent.h"

@implementation RNGlobalKeyEventViewController
- (void) pressesBegan:(NSSet<UIPress *> *)presses withEvent:(UIPressesEvent *)event {
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
}
- (void) pressesEnded:(NSSet<UIPress *> *)presses withEvent:(UIPressesEvent *)event {
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
  [keyEvent sendKeyUp:key.characters modifierFlags:key.modifierFlags];
}
@end
