pragma Singleton
import QtQuick
import Quickshell.Services.Notifications

QtObject {
  id: root

  property ListModel activeList: ListModel {}
  property var notificationsActions: []

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
      expireTimeout: notification.expireTimeout,
      timestamp: Date.now(),
      actions: notification.actions.map((action, index) => {
        return {
          id: String(notification.id) + ":" + String(index),
          identifier: action.identifier, // this is icon name
          text: action.text,
        }
      })
    }

    notification.tracked = true;

    activeList.append(item)
    notificationsActions.push({
      id: notification.id,
      dismiss: notification.dismiss,
      list: notification.actions.map((action, index) => {
        return {
          id: String(notification.id) + ":" + String(index),
          invoke: action.invoke,
        }
      }),
    })
  }

  function dismissNotification(index) {
    var notification = activeList.get(index)

    if (notification) {
      var notificationActions = notificationsActions.find((item) => item.id === notification.id)

      if (notificationActions) {
        notificationActions.dismiss()
        activeList.remove(index)
        notificationsActions = notificationsActions.filter((item) => item.id !== notification.id)
      }
    }
  }

  function invokeAction(notificationId, actionId, notificationIndex) {
    var actions = notificationsActions.find((item) => item.id === notificationId)

    if (actions) {
      var action = actions?.list?.find((item) => item.id === actionId)

      if (action) {
        action?.invoke()
        activeList.remove(notificationIndex)
        notificationsActions = notificationsActions.filter((item) => item.id !== notificationId)
      }
    }
  }

  property Timer timer: Timer {
    interval: 1000
    running: activeList.count > 0
    repeat: true
    onTriggered: () => {
      for (var i = 0; i < activeList.count; i++) {
        var notification = activeList.get(i)

        var hasActions = notification.actions.count > 0
        var noTimeout = notification.expireTimeout <= 0

        if (hasActions || noTimeout) continue

        var passed = Date.now() - notification.timestamp

        if (passed > notification.expireTimeout) {
          dismissNotification(i)
        }
      }
    }
  }
}
