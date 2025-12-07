import QtQuick

import "../../../settings"
import "../../../widgets"

Item {
  property int iconSize: Theme.spacing.xxl
  property int popupOffset: Theme.spacing.s

  implicitWidth: iconSize
  implicitHeight: iconSize

  opacity: mouseArea.containsMouse ? 0.7 : 1.0

  ColoredIcon {
    icon: "tray.svg"
    color: Theme.colors.base0A
    size: iconSize
  }

  MouseArea {
    id: mouseArea
    anchors.fill: parent
    hoverEnabled: true
    cursorShape: Qt.PointingHandCursor

    onClicked: {
      var pos = mapToItem(null, 0, 0)

      trayPopup.anchor.rect.x = pos.x
      trayPopup.anchor.rect.y = pos.y + height + popupOffset

      trayPopup.visible = !trayPopup.visible
    }
  }
}
