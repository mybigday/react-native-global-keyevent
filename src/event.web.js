export const simulateKeyDown = ({ keyCode, pressedKey, flags }) =>
  document.dispatchEvent(new KeyboardEvent('keydown', { keyCode, pressedKey, flags }))

export const simulateKeyUp = ({ keyCode, pressedKey, flags }) =>
  document.dispatchEvent(new KeyboardEvent('keyup', { keyCode, pressedKey, flags }))

export const addKeyDownListener = (cb) => {
  const handler = (evt) => {
    const flags = evt.flags ? { ...evt.flags } : {}
    if (evt.altKey) flags.alt = true
    if (evt.ctrlKey) flags.ctrl = true
    if (evt.metaKey) flags.meta = true
    if (evt.shiftKey) flags.shift = true
    if (evt.getModifierState('CapsLock')) flags.capsLock = true
    return cb({ keyCode: evt.keyCode, pressedKey: evt.key, flags })
  }
  document.addEventListener('keydown', handler)
  return {
    remove: () => document.removeEventListener('keydown', handler),
  }
}

export const addKeyUpListener = (cb) => {
  const handler = (evt) => {
    const flags = evt.flags ? { ...evt.flags } : {}
    if (evt.altKey) flags.alt = true
    if (evt.ctrlKey) flags.ctrl = true
    if (evt.metaKey) flags.meta = true
    if (evt.shiftKey) flags.shift = true
    if (evt.getModifierState('CapsLock')) flags.capsLock = true
    return cb({ keyCode: evt.keyCode, pressedKey: evt.key, flags })
  }
  document.addEventListener('keyup', handler)
  return {
    remove: () => document.removeEventListener('keyup', handler),
  }
}
