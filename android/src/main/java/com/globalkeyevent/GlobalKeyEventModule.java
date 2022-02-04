package com.globalkeyevent;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContext;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.modules.core.DeviceEventManagerModule;
import com.facebook.react.bridge.WritableNativeMap;
import com.facebook.react.bridge.WritableMap;

import android.view.KeyEvent;

public class GlobalKeyEventModule extends ReactContextBaseJavaModule {
    public static final String REACT_CLASS = "RNGlobalKeyEvent";
    private ReactContext mReactContext;
    private DeviceEventManagerModule.RCTDeviceEventEmitter mJSModule = null;

    private static GlobalKeyEventModule instance = null;

    public static GlobalKeyEventModule getInstance() {
        if (instance == null) throw new RuntimeException("GlobalKeyEventModule is not initialized");
        return instance;
    }

    protected GlobalKeyEventModule(ReactApplicationContext reactContext) {
        super(reactContext);
        mReactContext = reactContext;
        instance = this;
    }

    public void onKeyDownEvent(int keyCode, KeyEvent keyEvent) {
        if (!mReactContext.hasActiveCatalystInstance()) return;
        if (mJSModule == null) mJSModule = mReactContext.getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class);
        mJSModule.emit("@RNGlobalKeyEvnet_keyDown", getJsEventParams(keyCode, keyEvent, null));
    };

    public void onKeyUpEvent(int keyCode, KeyEvent keyEvent) {
        if (!mReactContext.hasActiveCatalystInstance()) return;
        if (mJSModule == null) mJSModule = mReactContext.getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class);
        mJSModule.emit("@RNGlobalKeyEvnet_keyUp", getJsEventParams(keyCode, keyEvent, null));
    };

    @ReactMethod
    public void addListener(String eventName) {
    }

    @ReactMethod
    public void removeListeners(Integer count) {
    }

    private WritableMap getJsEventParams(int keyCode, KeyEvent keyEvent, Integer repeatCount) {
        WritableMap params = new WritableNativeMap();
        params.putInt("keyCode", keyCode);

        char pressedKey = (char) keyEvent.getUnicodeChar();
        params.putString("pressedKey", String.valueOf(pressedKey));

        if (keyEvent.isShiftPressed()) params.putBoolean("shift", true);
        if (keyEvent.isAltPressed()) params.putBoolean("alt", true);
        if (keyEvent.isCapsLockOn()) params.putBoolean("capsLock", true);
        if (keyEvent.isCtrlPressed()) params.putBoolean("control", true);
        if (keyEvent.isFunctionPressed()) params.putBoolean("fn", true);
        if (keyEvent.isMetaPressed()) params.putBoolean("meta", true);
        return params;
    }

    @Override
    public String getName() {
        return REACT_CLASS;
    }
}
