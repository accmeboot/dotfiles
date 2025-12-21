import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import QtQuick.Layouts
import Quickshell.Wayland
import Quickshell.Services.Notifications

import "../../settings"
import "../../services"
import "../../components"
import "../../windows"

Window {
  id: root

  intendedWidth: content.implicitWidth
  intendedHeight: content.implicitHeight

  WlrLayershell.layer: WlrLayer.Top

  property NotificationManager nm: NotificationManager

  visible: Boolean(nm.activeList.count)

  position: "top-right"

  exclusionMode: ExclusionMode.Ignore

  Item {
    id: content

    implicitWidth: contentColumn.implicitWidth
    implicitHeight: contentColumn.implicitHeight

    anchors.right: parent.right

    Column {
      id: contentColumn

      spacing: Theme.spacing.s
      padding: Theme.spacing.s

      clip: true

      Repeater {
        model: root.nm.activeList
        delegate: Rectangle {
          required property QtObject modelData

          id: notificationRectangle

          implicitWidth: 350 + Theme.spacing.s * 2
          implicitHeight: notificationContainer.implicitHeight

          color: Theme.colors.base01
          clip: true
          radius: Theme.border.radius

          ColoredIcon {
            anchors.right: parent.right
            anchors.top: parent.top

            anchors.topMargin: Theme.spacing.s
            anchors.rightMargin: Theme.spacing.s
            size: Theme.icons.l
            icon: "cross.svg"
            color: Theme.colors.base05

            opacity: closeMouseArea.containsMouse ? 0.7 : 1

            MouseArea {
              id: closeMouseArea
              anchors.fill: parent
              cursorShape: Qt.PointingHandCursor
              hoverEnabled: true

              onClicked: {
                root.nm.dismissOrExpireNotification(modelData.id)
              }
            }
          }

          Column {
            id: notificationContainer
            spacing: Theme.spacing.xs
            anchors.centerIn: parent

            padding: Theme.spacing.s

            property bool isIconExist: Boolean(modelData.icon) || Boolean(modelData.image)

            Row {
              id: notificationBody
              spacing: Theme.spacing.s

              Image {
                id: notificationImage
                width: Theme.icons.xxxl
                height: Theme.icons.xxxl
                visible: notificationContainer.isIconExist
                anchors.verticalCenter: parent.verticalCenter
                source: {
                  if (modelData.icon) {
                    if (modelData.icon.startsWith("file:")) return modelData.icon

                    var prefix = modelData.icon.startsWith("/") ? "file://" : "image://icon/" 

                    return prefix + modelData.icon
                  }

                  if (modelData.image) {
                    return modelData.image
                  }

                  return ""
                } 
              }

              ColoredIcon {
                id: notificationIcon
                visible: !notificationContainer.isIconExist
                size: Theme.icons.xxxl
                icon: "notification.svg"
                color: Theme.colors.base05
                anchors.verticalCenter: parent.verticalCenter
              }

              Column {
                id: notificationBodyText
                spacing: Theme.spacing.xs
                Text {
                  text: modelData.appName + "<font color='" + Theme.colors.base04 + "'>&#8194;" + getTime(modelData.timestamp) + "</font>"
                  color: {
                    switch (modelData.urgency) {
                      case NotificationUrgency.Critical: return Theme.colors.base08
                      case NotificationUrgency.Normal: return Theme.colors.base0A
                      default: return Theme.colors.base0C
                    }
                  } 
                  wrapMode: Text.Wrap
                  font.bold: true
                  width: notificationRectangle.width - notificationImage.width - Theme.spacing.s * 2 - Theme.spacing.s
                  textFormat: Text.StyledText
                }
                Text {
                  text: modelData.title
                  color: Theme.colors.base05
                  wrapMode: Text.Wrap
                  width: notificationRectangle.width - notificationImage.width - Theme.spacing.s * 2 - Theme.spacing.s
                  maximumLineCount: 1
                  elide: Text.ElideRight
                  font.bold: true
                }
                Text {
                  text: modelData.body
                  color: Theme.colors.base05
                  wrapMode: Text.Wrap
                  width: notificationRectangle.width - notificationImage.width - Theme.spacing.s * 2 - Theme.spacing.s
                  maximumLineCount: 2
                  elide: Text.ElideRight
                  textFormat: Text.StyledText
                }

                Row {
                  id: actionsRow
                  spacing: Theme.spacing.s
                  topPadding: Theme.spacing.xs

                  Repeater {
                    model: notificationRectangle.modelData.actions
                    delegate: Rectangle {
                      required property QtObject modelData

                      implicitWidth: actionText.width
                      implicitHeight: actionText.height

                      color: Theme.colors.base0A
                      radius: Theme.border.radius

                      opacity: actionMouseArea.containsMouse ? 0.7 : 1

                      Text {
                        id: actionText
                        color: Theme.colors.base00
                        text: modelData.text
                        padding: Theme.spacing.xs
                        elide: Text.ElideRight
                        width: Math.min(implicitWidth, 100)
                        textFormat: Text.StyledText
                      }

                      MouseArea {
                        id: actionMouseArea
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        hoverEnabled: true

                        onClicked: {
                          root.nm.invokeAction(notificationRectangle.modelData.id, modelData.id)
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }

  function getTime(timestamp) {
    var date = new Date(timestamp)
    var hours = String(date.getHours()).padStart(2, '0')
    var minutes = String(date.getMinutes()).padStart(2, '0')

    return hours + ":" + minutes
  }
}
