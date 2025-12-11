import Quickshell
import QtQuick
import QtQuick.Controls
import QtQuick.Effects

import "../../../settings"
import "../../../services"
import "../../../widgets"
import "../../../windows"


ContextMenu {
  intendedWidth: column.implicitWidth
  intendedHeight: column.implicitHeight

  anchor {
    window: panel
  }

  Column {
    id: column

    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top: parent.top

    spacing: Theme.spacing.xs

    topPadding: Theme.spacing.s
    bottomPadding: Theme.spacing.s

    readonly property real contentWidth: {
      return Math.max(...children.map((child) => child.implicitWidth))
    }

    Row {
      leftPadding: Theme.spacing.s

      Text {
        text: "Output devices"
        color: Theme.colors.base04
        font.bold: true
      }
    }

    Repeater {
      model: PipewireManager.nodesModel

      delegate: Item {
        required property var modelData

        visible: modelData.isSink && modelData.audio && modelData.nickname

        implicitWidth: sinkRow.width
        implicitHeight: sinkRow.height

        width: column.contentWidth

        Rectangle {
          anchors.fill: parent
          color: mouseArea.containsMouse ? Theme.colors.base01 : Theme.colors.base00

          Row {
            id: sinkRow
            spacing: Theme.spacing.s

            rightPadding: Theme.spacing.m
            leftPadding: Theme.spacing.m

            topPadding: Theme.spacing.xs
            bottomPadding: Theme.spacing.xs

            Rectangle {
              anchors.verticalCenter: parent.verticalCenter
              color: Theme.colors.base0D
              implicitWidth: Theme.icons.l
              implicitHeight: Theme.icons.s
              opacity: modelData === PipewireManager.defaultSink 
              radius: 999
            }

            Text {
              id: sinkText
              anchors.verticalCenter: parent.verticalCenter
              text: modelData.nickname
              color: Theme.colors.base05
            }
          }

          MouseArea {
            id: mouseArea
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor

            onClicked: {
              PipewireManager.setDefaultAudioSink(modelData)
              pipewirePopup.visible = false
            }
          }
        }
      }
    }

    Rectangle {
      color: "transparent"
      width: column.contentWidth
      height: Theme.spacing.l
    }


    Row {
      leftPadding: Theme.spacing.s

      Text {
        text: "Input devices"
        color: Theme.colors.base04
        font.bold: true
      }
    }

    Repeater {
      id: inputRepeater
      model: PipewireManager.nodesModel

      delegate: Item {
        required property var modelData
        required property int index

        property bool isSource: !modelData.isSink && !modelData.isStream

        visible: isSource && modelData.audio && modelData.nickname

        implicitWidth: sourceRow.width
        implicitHeight: sourceRow.height

        width: column.contentWidth

        Rectangle {
          anchors.fill: parent
          color: mouseArea.containsMouse ? Theme.colors.base01 : Theme.colors.base00

          Row {
            id: sourceRow
            spacing: Theme.spacing.s

            rightPadding: Theme.spacing.m
            leftPadding: Theme.spacing.m

            topPadding: Theme.spacing.xs
            bottomPadding: Theme.spacing.xs


            Rectangle {
              anchors.verticalCenter: parent.verticalCenter
              color: Theme.colors.base0D
              implicitWidth: Theme.icons.l
              implicitHeight: Theme.icons.s
              opacity: modelData === PipewireManager.defaultSource
              radius: 999
            }

            Text {
              id: sinkText
              anchors.verticalCenter: parent.verticalCenter
              text: modelData.nickname
              color: Theme.colors.base05
            }
          }

          MouseArea {
            id: mouseArea
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor

            onClicked: {
              PipewireManager.setDefaultAudioSource(modelData)
              pipewirePopup.visible = false
            }
          }
        }
      }
    }
  }
}
