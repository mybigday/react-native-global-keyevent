import {
  DeviceEventEmitter,
  NativeEventEmitter,
  NativeModules,
} from 'react-native'

const keyDown = '@RNGlobalKeyEvnet_keyDown'
const keyUp = '@RNGlobalKeyEvnet_keyUp'

export const simulateKeyDown = ({ pressedKey, flags }) =>
  DeviceEventEmitter.emit(keyDown, {
    pressedKey,
    flags,
  })

export const simulateKeyUp = ({ pressedKey, flags }) =>
  DeviceEventEmitter.emit(keyUp, {
    pressedKey,
    flags,
  })

const modifierFlagsMap = {
  numericPad: 2097152,
  meta: 1048576, // command
  alt: 524288,
  control: 262144,
  shift: 131072,
  capsLock: 65536,
}

const modifierOriginFlagsMap = {
  capsLock: 'UIKeyModifierAlphaShift',
  shift: 'UIKeyModifierShift',
  control: 'UIKeyModifierControl',
  alt: 'UIKeyModifierAlternate',
  meta: 'UIKeyModifierCommand',
  numericPad: 'UIKeyModifierNumericPad',
}

const keyEvent = new NativeEventEmitter(NativeModules.RNGlobalKeyEvent)
export const addKeyDownListener = (cb) =>
  keyEvent.addListener(keyDown, (evt) => {
    const { modifierFlags } = evt
    let { pressedKey } = evt
    const flags = evt.flags
      ? { ...evt.flags }
      : Object.keys(modifierFlagsMap).reduce((acc, key) => {
          // eslint-disable-next-line no-bitwise
          if (!(modifierFlags & modifierFlagsMap[key])) return acc
          if (pressedKey?.length === 0) {
            pressedKey = modifierOriginFlagsMap[key]
          } else {
            acc[key] = true
          }
          return acc
        }, {})
    return cb({
      ...evt,
      pressedKey,
      flags,
    })
  })

export const addKeyUpListener = (cb) =>
  keyEvent.addListener(keyUp, (evt) => {
    const { modifierFlags } = evt
    let { pressedKey } = evt
    const flags = evt.flags
      ? { ...evt.flags }
      : Object.keys(modifierFlagsMap).reduce((acc, key) => {
          // eslint-disable-next-line no-bitwise
          if (!(modifierFlags & modifierFlagsMap[key])) return acc
          if (pressedKey?.length === 0) {
            pressedKey = modifierOriginFlagsMap[key]
          } else {
            acc[key] = true
          }
          return acc
        }, {})
    return cb({
      ...evt,
      pressedKey,
      flags,
    })
  })
