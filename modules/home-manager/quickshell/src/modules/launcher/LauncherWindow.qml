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
  id: launcher

  intendedWidth: content.implicitWidth
  intendedHeight: content.implicitHeight

  visible: false

  anchors {
    top: true
  }

  exclusionMode: ExclusionMode.Normal


  IpcHandler {
    target: "launcher"

    function toggle() {
      visible = !visible
    }
  }

  Item {
    id: content

    property ProcessManager pm: ProcessManager {}
    property var apps

    implicitWidth: contentColumn.implicitWidth
    implicitHeight: contentColumn.implicitHeight

    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top: parent.top

    Component.onCompleted: {
      pm.query(["deutils", "list"], data => {
        try {
          content.apps = JSON.parse(data)
        } catch (e) {
          console.warn("Failed to parse windows:", e)
        }
      })
    }

    Column {
      id: contentColumn

      anchors.horizontalCenter: parent.horizontalCenter
      anchors.top: parent.top
      padding: Theme.spacing.s

      ColumnLayout {
        spacing: Theme.spacing.s
        clip: true

        ScrollView {
          id: scroll

          implicitWidth: 400
          implicitHeight: 200

          ListView {
            model: content.apps
            spacing: Theme.spacing.s

            clip: true

            delegate: Item {
              required property var modelData

              implicitWidth: appRow.width
              implicitHeight: appRow.height

              Row {
                id: appRow
                spacing: Theme.spacing.xs

                Image {
                  id: appIcon
                  width: Theme.icons.xxl
                  height: Theme.icons.xxl
                  source: {
                    if (!modelData.icon) return ""

                    if (modelData.icon.startsWith("/")) {
                      return "file://" + modelData.icon
                    } else {
                      return "image://icon/" + modelData.icon
                    }
                  }
                  fillMode: Image.PreserveAspectFit
                }
                Text {
                  anchors.verticalCenter: parent.verticalCenter
                  text: modelData.name || "Unknown"
                  color: Theme.colors.base05
                }
              }
            }
          }
        }

        TextField {
          id: searchInput
          Layout.fillWidth: true
          color: Theme.colors.base05
          activeFocusOnPress: true
          background: Rectangle {
            color: Theme.colors.base01
            radius: Theme.border.radius
          }
        }
      }
    }
  }
}

