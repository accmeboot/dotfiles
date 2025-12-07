import QtQuick
import Quickshell
import QtQuick

import "../../../settings"
import "../../../widgets"

Container {
  property int iconSize: Theme.spacing.xxl

  Item {
    implicitWidth: row.implicitWidth
    implicitHeight: row.height

    Row {
      id: row
      spacing: Theme.spacing.s

      ColoredIcon {
        anchors.verticalCenter: parent.verticalCenter
        icon: "calendar.svg"
        color: Theme.colors.base0E
        size: iconSize
      }

      Text {
        anchors.verticalCenter: parent.verticalCenter

        property string time: {
          Qt.formatDateTime(clock.date, "dddd hh:mm")
        }

        color: Theme.colors.base05
        font.bold: true
        text: time


        SystemClock {
          id: clock
          precision: SystemClock.Minutes
        }
      }
    }
  }

}
