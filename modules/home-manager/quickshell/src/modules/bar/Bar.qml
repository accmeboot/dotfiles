import Quickshell
import QtQuick
import QtQuick.Layouts

import "../../settings"
import "../../components"

import "./widgets"
import "./popups"

PanelWindow {
  id: panel
  screen: modelData
  color: "transparent"
  implicitWidth: mainLayout.implicitWidth + Theme.border.radius * 2
  implicitHeight: mainLayout.implicitHeight + barShadow.blur

  exclusiveZone: mainLayout.implicitHeight

  property int iconSize: Theme.icons.l

  function getWindowPosX() {
    var panelX = screen.x + (screen.width - implicitWidth) / 2

    return panelX + activeWindowContainer.x
  }

  anchors {
    top: true
  }

  InvertedCorner {
    position: "topLeft"
    anchors.left: parent.left
    anchors.top: parent.top
  }

  InvertedCorner {
    position: "topRight"
    anchors.right: parent.right
    anchors.top: parent.top
  }

  Item {
    id: barContainer
    anchors.horizontalCenter: parent.horizontalCenter

    implicitWidth: panel.implicitWidth - Theme.border.radius * 2
    implicitHeight: panel.implicitHeight - barShadow.blur

    Shadow { id: barShadow }

    Rectangle {
      anchors.fill: parent
      color: Theme.colors.base00
      bottomLeftRadius: Theme.border.radius
      bottomRightRadius: Theme.border.radius
    }

    Column {
      id: mainLayout
      anchors.verticalCenter: barContainer.verticalCenter

      leftPadding: Theme.spacing.s
      rightPadding: Theme.spacing.s
      topPadding: Theme.spacing.xs
      bottomPadding: Theme.spacing.xs

      RowLayout {
        spacing: Theme.spacing.s

        Launcher { iconSize: panel.iconSize }
        Workspaces { }
        Item {
          id: activeWindowContainer
          implicitWidth: activeWindow.maxWidth
          implicitHeight: activeWindow.implicitHeight
          Window {
            id: activeWindow
            iconSize: panel.iconSize
          }
        }
        PipewireButton { iconSize: panel.iconSize }
        NetworkButton { iconSize: panel.iconSize }
        BluetoothButton { iconSize: panel.iconSize }
        BatteryButton { iconSize: panel.iconSize }
        Clock { iconSize: panel.iconSize }
        TrayButton { iconSize: panel.iconSize }
      }
    }
  }

  TrayPopup {
    id: trayPopup
  }
  PipewirePopup {
    id: pipewirePopup
  }
}
