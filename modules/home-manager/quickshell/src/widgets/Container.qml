import QtQuick
import Quickshell.Widgets

import "../settings"

Rectangle {
  property int paddingHorizontal: Theme.spacing.s
  property int paddingVertical: Theme.spacing.xs
  property int maxWidth: -1

  color: Theme.colors.base02
  radius: Theme.border.radius

  clip: maxWidth > 0

  implicitWidth: {
    var contentWidth = manager.implicitWidth

    if (maxWidth > 0) {
      return Math.min(contentWidth, maxWidth)
    }
    return contentWidth
  }

  implicitHeight: manager.implicitHeight

  MarginWrapperManager {
    id: manager
    leftMargin: paddingHorizontal
    rightMargin: paddingHorizontal
    topMargin: paddingVertical
    bottomMargin: paddingVertical
  }
}
