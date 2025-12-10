import QtQuick.Effects
import "../settings"

RectangularShadow {
  anchors.fill: parent

  color: "#1B1610"
  radius: Theme.border.radius
  blur: 5
  spread: 0.2
  offset: Qt.vector2d(0, 1)
  z: -1
}
