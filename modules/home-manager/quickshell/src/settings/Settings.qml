pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

QtObject {
  property FileView settingsFile: FileView {
    path: Quickshell.env("HOME") + "/dotfiles/modules/home-manager/quickshell/src/settings.json"
    
    JsonAdapter {
      id: settingsAdapter
      
      property JsonObject bar: JsonObject {
        property list<string> hiddenTrayItems: []
      }
    }
  }

  readonly property QtObject bar: settingsAdapter.bar
}
