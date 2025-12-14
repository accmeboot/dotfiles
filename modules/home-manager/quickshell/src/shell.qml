//@ pragma UseQApplication
import Quickshell
import QtQuick

import "./modules/bar"
import "./modules/launcher"
import "./modules/osd"
import "./modules/notification"

Scope {
  Variants {
    model: Quickshell.screens

    delegate: Item {
      required property var modelData

      Bar {
        id: barPanel
        screen: modelData
      }

      LauncherWindow {
        id: launcherWindow
        screen: modelData
      }

      VolumeWindow {
        id: volumeWindow
        screen: modelData
      }

      NotificationWindow {
        id: notificationWindow
        screen: modelData
      }
    }
  }
}
