import QtQuick

import "../../../settings"
import "../../../widgets"
import "../../../services"

Container {
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
        icon: {
          if (nm.isConnected) {
            return "ethernet.svg"
          }

          return "ethernet-disconnected.svg"
        } 
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
        ProcessManager.execute("nm-connection-editor")
      }
    }
  }
}
