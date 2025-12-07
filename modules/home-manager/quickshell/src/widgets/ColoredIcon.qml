import QtQuick
import Qt5Compat.GraphicalEffects

import "../settings"

Item {
  property string icon: ""
  property color color: Theme.colors.base05
  property int size: 24

  width: size
  height: size

  Image {
    id: img
    anchors.fill: parent
    source: "../assets/" + icon
    sourceSize: Qt.size(size, size)
    visible: false
  }

  ColorOverlay {
    anchors.fill: parent
    source: img
    color: parent.color
  }
}
