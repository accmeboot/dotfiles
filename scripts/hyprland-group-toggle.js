#!/usr/bin/env node

import { exec } from "child_process";

class HyprlandGroups {
  windows = [];
  activeworkspace = null;

  get activeWorkspaceId() {
    return this.activeworkspace?.id ?? null;
  }

  get windowsInWorkspace() {
    return (
      this.windows?.filter((w) => w.workspace?.id === this.activeWorkspaceId) ??
      []
    );
  }

  async hypr(command, isDispatch) {
    return new Promise((resolve) => {
      const hypr = exec(`hyprctl ${isDispatch ? "dispatch" : ""} ${command}`);

      hypr.stdout.on("data", (data) => {
        resolve(data);
      });
    });
  }

  async isWindowGrouped(windowAddress) {
    const windows = await this.hypr("clients -j");

    const window = JSON.parse(windows)?.find(
      (w) => w.address === windowAddress,
    );

    return (
      window?.grouped &&
      Array.isArray(window.grouped) &&
      window.grouped.length > 0
    );
  }

  async read() {
    this.activeworkspace = JSON.parse(await this.hypr("activeworkspace -j"));
    this.windows = JSON.parse(await this.hypr("clients -j"));
  }

  async toggleIfAlreadyGroupedOrOnlyOne() {
    const isAlreadyGrouped = this.windowsInWorkspace?.some(
      (w) => w.grouped?.length > 0,
    );
    const isOnlyOneWindow = this.windowsInWorkspace?.length < 2;

    await this.hypr("togglegroup", true);

    return isAlreadyGrouped || isOnlyOneWindow;
  }

  async moveVacantWindowsIntoGroup() {
    for (let w of this.windowsInWorkspace) {
      if (await this.isWindowGrouped(w.address)) continue;

      const directions = ["l", "r", "u", "d"];

      await this.hypr(`dispatch focuswindow address:${w.address}`);

      for (let d of directions) {
        if (await this.isWindowGrouped(w.address)) break;

        await this.hypr(`dispatch moveintogroup ${d}`);
      }
    }
  }

  async toggle() {
    try {
      await this.read();

      const skip = await this.toggleIfAlreadyGroupedOrOnlyOne();
      if (skip) return;

      await this.moveVacantWindowsIntoGroup();
    } catch (e) {
      console.error(e);
    }
  }
}

new HyprlandGroups().toggle();
