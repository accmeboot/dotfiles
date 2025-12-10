pragma Singleton
import QtQuick
import Quickshell.Bluetooth

QtObject {
  id: root

  property BluetoothAdapter adapter: Bluetooth.defaultAdapter
  property var devices: Bluetooth.devices.values

  property var currentDeviceName: {
    var device = devices.find((d) => d.connected)
    return device?.name ?? null
  }

  property bool isDeviceInUse: {
    return devices.some(device => {
      return device.connected
    })
  }
}
