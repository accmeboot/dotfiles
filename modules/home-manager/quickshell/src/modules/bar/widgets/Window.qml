import QtQuick
import Quickshell
import QtQuick

import "../../../settings"
import "../../../services"
import "../../../widgets"

Container {
  id: root

  property int iconSize: Theme.spacing.xxl
  property var activeWindow: NiriManager.getActiveWindow()

  visible: Boolean(activeWindow) && Boolean(activeWindow.title)

  maxWidth: 300

  Item {
    id: scrollContainer

    implicitWidth: row.implicitWidth
    implicitHeight: row.height

    property bool isTruncated: row.implicitWidth > width

    Row {
      id: row
      spacing: Theme.spacing.s

      x: scrollContainer.isTruncated && mouseArea.containsMouse ? scrollAnim.offset : 0

      Image {
        id: icon
        anchors.verticalCenter: parent.verticalCenter
        width: iconSize 
        height: iconSize 
        sourceSize: Qt.size(width, height)

        source: activeWindow ? "image://icon/" + activeWindow.app_id : ""

        onStatusChanged: {
          if (status === Image.Error) {
            source = "image://icon/application-x-executable"
          }
        }
      }

      Text {
        id: titleText
        anchors.verticalCenter: parent.verticalCenter
        color: Theme.colors.base05
        font.bold: true
        text: activeWindow ? activeWindow.title : ""
        elide: Text.ElideRight
        width: mouseArea.containsMouse ? implicitWidth : Math.min(implicitWidth, root.maxWidth - root.iconSize - Theme.spacing.xxl)
      }
    }


    MouseArea {
      id: mouseArea
      anchors.fill: parent
      hoverEnabled: true

      onContainsMouseChanged: {
        if (!containsMouse) {
          scrollAnim.stop()
          scrollAnim.offset = 0
        }
      }
    }

    SequentialAnimation {
      id: scrollAnim
      running: scrollContainer.isTruncated && mouseArea.containsMouse
      loops: Animation.Infinite

      property real offset: 0

      PauseAnimation { duration: 200 }

      NumberAnimation {
        target: scrollAnim
        property: "offset"
        from: 0
        to: -(row.implicitWidth - scrollContainer.width)
        duration: 2000
      }

      PauseAnimation { duration: 1000 }

      NumberAnimation {
        target: scrollAnim
        property: "offset"
        to: 0
        duration: 2000
      }
    }
  }
}
