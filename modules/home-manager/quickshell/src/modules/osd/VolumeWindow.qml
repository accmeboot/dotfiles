import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import QtQuick.Layouts

import "../../settings"
import "../../services"
import "../../components"
import "../../windows"

Window {
  id: root

  intendedWidth: content.implicitWidth
  intendedHeight: content.implicitHeight

  position: "right"

  visible: false

  exclusionMode: ExclusionMode.Normal

  Item {
    id: content

    implicitWidth: column.implicitWidth
    implicitHeight: 200

    Rectangle {
      color: Theme.colors.base0F
    }

    Column {
      id: column
      padding: Theme.spacing.s
      anchors.horizontalCenter: parent.horizontalCenter
      ColoredIcon {
        anchors.horizontalCenter: parent.horizontalCenter
        size: Theme.icons.l
        icon: "volume-full"
      }
    }
  }
}
