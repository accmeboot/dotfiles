import Quickshell
import Quickshell.Io
import Quickshell.Services.SystemTray
import QtQuick

import "../../../settings"
import "../../../widgets"


Grid {
  property int iconSize
  property var hiddenTrayItems: [ "Network", "jamesdsp" ]

  spacing: Theme.spacing.m
  columns: 3

  padding: Theme.spacing.s

  Repeater {
    model: SystemTray.items

    delegate: Item {
      id: trayItem
      required property SystemTrayItem modelData

      width: iconSize
      height: iconSize


      visible: !hiddenTrayItems.includes(modelData.title)

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
            var pos = trayItem.mapToGlobal(null, 0, 0)

            menuAnchor.anchor.rect.x = pos.x
            menuAnchor.anchor.rect.y = pos.y + trayItem.height
            menuAnchor.open()
          }
        }
      }
    }
  }
}
