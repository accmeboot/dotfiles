import QtQuick

import "../settings"

Canvas {
  property string color: Theme.colors.base00

  property string position: "topLeft" // topRight bottomLeft bottomRight
  property string orientation: "horizontal" // vertical

  property bool isLeft: position === "topLeft" || position === "bottomLeft"
  property bool isTop: position === "topLeft" || position === "topRight"

  anchors.left: isLeft ? parent.left : undefined
  anchors.top: isTop ? parent.top : undefined
  anchors.right: !isLeft ? parent.right : undefined
  anchors.bottom: !isTop ? parent.bottom : undefined

  width: Theme.border.radius
  height: Theme.border.radius

  onPaint: {
    var ctx = getContext("2d")

    ctx.fillStyle = color
    ctx.beginPath()

    switch (position) {
      case "topLeft": drawTopLeft(ctx); break
      case "topRight": drawTopRight(ctx); break
      case "bottomLeft": drawBottomLeft(ctx); break
      case "bottomRight": drawBottomRight(ctx); break
    }

    ctx.closePath()
    ctx.fill()
  }

  function drawTopLeft(ctx) {
    if (orientation === "horizontal") {
      ctx.moveTo(width, 0)
      ctx.lineTo(width, height)
      ctx.quadraticCurveTo(width, 0, 0, 0)
    } else {
      ctx.moveTo(0, height)
      ctx.lineTo(width, height)
      ctx.quadraticCurveTo(0, height, 0, 0)
    }
  }

  function drawTopRight(ctx) {
    if (orientation === "horizontal") {
      ctx.moveTo(0, 0)
      ctx.lineTo(0, height)
      ctx.quadraticCurveTo(0, 0, width, 0)
    } else {
      ctx.moveTo(width, height)
      ctx.lineTo(0, height)
      ctx.quadraticCurveTo(width, height, width, 0)
    }
  }

  function drawBottomLeft(ctx) {
    ctx.moveTo(0, 0)
    ctx.lineTo(width, 0)
    ctx.quadraticCurveTo(0, 0, 0, height)
  }

  function drawBottomRight(ctx) {
    ctx.moveTo(width, 0)
    ctx.lineTo(0, 0)
    ctx.quadraticCurveTo(width, 0, width, height)
  }
}
