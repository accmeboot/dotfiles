import Quickshell
import QtQuick
import Quickshell.Widgets

import "../settings"
import "../widgets"

PopupWindow {
  required property int intendedWidth
  required property int intendedHeight

  color: "transparent"
  visible: false

  property int calculatedWidth: intendedWidth + (Theme.border.radius * 2) + Theme.spacing.s + shadow.blur
  property int calculatedHeight: intendedHeight + (Theme.border.radius * 2) + Theme.spacing.s + shadow.blur

  implicitWidth: calculatedWidth
  implicitHeight: calculatedHeight

  WrapperItem {
    anchors.fill: parent

    Item {
      anchors.fill: parent

      InvertedCorner { position: "topLeft"}
      InvertedCorner { position: "topRight"}

      Rectangle {
        id: bgContainer
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top

        color: Theme.colors.base00

        implicitWidth: calculatedWidth - Theme.border.radius * 2
        implicitHeight: calculatedHeight - shadow.blur

        bottomLeftRadius: Theme.border.radius
        bottomRightRadius: Theme.border.radius

        Shadow { id: shadow }
      }

      Rectangle {
        anchors.centerIn: bgContainer

        color: Theme.colors.base01

        implicitWidth: intendedWidth
        implicitHeight: intendedHeight

        radius: Theme.border.radius
      }
    }
  }
}
