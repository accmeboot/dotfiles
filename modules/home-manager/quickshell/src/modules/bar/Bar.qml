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

  property int cornerRadius: Theme.border.radius
  property int paddingHorizontal: Theme.spacing.s
  property int paddingVertical: Theme.spacing.l

  property int iconSize: Theme.icons.l

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

    Shadow { anchors.bottomMargin: panel.cornerRadius }
    InvertedCorner { position: "bottomLeft"}
    InvertedCorner { position: "bottomRight"}

    Rectangle {
      id: barBackground
      anchors.fill: parent
      anchors.bottomMargin: panel.cornerRadius
      color: Theme.colors.base00
    }

    RowLayout {
      anchors.left: barBackground.left
      anchors.right: barBackground.right
      anchors.verticalCenter: barBackground.verticalCenter

      anchors.rightMargin: panel.paddingHorizontal
      anchors.leftMargin: panel.paddingHorizontal
      anchors.topMargin: panel.paddingVertical
      anchors.bottomMargin: panel.paddingVertical

      spacing: Theme.spacing.m

      Launcher { iconSize: panel.iconSize }
      Workspaces {}
      Window { iconSize: panel.iconSize }

      Item { Layout.fillWidth: true }

      PipewireButton { iconSize: panel.iconSize }
      NetworkButton { iconSize: panel.iconSize }
      BluetoothButton { iconSize: panel.iconSize }
      BatteryButton { iconSize: panel.iconSize }
      Clock { iconSize: panel.iconSize }
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
