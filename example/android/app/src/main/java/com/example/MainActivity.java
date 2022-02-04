package com.example;

import com.facebook.react.ReactActivity;
import android.view.KeyEvent;
import com.globalkeyevent.GlobalKeyEventModule;

public class MainActivity extends ReactActivity {

  /**
   * Returns the name of the main component registered from JavaScript. This is used to schedule
   * rendering of the component.
   */
  @Override
  protected String getMainComponentName() {
    return "example";
  }

  @Override
  public boolean onKeyDown(int keyCode, KeyEvent event) {
    GlobalKeyEventModule instance = GlobalKeyEventModule.getInstance();
    if (instance != null) instance.onKeyDownEvent(keyCode, event);
    return super.onKeyDown(keyCode, event);
  }

  @Override
  public boolean onKeyUp(int keyCode, KeyEvent event) {
    GlobalKeyEventModule instance = GlobalKeyEventModule.getInstance();
    if (instance != null) instance.onKeyUpEvent(keyCode, event);
    return super.onKeyUp(keyCode, event);
  }
}
