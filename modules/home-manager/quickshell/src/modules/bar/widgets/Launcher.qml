import QtQuick
import Quickshell

import "../../../settings"
import "../../../services"
import "../../../components"

Rectangle {
  property ProcessManager pm: ProcessManager {}
  property int iconSize: Theme.spacing.xxl

  width: iconSize 
  height: iconSize 

  color: "transparent"

  opacity: mouseArea.containsMouse ? 0.7 : 1.0

  ColoredIcon {
    anchors.centerIn: parent

    icon: "launcher"
    color: Theme.colors.base05
    size: iconSize
  }

  MouseArea {
    id: mouseArea
    anchors.fill: parent
    hoverEnabled: true
    cursorShape: Qt.PointingHandCursor

    onClicked: {
      launcherWindow.visible = !launcherWindow.visible
    }
  }
}
