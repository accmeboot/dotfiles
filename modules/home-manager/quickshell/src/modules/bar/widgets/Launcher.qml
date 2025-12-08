import QtQuick

import "../../../settings"
import "../../../services"
import "../../../widgets"

Rectangle {
  property int iconSize: Theme.spacing.xxl

  width: iconSize 
  height: iconSize 

  color: "transparent"

  opacity: mouseArea.containsMouse ? 0.7 : 1.0

  ColoredIcon {
    anchors.centerIn: parent

    icon: "launcher"
    color: Theme.colors.base05
    size: iconSize // need to use id because withing coloredicons scoupe size referes to local value
  }

  MouseArea {
    id: mouseArea
    anchors.fill: parent
    hoverEnabled: true
    cursorShape: Qt.PointingHandCursor

    onClicked: {
      ProcessManager.execute(["rofi", "-show", "menu"])
    }
  }
}
