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
  const [upEvent, setUpEvent] = useState(null)

  useEffect(() => {
    const up = GlobalKeyEvent.addKeyUpListener((evt) => setUpEvent(evt))
    return () => up.remove()
  })

  return (
    <View style={styles.container}>
      <Text style={styles.title}>
        Listening key up...
      </Text>
      {upEvent && (
        <>
          <Text style={styles.text}>
            Key Code:
            {' '}
            {upEvent.keyCode}
          </Text>
          <Text style={styles.text}>
            Pressed Key:
            {' '}
            {upEvent.pressedKey}
          </Text>
          <Text style={styles.text}>
            Shift:
            {' '}
            {upEvent.flags?.shift ? 'YES' : 'NO'}
          </Text>
          <Text style={styles.text}>
            Alt:
            {' '}
            {upEvent.flags?.alt ? 'YES' : 'NO'}
          </Text>
          <Text style={styles.text}>
            Control:
            {' '}
            {upEvent.flags?.control ? 'YES' : 'NO'}
          </Text>
          <Text style={styles.text}>
            Meta:
            {' '}
            {upEvent.flags?.meta ? 'YES' : 'NO'}
          </Text>
          <Text style={styles.text}>
            Fn:
            {' '}
            {upEvent.flags?.fn ? 'YES' : 'NO'}
          </Text>
          <Text style={styles.text}>
            Caps Lock:
            {' '}
            {upEvent.flags?.capsLock ? 'YES' : 'NO'}
          </Text>
          <Text style={styles.text}>
            Numeric Pad:
            {' '}
            {upEvent.flags?.numericPad ? 'YES' : 'NO'}
          </Text>
        </>
      )}
    </View>
  )
}
