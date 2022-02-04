import React, { useState, useEffect } from 'react'
import { StyleSheet, Text, View } from 'react-native'
// eslint-disable-next-line import/no-unresolved
import GlobalKeyEvent from 'react-native-global-keyevent'

const styles = StyleSheet.create({
  container: {
    backgroundColor: 'white',
    flex: 1,
    justifyContent: 'center',
    alignContent: 'center',
  },
  title: {
    fontSize: 20,
    textAlign: 'center',
    marginBottom: 16,
  },
  text: { textAlign: 'center' },
})

export default function App() {
  const [downEvent, setDownEvent] = useState(null)

  useEffect(() => {
    const down = GlobalKeyEvent.addKeyDownListener((evt) => setDownEvent(evt))
    return () => down.remove()
  })

  return (
    <View style={styles.container}>
      <Text style={styles.title}>
        Listening key down...
      </Text>
      {downEvent && (
        <>
          <Text style={styles.text}>
            Key Code:
            {' '}
            {downEvent.keyCode}
          </Text>
          <Text style={styles.text}>
            Pressed Key:
            {' '}
            {downEvent.pressedKey}
          </Text>
          <Text style={styles.text}>
            Shift:
            {' '}
            {downEvent.flags?.shift ? 'YES' : 'NO'}
          </Text>
          <Text style={styles.text}>
            Alt:
            {' '}
            {downEvent.flags?.alt ? 'YES' : 'NO'}
          </Text>
          <Text style={styles.text}>
            Control:
            {' '}
            {downEvent.flags?.control ? 'YES' : 'NO'}
          </Text>
          <Text style={styles.text}>
            Meta:
            {' '}
            {downEvent.flags?.meta ? 'YES' : 'NO'}
          </Text>
          <Text style={styles.text}>
            Fn:
            {' '}
            {downEvent.flags?.fn ? 'YES' : 'NO'}
          </Text>
          <Text style={styles.text}>
            Caps Lock:
            {' '}
            {downEvent.flags?.capsLock ? 'YES' : 'NO'}
          </Text>
          <Text style={styles.text}>
            Numeric Pad:
            {' '}
            {downEvent.flags?.numericPad ? 'YES' : 'NO'}
          </Text>
        </>
      )}
    </View>
  )
}
