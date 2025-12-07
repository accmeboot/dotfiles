import QtQuick
import Quickshell
import Quickshell.Io

import "../../../settings"
import "../../../services"
import "../../../widgets"

Container {
  paddingVertical: Theme.icons.m - Theme.spacing.xs - Theme.spacing.xxs

  Row {
    spacing: Theme.spacing.s

    Repeater {
      model: NiriManager.workspaces

      delegate: Rectangle {
        required property var modelData

        width: modelData.is_active ? Theme.icons.xxl : Theme.icons.m
        height: Theme.icons.m
        radius: Theme.icons.m * 2

        color: modelData.is_active ? Theme.colors.base0D : Theme.colors.base05

        opacity: {
          if (mouseArea.containsMouse && !modelData.is_active) return 0.75

          return 1.0
        }

        MouseArea {
          id: mouseArea
          anchors.fill: parent
          cursorShape: Qt.PointingHandCursor
          hoverEnabled: true
          
          onClicked: {
            NiriManager.switchToWorkspace(modelData.idx)
          }
        }
      }
    }
  }
}
