import QtQuick

import "../../../settings"
import "../../../widgets"
import "../../../services"

Container {
  property ProcessManager pm: ProcessManager {}

  property int iconSize: Theme.spacing.xxl
  property int popupOffset: Theme.spacing.s

  property QtObject nm: NetworkManager

  Item {
    implicitWidth: row.implicitWidth
    implicitHeight: row.height

    opacity: mouseArea.containsMouse ? 0.7 : 1.0

    Row {
      id: row
      spacing: Theme.spacing.s

      ColoredIcon {
        anchors.verticalCenter: parent.verticalCenter
        icon: getIcon() 
        color: Theme.colors.base0D
        size: iconSize
      }

      Text {
        anchors.verticalCenter: parent.verticalCenter
        text: nm.isConnected ? nm.connectionName : "Disconnected"
        color: Theme.colors.base05
        font.bold: true
      }
    }


    MouseArea {
      id: mouseArea
      anchors.fill: parent
      hoverEnabled: true
      cursorShape: Qt.PointingHandCursor

      onClicked: {
        pm.execute("nm-connection-editor")
      }
    }
  }

  function getIcon() {
    switch (nm.connectionType) {
      case "wifi": return getWifiIcon()
      default: return getEthernetIcon()
    }
  }

  function getWifiIcon() {
    if (!nm.isConnected) return "wifi-disconnected.svg"

    switch (true) {
      case nm.signalStrength >= 75: return "wifi-100.svg"
      case nm.signalStrength >= 50: return "wifi-75.svg"
      case nm.signalStrength >= 25: return "wifi-50.svg"

      default: return "wifi-25.svg"
    }
  }

  function getEthernetIcon() {
    return nm.isConnected ? "ethernet.svg" : "ethernet-disconnected.svg"
  }
}
