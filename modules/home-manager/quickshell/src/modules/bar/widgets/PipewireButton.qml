import QtQuick

import "../../../settings"
import "../../../widgets"
import "../../../services"

Container {
  property int iconSize: Theme.spacing.xxl
  property int popupOffset: Theme.spacing.s

  property QtObject pm: PipewireManager

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
          if (pm.isMuted || pm.volume === 0) return "volume-muted.svg"

          if (pm.volume <= 30) return "volume-low.svg"

          if (pm.volume <= 60) return "volume-half.svg"

          return "volume-full.svg"
        } 
        color: Theme.colors.base05
        size: iconSize
      }

      Text {
        anchors.verticalCenter: parent.verticalCenter
        text: pm.deviceName
        color: Theme.colors.base04
        font.bold: true
      }
    }


    MouseArea {
      id: mouseArea
      anchors.fill: parent
      hoverEnabled: true
      cursorShape: Qt.PointingHandCursor

      onEntered: {
        var pos = mapToItem(null, 0, 0)
        var barRect = itemRect(barContainer)

        var buttonWidth = row.width
        var popupWidth = pipewirePopup.width
        var centeredX = pos.x + (buttonWidth / 2) - (popupWidth / 2)
        
        pipewirePopup.anchor.rect.x = centeredX
        pipewirePopup.anchor.rect.y = barRect.height - Theme.border.radius

        pipewirePopup.visible = !pipewirePopup.visible
      }
    }
  }
}
