import Quickshell
import QtQuick
import QtQuick.Controls

import "../../../settings"
import "../../../services"

PopupWindow {
  id: root

  anchor {
    window: panel
  }

  color: "transparent"
  visible: false

  implicitWidth: content.implicitWidth
  implicitHeight: content.implicitHeight

  Rectangle {
    id: content

    color: Theme.colors.base01
    radius: Theme.border.radius

    implicitWidth: column.implicitWidth
    implicitHeight: column.implicitHeight

    Column {
      id: column

      padding: Theme.spacing.s
      spacing: Theme.spacing.s

      readonly property real contentWidth: {
        return Math.max(...children.map((child) => child.implicitWidth))
      }

      Text {
        text: "Output devices"
        color: Theme.colors.base05
        font.bold: true
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

            color: mouseArea.containsMouse ? Theme.colors.base03 : Theme.colors.base01

            radius: Theme.border.radius

            Row {
              id: sinkRow
              spacing: Theme.spacing.s

              padding: Theme.spacing.xs

              Image {
                anchors.verticalCenter: parent.verticalCenter
                source: {
                  if (modelData === PipewireManager.defaultSink) {
                    return "../../../assets/selected.svg"
                  }

                  return "../../../assets/unselected.svg"
                } 

                width: Theme.icons.m
                height: Theme.icons.m 

                sourceSize: Qt.size(Theme.icons.m, Theme.icons.m)
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
                root.visible = false
              }
            }
          }
        }
      }

      Rectangle {
        color: "transparent"
        width: column.contentWidth
        height: Theme.spacing.s
      }


      Text {
        text: "Input devices"
        color: Theme.colors.base05
        font.bold: true
      }

      Repeater {
        model: PipewireManager.nodesModel

        delegate: Item {
          required property var modelData

          property bool isSource: !modelData.isSink && !modelData.isStream

          visible: isSource && modelData.audio && modelData.nickname

          implicitWidth: sourceRow.width
          implicitHeight: sourceRow.height

          width: column.contentWidth

          Rectangle {
            anchors.fill: parent

            color: mouseArea.containsMouse ? Theme.colors.base03 : Theme.colors.base01

            radius: Theme.border.radius

            Row {
              id: sourceRow
              spacing: Theme.spacing.s

              padding: Theme.spacing.xs

              Image {
                anchors.verticalCenter: parent.verticalCenter
                source: {
                  if (modelData === PipewireManager.defaultSource) {
                    return "../../../assets/selected.svg"
                  }

                  return "../../../assets/unselected.svg"
                } 

                width: Theme.icons.m
                height: Theme.icons.m 

                sourceSize: Qt.size(Theme.icons.m, Theme.icons.m)
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
                root.visible = false
              }
            }
          }
        }
      }
    }
  }
}
