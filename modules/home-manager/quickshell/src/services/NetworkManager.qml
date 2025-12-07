pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

QtObject {
  id: root

  property bool isConnected: false

  property string connectionType: "none" // "wifi", "ethernet", "none"
  property string connectionName: "none"

  property int signalStrength: 0 // 0-100 for wifi

  property Process monitor: Process {
    command: ["nmcli", "monitor"]
    running: true

    stdout: SplitParser {
      splitMarker: "\n"
      
      onRead: data => {
        if (data.includes("Networkmanager is now in the")) {
          if (data.includes("'connected'") || data.includes("'connected (site only)'")) {
            isConnected = true
            updateConnectionInfo()
          } else if (data.includes("'disconnected'") || data.includes("'disconnecting'")) {
            isConnected = false
            connectionType = "none"
            connectionName = ""
            signalStrength = 0
          }
        }
        
        if (data.includes("using connection")) {
          var match = data.match(/'([^']+)'/)
          if (match) {
            connectionName = match[1]
          }
        }
      }
    }
  }

  function updateConnectionInfo() {
    ProcessManager.query(
      ["nmcli", "-t", "-f", "TYPE,NAME,DEVICE", "connection", "show", "--active"],
      data => {
        if (!data || data.trim() === "") return
        
        var lines = data.trim().split("\n")

        if (lines.length > 0) {
          var parts = lines[0].split(":")
          var type = parts[0]


          if (type === "loopback") {
            return
          }

          isConnected = true
          connectionName = parts[1]
          
          if (type.includes("wireless") || type.includes("802-11-wireless")) {
            connectionType = "wifi"

            updateWifiSignal()
          } else if (type.includes("ethernet") || type.includes("802-3-ethernet")) {
            connectionType = "ethernet"
            signalStrength = 0
          }
        }
      }
    )
  }

  function updateWifiSignal() {
    ProcessManager.query(
      ["nmcli", "-t", "-f", "IN-USE,SIGNAL", "device", "wifi", "list"],
      data => {
        var lines = data.trim().split("\n")
        for (var i = 0; i < lines.length; i++) {
          if (lines[i].startsWith("*:")) {
            signalStrength = parseInt(lines[i].split(":")[1])
            break
          }
        }
      }
    )
  }

  Component.onCompleted: {
    updateConnectionInfo()
  }
}
