[![CI Status](https://github.com/mybigday/react-native-global-keyevent/workflows/CI/badge.svg)](https://github.com/mybigday/react-native-global-keyevent)

> React Native module for listen global key event

## Introdution

```js
import GlobalKeyEvent from 'react-native-global-keyevent'

GlobalKeyEvent.addKeyDownListener((evt) => {
  console.log('---key down---')
  console.log('code:', evt.keyCode)
  console.log('key:', evt.pressedKey)
  console.log('flag shift:', evt.shift)
})
GlobalKeyEvent.addKeyUpListener((evt) => {
  console.log('---key up---')
  console.log('code:', evt.keyCode)
  console.log('key:', evt.pressedKey)
  console.log('flag shift:', evt.shift)
})
```

[Example](example/App.js)

## Installation

- Add dependency with `yarn add react-native-global-keyevent`
- You may need to run `react-native link react-native-global-keyevent` or autolinking.

### iOS

This module required to replace root view controller:

```patch
--- AppDelegate.m	2022-02-03 09:01:32.000000000 +0800
+++ AppDelegate.m	2022-02-03 09:01:32.000000000 +0800
@@ -3,6 +3,7 @@
 #import <React/RCTBridge.h>
 #import <React/RCTBundleURLProvider.h>
 #import <React/RCTRootView.h>
+#import "RNGlobalKeyEventViewController.h"
 
 #ifdef FB_SONARKIT_ENABLED
 #import <FlipperKit/FlipperClient.h>
@@ -43,7 +44,7 @@
   }
 
   self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
-  UIViewController *rootViewController = [UIViewController new];
+  UIViewController *rootViewController = [RNGlobalKeyEventViewController new];
   rootViewController.view = rootView;
   self.window.rootViewController = rootViewController;
   [self.window makeKeyAndVisible];
```

If you have own custom root view controller, you can follow [`ios/RNGlobalKeyEventViewController.m`](ios/RNGlobalKeyEventViewController.m).

### Android

This module required to listen key event on MainActivity:

```patch
--- MainActivity.java 2022-02-03 09:01:32.000000000 +0800
+++ MainActivity.java 2022-02-03 09:01:32.000000000 +0800
@@ -1,6 +1,8 @@
 package com.example;
 
 import com.facebook.react.ReactActivity;
+import android.view.KeyEvent;
+import com.globalkeyevent.GlobalKeyEventModule;
 
 public class MainActivity extends ReactActivity {
 
@@ -12,4 +14,18 @@
   protected String getMainComponentName() {
     return "example";
   }
+
+  @Override
+  public boolean onKeyDown(int keyCode, KeyEvent event) {
+    GlobalKeyEventModule instance = GlobalKeyEventModule.getInstance();
+    if (instance != null) instance.onKeyDownEvent(keyCode, event);
+    return super.onKeyDown(keyCode, event);
+  }
+
+  @Override
+  public boolean onKeyUp(int keyCode, KeyEvent event) {
+    GlobalKeyEventModule instance = GlobalKeyEventModule.getInstance();
+    if (instance != null) instance.onKeyUpEvent(keyCode, event);
+    return super.onKeyUp(keyCode, event);
+  }
 }
```

## Usage

- `GlobalKeyEvent.addKeyDownListener((event: GlobalKeyEvent) => {}): EmitterSubscription`
- `GlobalKeyEvent.addKeyUpListener((event: GlobalKeyEvent) => {}): EmitterSubscription`
- [EmitterSubscription reference](https://github.com/facebook/react-native/blob/8bd3edec88148d0ab1f225d2119435681fbbba33/Libraries/vendor/emitter/_EmitterSubscription.js)

```flow
type GlobalKeyEvent = {
  pressedKey: string,
  keyCode: number,
  shift: boolean,
  control: boolean,
  alt: boolean,
  meta: boolean,
  capsLock: boolean,
  numericPad: boolean,
}
```

#### `GlobalKeyEvent`

| Prop          | Type        | Note                                 |
| ------------- | ------------| ------------------------------------ |
| `pressedKey`  | `String`    | Pressed key |
| `keyCode`     | `Number`    | [Not supported on iOS] Key code |
| `shift`       | `Boolean`   | Is `Shift` key hold? |
| `control`     | `Boolean`   | Is `Ctrl` (iOS: `Control`) key hold? |
| `alt`         | `Boolean`   | Is `Alt` (iOS: `Option`) key hold?  |
| `meta`        | `Boolean`   | Is `META` (iOS: `Command`) key hold? |
| `capsLock`    | `Boolean`   | Is `Caps Lock` enabled? |
| `fn`          | `Boolean`   | [Android only] Is `Fn` key hold? |
| `numericPad`  | `Boolean`   | [iOS only] Is user pressed a key located on the numeric keypad? |

## Credits

- [`react-native-keyevent`](https://github.com/kevinejohn/react-native-keyevent) used to be our solution before this.

## License

[MIT](LICENSE.md)

---

<p align="center">
  <a href="https://bricks.tools">
    <img width="90px" src="https://avatars.githubusercontent.com/u/17320237?s=200&v=4">
  </a>
  <p align="center">
    Built and maintained by <a href="https://bricks.tools">BRICKS</a>.
  </p>
</p>
