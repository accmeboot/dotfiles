pragma Singleton
import QtQuick
import Quickshell.Services.Notifications

QtObject {
  id: root

  property ListModel activeList: ListModel {}

  property NotificationServer server: NotificationServer {
    keepOnReload: true
    imageSupported: true
    actionsSupported: true
    onNotification: notification => handleNotification(notification)
  }

  function handleNotification(notification) {
    var item = {
      id: notification.id,
      title: notification.summary,
      body: notification.body,
      image: notification.image,
      icon: notification.appIcon,
      appName: notification.appName,
    }

    activeList.append(item)
  }

  function dismissNotification(index) {
    var notification = activeList.get(index)
  
    //TODO: We need to send dissmiss signal to the server

    activeList.remove(index)
  }
}
