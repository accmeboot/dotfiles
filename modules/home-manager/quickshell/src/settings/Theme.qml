pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

QtObject {
  property FileView settingsFile: FileView {
    path: Quickshell.env("HOME") + "/dotfiles/modules/home-manager/quickshell/src/theme.json"
    
    JsonAdapter {
      id: settingsAdapter
      
      property JsonObject colors: JsonObject {
        property string base00: "#212121"
        property string base01: "#303030"
        property string base02: "#353535"
        property string base03: "#4A4A4A"
        property string base04: "#B2CCD6"
        property string base05: "#EEFFFF"
        property string base06: "#EEFFFF"
        property string base07: "#FFFFFF"
        property string base08: "#F07178"
        property string base09: "#F78C6C"
        property string base0A: "#FFCB6B"
        property string base0B: "#C3E88D"
        property string base0C: "#89DDFF"
        property string base0D: "#82AAFF"
        property string base0E: "#C792EA"
        property string base0F: "#FF5370"
      }
      
      property JsonObject spacing: JsonObject {
        property int xxs: 2
        property int xs: 4
        property int s: 8
        property int m: 12
        property int l: 16
        property int xl: 20
        property int xxl: 24
        property int xxxl: 32
      }
      
      property JsonObject border: JsonObject {
        property int width: 2
        property int radius: 4
      }

      property JsonObject icons: JsonObject {
        property int xs: 4
        property int s: 8
        property int m: 12
        property int l: 16
        property int xl: 20
        property int xxl: 24
        property int xxxl: 32
      }
    }
  }

  readonly property QtObject colors: settingsAdapter.colors
  readonly property QtObject spacing: settingsAdapter.spacing
  readonly property QtObject border: settingsAdapter.border
  readonly property QtObject icons: settingsAdapter.icons
}
