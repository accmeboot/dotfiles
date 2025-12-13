import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import QtQuick.Layouts
import Quickshell.Widgets

import "../../settings"
import "../../services"
import "../../components"
import "../../windows"

//TODO: there is lazyLoader approach, that is not necessary, but will decrease memory usage (slightly)
Window {
  id: root

  intendedWidth: content.implicitWidth
  intendedHeight: content.implicitHeight

  position: "right"

  exclusionMode: ExclusionMode.Normal

  property PipewireManager pm: PipewireManager

	Connections {
		target: pm.defaultSink?.audio

		function onVolumeChanged() {
      onConnectionUpdate()
		}

    function onMutedChanged() {
      onConnectionUpdate()
    }
	}

  function onConnectionUpdate() {
    root.visible = true;
    hideTimer.restart();
  }

	Timer {
		id: hideTimer
		interval: 1000
		onTriggered: root.visible = false
	}

  Item {
    id: content
    anchors.right: parent.right
    anchors.verticalCenter: parent.verticalCenter

    implicitWidth: Theme.icons.l + Theme.spacing.xxl
    implicitHeight: 200

    Column {
      id: column
      padding: Theme.spacing.s
      anchors.horizontalCenter: parent.horizontalCenter
      spacing: Theme.spacing.s

      property color indicatorColor: Theme.colors.base0D

      ColoredIcon {
        id: volumeIcon
        anchors.horizontalCenter: parent.horizontalCenter
        size: Theme.icons.l
        icon: {
          if (pm.isMuted || pm.volume === 0) return "volume-muted.svg"

          if (pm.volume <= 30) return "volume-low.svg"

          if (pm.volume <= 60) return "volume-half.svg"

          return "volume-full.svg"
        } 
      }

      Rectangle {
        id: volumeMaxValue
        anchors.horizontalCenter: parent.horizontalCenter
        width: volumeIcon.width
        height: 140
        radius: Theme.border.radius
        color: Qt.rgba(column.indicatorColor.r, column.indicatorColor.g, column.indicatorColor.b, 0.5)

        Rectangle {
          id: volumeValue
          width: volumeMaxValue.width
          height: volumeMaxValue.height * pm.volume / 100
          topLeftRadius: Theme.border.radius
          topRightRadius: Theme.border.radius
          bottomLeftRadius: volumeMaxValue.height === height ? Theme.border.radius : 0
          bottomRightRadius: volumeMaxValue.height === height ? Theme.border.radius : 0
          color: Theme.colors.base0D
        }
      }

      Text {
        text: pm.volume + "%"
        color: Theme.colors.base05
        font.bold: true
      }
    }
  }
}
