import QtQuick
import Quickshell
import Quickshell.Io

QtObject {
  id: root

  property var callback: null

  property Process runner: Process {
    stdout: SplitParser {
      onRead: data => {
        if (root.callback) {
          root.callback(data)
        }
      }
    }

    stderr: SplitParser {
      onRead: data => {
        if (data.trim() !== "") {
          console.error("Process error:", runner.command, "->", data)
        }
      }
    }
  }

  property Process executer: Process {
    stderr: SplitParser {
      onRead: data => {
        if (data.trim() !== "") {
          console.error("Process error:", runner.command, "->", data)
        }
      }
    }
  }

  function execute(command) {
    executer.command = command
    executer.startDetached()
  }

  function query(command, queryCallback) {
    callback = queryCallback
    runner.command = command

    runner.running = false
    runner.running = true
  }
}
