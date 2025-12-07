import Quickshell
import QtQuick

import "../../../settings"
import "../widgets"

PopupWindow {
  anchor {
    window: panel
  }

  implicitWidth: tray.width
  implicitHeight: tray.height

  color: "transparent"
  visible: false

  Rectangle {
    anchors.fill: parent
    color: Theme.colors.base01
    radius: Theme.border.radius

    SystemTray {
      id: tray
      iconSize: 24
    }
  }
}
