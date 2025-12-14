import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import QtQuick.Layouts
import Quickshell.Wayland

import "../../settings"
import "../../services"
import "../../components"
import "../../windows"

Window {
  id: launcher

  intendedWidth: content.implicitWidth
  intendedHeight: content.implicitHeight

  WlrLayershell.layer: WlrLayer.Top
  WlrLayershell.keyboardFocus: WlrKeyboardFocus.OnDemand

  visible: false

  position: "bottom"

  exclusionMode: ExclusionMode.Normal

  IpcHandler {
    target: "launcher"

    function toggle() {
      visible = !visible
    }
  }

  onVisibleChanged: {
    if (visible) {
      // currently there is warning, it happens because of race condition, look up Loader in the docs to fix it, if it breaks something
      searchInput.forceActiveFocus()

      appsListView.currentIndex = 0
      content.command = ""
      searchInput.text = ""
    }
  }

  Item {
    id: content
    anchors.centerIn: parent

    property ProcessManager pmlist: ProcessManager {}
    property ProcessManager pmsearch: ProcessManager {}
    property ProcessManager pmexec: ProcessManager {}

    property var apps
    property string command: ""

    implicitWidth: contentColumn.implicitWidth
    implicitHeight: contentColumn.implicitHeight

    anchors.bottom: parent.bottom

    Component.onCompleted: {
      pmlist.query(["deutils", "list"], data => {
        try {
          content.apps = sortApps(data)
        } catch (e) {
          console.warn("Failed to parse windows:", e)
        }
      })
    }

    Keys.onUpPressed: {
      if (appsListView.currentIndex < appsListView.count - 1) {
        appsListView.currentIndex++
        appsListView.positionViewAtIndex(appsListView.currentIndex, ListView.Contain)
      }
    }

    Keys.onDownPressed: {
      if (appsListView.currentIndex > 0) {
        appsListView.currentIndex--
        appsListView.positionViewAtIndex(appsListView.currentIndex, ListView.Contain)
      }
    }


    Keys.onReturnPressed: {
      if (command !== "") {
        runCommand(command)
      } else {
        openApp(apps[appsListView.currentIndex])
      }
    }

    Keys.onEscapePressed: {
      launcher.visible = false
    }

    Column {
      id: contentColumn

      anchors.horizontalCenter: parent.horizontalCenter
      anchors.top: parent.top

      leftPadding: Theme.spacing.s
      rightPadding: Theme.spacing.s
      topPadding: Theme.spacing.s
      bottomPadding: Theme.spacing.s

      ColumnLayout {
        spacing: Theme.spacing.s
        clip: true

        ScrollView {
          id: scroll
          ScrollBar.vertical.policy: ScrollBar.AlwaysOff
          ScrollBar.horizontal.policy: ScrollBar.AlwaysOff

          implicitWidth: 300
          implicitHeight: 280

          ListView {
            id: appsListView
            model: content.apps
            spacing: Theme.spacing.s
            verticalLayoutDirection: ListView.BottomToTop
            clip: true

            currentIndex: 0

            WheelHandler {
              id: wheel
              acceptedDevices: PointerDevice.Mouse | PointerDevice.TouchPad
              onWheel: (event) => {
                var up = event.angleDelta.y > 0;

                if (up) {
                  appsListView.incrementCurrentIndex()
                } else {
                  appsListView.decrementCurrentIndex()
                }
              }
            }

            delegate: Item {
              required property var modelData
              required property int index

              implicitWidth: appRow.width
              implicitHeight: appRow.height

              property bool isSelected: appsListView.currentIndex === index 

              Rectangle {
                implicitWidth: scroll.implicitWidth
                implicitHeight: appRow.implicitHeight

                color: isSelected ? Theme.colors.base0D : Theme.colors.base00
                radius: Theme.border.radius
              }

              Row {
                id: appRow
                spacing: Theme.spacing.s

                topPadding: Theme.spacing.xs
                bottomPadding: Theme.spacing.xs
                leftPadding: Theme.spacing.s
                rightPadding: Theme.spacing.s

                Image {
                  id: appIcon
                  width: Theme.icons.l
                  height: Theme.icons.l

                  sourceSize: Qt.size(width, height)

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
                  color: isSelected ? Theme.colors.base00 : Theme.colors.base05
                }
              }

              MouseArea {
                id: rowMouseArea
                anchors.fill: appRow
                cursorShape: Qt.PointingHandCursor
                hoverEnabled: true

                onClicked: content.openApp(modelData)
              }
            }
          }
        }

        TextField {
          id: searchInput
          Layout.fillWidth: true
          color: Theme.colors.base05

          topPadding: Theme.spacing.xs
          bottomPadding: Theme.spacing.xs

          leftPadding: Theme.spacing.s + Theme.spacing.s + searchIcon.size
          rightPadding: Theme.spacing.xs

          placeholderText: "Type : to run a command"
          placeholderTextColor: Theme.colors.base04

          background: Rectangle {
            color: Theme.colors.base01
            radius: Theme.border.radius

            ColoredIcon {
              id: searchIcon
              anchors.leftMargin: Theme.spacing.s
              anchors.left: parent.left
              icon: content.command !== "" ? "shell.svg" : "find.svg"
              size: Theme.icons.l
              color: Theme.colors.base05
              anchors.verticalCenter: parent.verticalCenter
            }

          }
          Keys.forwardTo: content

          onTextChanged: {
            if (text.charAt(0) === ":") {
              content.command = text

              return
            }

            content.command = ""

            content.pmsearch.query(["deutils", "search", text], data => {
              content.apps = content.sortApps(data)
            })
          }
        }
      }
    }

    function sortApps(data) {
      try {
        return JSON.parse(data.trim())
        .slice()
        .filter((app) => !app.terminal)
        .sort((a, b) => a.name.toUpperCase() > b.name.toUpperCase() ? 1 : -1)
      } catch (e) {
        console.warn("Failed to parse desktop entries:", e)
        return []
      }
    }

    function openApp(app) {
      if (!app.terminal) {
        content.pmexec.execute(app.execArgs)
        launcher.visible = false
      }
    }


    function runCommand(command) {
      pmexec.execute(["sh", "-c", command.substring(1).trim()])
      launcher.visible = false
    }
  }
}
