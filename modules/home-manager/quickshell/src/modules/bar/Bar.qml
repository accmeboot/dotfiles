import Quickshell
import Quickshell.Io
import Quickshell.Services.SystemTray
import QtQuick
import QtQuick.Layouts
import QtQuick.Effects

import "./widgets"
import "./popups"
import "../../settings"

Scope {
  Variants {
    model: Quickshell.screens

    PanelWindow {
      id: panel
      required property var modelData

      property int cornerRadius: Theme.border.radius
      property int paddingHorizontal: Theme.spacing.s
      property int paddingVertical: Theme.spacing.l

      property int iconSize: Theme.icons.l

      screen: modelData
      color: "transparent"

      anchors {
        top: true
        left: true
        right: true
      }

      implicitHeight: iconSize + paddingVertical + cornerRadius
      exclusiveZone: iconSize + paddingVertical

      Item {
        id: barContainer
        anchors.fill: parent

        RectangularShadow {
          anchors.fill: parent
          anchors.bottomMargin: cornerRadius

          color: "#1B1610"
          radius: 0
          blur: 5
          spread: 0.2
          offset: Qt.vector2d(0, 1)
          z: -1
        }

        // Main bar background
        Rectangle {
          id: barBackground
          anchors.fill: parent
          anchors.bottomMargin: cornerRadius
          color: Theme.colors.base00
        }

        // Left inverted corner (concave curve at inner angle)
        Canvas {
          anchors.left: parent.left
          anchors.bottom: parent.bottom
          width: cornerRadius
          height: cornerRadius

          onPaint: {
            var ctx = getContext("2d")
            ctx.fillStyle = "#212121"
            ctx.beginPath()
            ctx.moveTo(0, 0)
            ctx.lineTo(width, 0)
            ctx.quadraticCurveTo(0, 0, 0, height)
            ctx.closePath()
            ctx.fill()
          }
        }

        // Right inverted corner (concave curve at inner angle)
        Canvas {
          anchors.right: parent.right
          anchors.bottom: parent.bottom
          width: cornerRadius
          height: cornerRadius

          onPaint: {
            var ctx = getContext("2d")
            ctx.fillStyle = "#212121"
            ctx.beginPath()
            ctx.moveTo(width, 0)
            ctx.lineTo(0, 0)
            ctx.quadraticCurveTo(width, 0, width, height)
            ctx.closePath()
            ctx.fill()
          }
        }

        RowLayout {
          anchors.left: barBackground.left
          anchors.right: barBackground.right
          anchors.verticalCenter: barBackground.verticalCenter

          anchors.rightMargin: paddingHorizontal
          anchors.leftMargin: paddingHorizontal
          anchors.topMargin: paddingVertical
          anchors.bottomMargin: paddingVertical

          spacing: Theme.spacing.m
          Launcher { iconSize: panel.iconSize }
          Workspaces {}

          Window { iconSize: panel.iconSize }

          Item { Layout.fillWidth: true }

          PipewireButton { iconSize: panel.iconSize }
          NetworkButton { iconSize: panel.iconSize }
          ClockWidget { iconSize: panel.iconSize }

          TrayButton { iconSize: panel.iconSize }
        }
      }

      TrayPopup {
        id: trayPopup
      }
      PipewirePopup {
        id: pipewirePopup
      }
    }
  }
}
