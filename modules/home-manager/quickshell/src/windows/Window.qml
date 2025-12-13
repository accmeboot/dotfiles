import Quickshell
import QtQuick
import Quickshell.Widgets

import "../settings"
import "../components"

PanelWindow {
  id: root

  required property int intendedWidth
  required property int intendedHeight

  property string position: "top" // left, right, bottom

  color: "transparent"
  visible: false

  property int calculatedWidth: {
    switch (position) {
      case "top":
      case "bottom":
        return intendedWidth + (Theme.border.radius * 2)
      default: return intendedWidth + shadow.blur
    }
  } 

  property int calculatedHeight: {
    switch (position) {
      case "left":
      case "right":
        return intendedHeight + (Theme.border.radius * 2)
      default: return intendedHeight + shadow.blur
    }
  }

  implicitWidth: calculatedWidth
  implicitHeight: calculatedHeight

  anchors {
    top: position === "top"
    left: position === "left"
    right: position === "right"
    bottom: position === "bottom"
  }

  WrapperItem {
    anchors.fill: parent

    Item {
      anchors.fill: parent

      InvertedCorner {
        position: {
          switch (root.position) {
            case "top": return "topLeft"
            case "bottom": return "bottomLeft"
            case "left": return "topLeft"

            default: return "topRight"
          }
        }
        orientation: {
          switch (root.position) {
            case "top":
            case "bottom":
              return "horizontal"
            default: return "vertical"
          }
        }
      }

      InvertedCorner {
        position: {
          switch (root.position) {
            case "top": return "topRight"
            case "bottom": return "bottomRight"
            case "left": return "bottomLeft"

            default: return "bottomRight"
          }
        }
        orientation: {
          switch (root.position) {
            case "top":
            case "bottom":
              return "horizontal"
            default: return "vertical"
          }
        }
      }

      Rectangle {
        id: corenrsBg

        anchors.horizontalCenter: {
          switch (root.position) {
            case "left":
            case "right":
              return undefined
            default: return parent.horizontalCenter
          }
        }
        anchors.verticalCenter: {
          switch (root.position) {
            case "top":
            case "bottom":
              return undefined
            default: return  parent.verticalCenter
          }
        }

        implicitWidth: calculatedWidth
        implicitHeight: calculatedHeight

        color: "transparent"

        topLeftRadius: {
          switch (position) {
            case "right":
            case "bottom":
              return Theme.border.radius
            default: return 0
          }
        }
        topRightRadius: {
          switch (position) {
            case "left":
            case "bottom":
              return Theme.border.radius
            default: return 0
          }
        }
        bottomLeftRadius: {
          switch (position) {
            case "top":
            case "right":
              return Theme.border.radius
            default: return 0
          }
        }
        bottomRightRadius: {
          switch (position) {
            case "top":
            case "left":
              return Theme.border.radius
            default: return 0
          }
        }
      }

      Rectangle {
        anchors.horizontalCenter: {
          switch (root.position) {
            case "left":
            case "right":
              return undefined
            default: return parent.horizontalCenter
          }
        }
        anchors.verticalCenter: {
          switch (root.position) {
            case "top":
            case "bottom":
              return undefined
            default: return parent.verticalCenter
          }
        }

        anchors.right: {
          switch (root.position) {
            case "top":
            case "bottom":
            case "left":
              return undefined
            default: return parent.right
          }
        }

        implicitWidth: intendedWidth
        implicitHeight: intendedHeight

        color: Theme.colors.base00

        topLeftRadius: {
          switch (position) {
            case "right":
            case "bottom":
              return Theme.border.radius
            default: return 0
          }
        }
        topRightRadius: {
          switch (position) {
            case "left":
            case "bottom":
              return Theme.border.radius
            default: return 0
          }
        }
        bottomLeftRadius: {
          switch (position) {
            case "top":
            case "right":
              return Theme.border.radius
            default: return 0
          }
        }
        bottomRightRadius: {
          switch (position) {
            case "top":
            case "left":
              return Theme.border.radius
            default: return 0
          }
        }

        Shadow { id: shadow }
      }
    }
  }
}
