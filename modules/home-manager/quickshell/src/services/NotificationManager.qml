pragma Singleton
import QtQuick
import Quickshell.Services.Notifications

QtObject {
  id: root

  property ListModel activeList: ListModel {}

  property var notificationsActions: []
  property var notificationsWatchers: []

  property NotificationServer server: NotificationServer {
    keepOnReload: false
    imageSupported: true
    actionsSupported: true
    onNotification: notification => handleNotification(notification)
  }

  property Component watcherComponent: Component {
    id: notificationWatcherComponent
    Connections {
      property var targetNotification

      target: targetNotification

      function onSummaryChanged() {
        updateNotificationFromObject(targetNotification);
      }
      function onBodyChanged() {
        updateNotificationFromObject(targetNotification);
      }
      function onAppNameChanged() {
        updateNotificationFromObject(targetNotification);
      }
      function onUrgencyChanged() {
        updateNotificationFromObject(targetNotification);
      }
      function onAppIconChanged() {
        updateNotificationFromObject(targetNotification);
      }
      function onImageChanged() {
        updateNotificationFromObject(targetNotification);
      }
      function onActionsChanged() {
        updateNotificationFromObject(targetNotification);
      }
    }
  }

  function updateNotificationFromObject(notification) {
    var notificationIdx = getNotificationIndexById(notification.id)

    if (notificationIdx === -1) return

    var item = prepareNotificationObject(notification)

    activeList.setProperty(notificationIdx, "title", item.title)
    activeList.setProperty(notificationIdx, "body", item.body)
    activeList.setProperty(notificationIdx, "image", item.image)
    activeList.setProperty(notificationIdx, "icon", item.icon)
    activeList.setProperty(notificationIdx, "actions", item.actions)

    notificationsActions = notificationsActions.map((action) => {
      if (action.id === item.id) {
        return prepareActionsObject(notification)
      }

      return action
    })
  }

  function handleNotification(notification) {
    var item = prepareNotificationObject(notification)

    notification.tracked = true;

    var watcher = notificationWatcherComponent.createObject(root, {
      "targetNotification": notification,
    });

    activeList.append(item)
    notificationsWatchers.push({ id: notification.id, watcher: watcher })
    notificationsActions.push(prepareActionsObject(notification))
  }

  function makeNotificationActionId(notificationId, actionId) {
    return String(notificationId) + ":" + String(actionId)
  }

  function prepareActionsObject(notification) {
    return {
      id: notification.id,
      dismiss: notification.dismiss,
      expire: notification.expire,
      list: notification.actions.map((action, index) => {
        return {
          id: makeNotificationActionId(notification.id, index),
          invoke: action.invoke,
        }
      }),
    }
  }

  function prepareNotificationObject(notification) {
    return {
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
          id: makeNotificationActionId(notification.id, index),
          identifier: action.identifier, // this is icon name
          text: action.text,
        }
      }),
    }
  }

  function dismissOrExpireNotification(notificationId, isExpire = false) {
    var notificationIdx = getNotificationIndexById(notificationId)

    if (notificationIdx === -1) return

    var notification = activeList.get(notificationIdx)

    if (notification) {
      var notificationActions = notificationsActions.find((item) => item.id === notificationId)

      if (notificationActions) {
        if (isExpire) notificationActions.expire()
        if (!isExpire) notificationActions.dismiss()

        removeNotification(notificationId)
      }
    }
  }

  function invokeAction(notificationId, actionId) {
    var actions = notificationsActions.find((item) => item.id === notificationId)

    if (actions) {
      var action = actions?.list?.find((item) => item.id === actionId)

      if (action) {
        action?.invoke()
        removeNotification(notificationId)
      }
    }
  }

  function removeNotification(notificationId) {
    var notificationIdx = getNotificationIndexById(notificationId)

    if (notificationIdx === -1) return

    var watcher = notificationsWatchers.find((item) => item.id === notificationId)

    watcher?.watcher?.destroy()

    activeList.remove(notificationIdx)
    notificationsActions = notificationsActions.filter((item) => item.id !== notificationId)
    notificationsWatchers = notificationsWatchers.filter((item) => item.id !== notificationId)
  }

  function getNotificationIndexById(notificationId) {
    var idx = -1

    for (var i = 0; i < activeList.count; i++) {
      var item = activeList.get(i)

      if (item.id === notificationId) {
        idx = i
        break
      }
    }

    if (idx === -1) console.warn("Notification with id: " + notificationId + "not found")

    return idx
  }

  property Timer timer: Timer {
    interval: 1000
    running: activeList.count > 0
    repeat: true
    onTriggered: () => {
      for (var i = activeList.count - 1; i >= 0; --i) {
        var notification = activeList.get(i)

        var hasActions = notification.actions.count > 0
        var noTimeout = notification.expireTimeout <= 0

        if (hasActions || noTimeout) continue

        var passed = Date.now() - notification.timestamp

        if (passed > notification.expireTimeout) {
          dismissOrExpireNotification(notification.id, true)
        }
      }
    }
  }
}
