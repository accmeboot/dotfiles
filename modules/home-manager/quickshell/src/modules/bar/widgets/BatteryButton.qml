import QtQuick
import Quickshell
import Quickshell.Services.UPower

import "../../../settings"
import "../../../widgets"

Container {
  property int iconSize: Theme.spacing.xxl
  property int popupOffset: Theme.spacing.s

  property UPowerDevice device: UPower.displayDevice
  property int percentage: device ? device.percentage * 100 : null

  visible: Boolean(device)

  Item {
    implicitWidth: row.implicitWidth
    implicitHeight: row.height

    Row {
      id: row
      spacing: Theme.spacing.s

      ColoredIcon {
        anchors.verticalCenter: parent.verticalCenter
        icon: getIcon() 
        color: Theme.colors.base0D
        size: iconSize
      }

      Text {
        anchors.verticalCenter: parent.verticalCenter
        text: percentage + "%"
        font.bold: true
        color: Theme.colors.base05
      }
    }
  }


  function getIcon() {
    switch (device.state) {
      case UPowerDeviceState.Discharging:
      case UPowerDeviceState.PendingDischarge:
      case UPowerDeviceState.Empty:
        return getIconByPercantage()
      case UPowerDeviceState.Unknown:
      case UPowerDeviceState.PendingCharge:
      case UPowerDeviceState.FullyCharged:
        return "battery-plugged.svg"
      case UPowerDeviceState.Charging:
        return "battery-charging.svg"
    }
  }

  function getIconByPercantage() {
    switch (true) {
      case percentage >= 80: return "battery-full.svg"
      case percentage >= 60: return "battery-good.svg"
      case percentage >= 40: return "battery-low.svg"

      default: return "battery-empty.svg"
    }
  }
}
