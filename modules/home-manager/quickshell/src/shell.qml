//@ pragma UseQApplication
import Quickshell
import QtQuick

import "./modules/bar"
import "./modules/launcher"

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
    }
  }
}
