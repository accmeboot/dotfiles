import QtQuick
import Quickshell
import QtQuick
import Quickshell.Bluetooth

import "../../../settings"
import "../../../widgets"
import "../../../services"

Container {
  property int iconSize: Theme.spacing.xxl

  property BluetoothManager bm: BluetoothManager
  property ProcessManager pm: ProcessManager {}

  Item {
    implicitWidth: row.implicitWidth
    implicitHeight: row.height

    opacity: mouseArea.containsMouse ? 0.7 : 1.0

    Row {
      id: row
      spacing: Theme.spacing.s

      ColoredIcon {
        anchors.verticalCenter: parent.verticalCenter
        icon: {
          if (bm.isDeviceInUse) return "bluetooth-connected.svg"
          
          switch(bm.adapter?.state) {
            case BluetoothAdapterState.Enabled: return "bluetooth-on.svg"
            default: return "bluetooth-off.svg"
          }
        }
        color: Theme.colors.base0C
        size: iconSize
      }

      Text {
        anchors.verticalCenter: parent.verticalCenter
        color: Theme.colors.base05
        font.bold: true
        text: bm.currentDeviceName ?? bm.adapter?.name ?? ""
      }
    }

    MouseArea {
      id: mouseArea
      anchors.fill: parent
      hoverEnabled: true
      cursorShape: Qt.PointingHandCursor

      onClicked: {
        pm.execute("blueman-manager")
      }
    }
  }
}
