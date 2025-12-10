import Quickshell
import Quickshell.Io
import QtQuick

import "../../../settings"
import "../../../widgets"
import "../../../services"


Grid {
  property int iconSize

  property var tm: TrayManager

  spacing: Theme.spacing.m

  columns: tm.itemsFilteredCount < 3 ? tm.itemsFilteredCount : 3 

  padding: Theme.spacing.s

  Repeater {
    model: tm.itemsFiltered

    delegate: Item {
      id: trayItem

      required property var modelData

      width: iconSize
      height: iconSize

      Image {
        anchors.fill: parent
        source: modelData.icon
      }

      QsMenuAnchor {
        id: menuAnchor
        menu: modelData.menu

        anchor.window: panel
        anchor.rect.width: trayItem.width
        anchor.rect.height: 0
      }

      MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        cursorShape: Qt.PointingHandCursor
        hoverEnabled: true

        onClicked: (mouse) => {
          if (mouse.button === Qt.LeftButton) {
            modelData.activate()
          } else if (mouse.button === Qt.RightButton) {
            var pos = trayItem.mapToGlobal(0, 0)

            menuAnchor.anchor.rect.x = pos.x
            menuAnchor.anchor.rect.y = pos.y + trayItem.height
            menuAnchor.open()
          }
        }
      }
    }
  }
}
