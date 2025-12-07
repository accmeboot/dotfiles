import QtQuick

import "../../../settings"
import "../../../widgets"

Container {
  property int size: Theme.spacing.xxl
  property int popupOffset: Theme.spacing.s

  Item {
    implicitWidth: size
    implicitHeight: size

    opacity: mouseArea.containsMouse ? 0.7 : 1.0

    Image {
      anchors.centerIn: parent
      source: "../../../assets/bluetooth-on.svg"

      width: parent.width
      height: parent.height 

      sourceSize: Qt.size(parent.width, parent.height)
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
}
