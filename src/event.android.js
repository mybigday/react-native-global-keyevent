import {
  DeviceEventEmitter,
  NativeEventEmitter,
  NativeModules,
} from 'react-native'

const keyDown = '@RNGlobalKeyEvnet_keyDown'
const keyUp = '@RNGlobalKeyEvnet_keyUp'

export const simulateKeyDown = ({ keyCode, pressedKey, flags }) =>
  DeviceEventEmitter.emit(keyDown, {
    keyCode,
    pressedKey,
    flags,
  })

export const simulateKeyUp = ({ keyCode, pressedKey, flags }) =>
  DeviceEventEmitter.emit(keyUp, {
    keyCode,
    pressedKey,
    flags,
  })

const keyEvent = new NativeEventEmitter(NativeModules.RNGlobalKeyEvent)
export const addKeyDownListener = (cb) =>
  keyEvent.addListener(keyDown, (evt) => {
    const flags = evt.flags ? { ...evt.flags } : {}
    if (evt.shift) flags.shift = true
    if (evt.alt) flags.alt = true
    if (evt.control) flags.control = true
    if (evt.capsLock) flags.capsLock = true
    if (evt.fn) flags.fn = true
    if (evt.meta) flags.meta = true
    return cb({ ...evt, flags })
  })

export const addKeyUpListener = (cb) =>
  keyEvent.addListener(keyUp, (evt) => {
    const flags = evt.flags ? { ...evt.flags } : {}
    if (evt.shift) flags.shift = true
    if (evt.alt) flags.alt = true
    if (evt.control) flags.control = true
    if (evt.capsLock) flags.capsLock = true
    if (evt.fn) flags.fn = true
    if (evt.meta) flags.meta = true
    return cb({ ...evt, flags })
  })
