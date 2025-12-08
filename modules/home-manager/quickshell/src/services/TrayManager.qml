pragma Singleton
import Quickshell.Services.SystemTray
import QtQuick

import "../settings"

QtObject {
  id: root

  property var items: SystemTray.items.values

  property var hiddenTrayItems: Settings.bar.hiddenTrayItems

  property var itemCount: SystemTray.items.values.length

  property var itemsFiltered: {
    return items.filter((item) => {
      return !hiddenTrayItems.includes(item.title)
    })
  } 

  property var itemsFilteredCount: itemsFiltered.length
}
