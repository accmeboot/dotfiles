{ ... }: {
  home.file.".config/aerospace/aerospace.toml".text = ''
    after-login-command = []
    after-startup-command = []
    start-at-login = true

    # Normalizations. See: https://nikitabobko.github.io/AeroSpace/guide#normalization
    enable-normalization-flatten-containers = true
    enable-normalization-opposite-orientation-for-nested-containers = true

    accordion-padding = 10
    default-root-container-layout = 'tiles'
    default-root-container-orientation = 'auto'
    on-focused-monitor-changed = ['move-mouse monitor-lazy-center']
    automatically-unhide-macos-hidden-apps = false

    [key-mapping]
        preset = 'qwerty'

    [gaps]
        inner.horizontal = 4
        inner.vertical =   4
        outer.left =       10
        outer.bottom =     10
        outer.top =        10
        outer.right =      10

    [mode.main.binding]
        alt-q = 'exec-and-forget open -n -a "ghostty"'
        alt-c = 'close'
        alt-f = 'layout floating tiling'
        alt-e = 'macos-native-fullscreen'
        alt-s = 'layout tiles vertical horizontal'
        alt-m = 'layout tiles accordion'

        alt-h = 'focus left'
        alt-j = 'focus down'
        alt-k = 'focus up'
        alt-l = 'focus right'

        alt-shift-h = 'move left'
        alt-shift-j = 'move down'
        alt-shift-k = 'move up'
        alt-shift-l = 'move right'

        alt-minus = 'resize smart -50'
        alt-equal = 'resize smart +50'

        alt-1 = 'workspace 1'
        alt-2 = 'workspace 2'
        alt-3 = 'workspace 3'
        alt-4 = 'workspace 4'
        alt-5 = 'workspace 5'
        alt-6 = 'workspace 6'
        alt-7 = 'workspace 7'
        alt-8 = 'workspace 8'
        alt-9 = 'workspace 9'

        alt-shift-1 = 'move-node-to-workspace 1'
        alt-shift-2 = 'move-node-to-workspace 2'
        alt-shift-3 = 'move-node-to-workspace 3'
        alt-shift-4 = 'move-node-to-workspace 4'
        alt-shift-5 = 'move-node-to-workspace 5'
        alt-shift-6 = 'move-node-to-workspace 6'
        alt-shift-7 = 'move-node-to-workspace 7'
        alt-shift-8 = 'move-node-to-workspace 8'
        alt-shift-9 = 'move-node-to-workspace 9'

        alt-tab = 'workspace-back-and-forth'

        alt-shift-right = 'move-node-to-monitor --focus-follows-window right'
        alt-shift-left = 'move-node-to-monitor --focus-follows-window left'
        alt-shift-up = 'move-node-to-monitor --focus-follows-window up'
        alt-shift-down = 'move-node-to-monitor --focus-follows-window down'

        alt-shift-tab = 'move-workspace-to-monitor --wrap-around next'

        alt-shift-semicolon = 'mode service'


    [mode.service.binding]
        esc = ['reload-config', 'mode main']
        r = ['flatten-workspace-tree', 'mode main'] # reset layout
        f = ['layout floating tiling', 'mode main'] # Toggle between floating and tiling layout
        backspace = ['close-all-windows-but-current', 'mode main']

        alt-shift-h = ['join-with left', 'mode main']
        alt-shift-j = ['join-with down', 'mode main']
        alt-shift-k = ['join-with up', 'mode main']
        alt-shift-l = ['join-with right', 'mode main']

        down = 'volume down'
        up = 'volume up'
        shift-down = ['volume set 0', 'mode main']

    [[on-window-detected]]
    if.app-id = 'com.apple.finder'
    run = 'layout floating'


    [[on-window-detected]]
    if.app-id = 'com.apple.Notes'
    run = 'layout floating'
  '';
}
