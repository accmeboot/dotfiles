import Quickshell
import QtQuick
import Quickshell.Widgets
import Quickshell.Wayland

import "../settings"
import "../widgets"

PanelWindow {
  required property int intendedWidth
  required property int intendedHeight

  color: "transparent"
  visible: false

  property int calculatedWidth: intendedWidth + (Theme.border.radius * 2)
  property int calculatedHeight: intendedHeight + (Theme.border.radius * 2)

  implicitWidth: calculatedWidth
  implicitHeight: calculatedHeight

  WlrLayershell.layer: WlrLayer.Top
  WlrLayershell.keyboardFocus: WlrKeyboardFocus.OnDemand

  WrapperItem {
    anchors.fill: parent

    Item {
      anchors.fill: parent

      InvertedCorner {
        position: "topLeft"
        anchors.left: corenrsBg.left
        anchors.top: corenrsBg.top
      }

      InvertedCorner {
        position: "topRight"
        anchors.right: corenrsBg.right
        anchors.top: corenrsBg.top
      }

      Rectangle {
        id: corenrsBg
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top

        implicitWidth: intendedWidth + Theme.border.radius * 2
        implicitHeight: intendedHeight

        color: "transparent"

        bottomLeftRadius: Theme.border.radius
        bottomRightRadius: Theme.border.radius
      }

      Rectangle {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top

        implicitWidth: intendedWidth
        implicitHeight: intendedHeight

        color: Theme.colors.base00

        bottomLeftRadius: Theme.border.radius
        bottomRightRadius: Theme.border.radius

        Shadow { id: shadow }
      }
    }
  }
}
