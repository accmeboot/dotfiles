import QtQuick

import "../../../settings"
import "../../../components"
import "../../../services"

Item {
  property int iconSize: Theme.spacing.xxl
  property int popupOffset: Theme.spacing.s

  property int isEmpty: TrayManager.itemsFilteredCount <= 0

  implicitWidth: iconSize
  implicitHeight: iconSize

  opacity: mouseArea.containsMouse ? 0.7 : 1.0

  ColoredIcon {
    icon: isEmpty ? "tray-empty.svg" :  "tray.svg"
    color: Theme.colors.base05
    size: iconSize
  }

  MouseArea {
    id: mouseArea
    anchors.fill: parent
    hoverEnabled: true
    cursorShape: Qt.PointingHandCursor
    visible: !isEmpty

    onClicked: {
      var pos = mapToItem(null, 0, 0)

      trayPopup.anchor.rect.x = pos.x
      trayPopup.anchor.rect.y = pos.y + height + popupOffset

      trayPopup.visible = !trayPopup.visible
    }
  }
}
