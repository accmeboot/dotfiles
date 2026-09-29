''
  /* Taken from https://github.com/djpohly/dwl/issues/466, premultiplied by
   * alpha since wlroots blends rects as premultiplied (opaque colors are unchanged) */
  #define COLOR(hex)    { ((hex >> 24) & 0xFF) / 255.0f * (hex & 0xFF) / 255.0f, \
                          ((hex >> 16) & 0xFF) / 255.0f * (hex & 0xFF) / 255.0f, \
                          ((hex >> 8) & 0xFF) / 255.0f * (hex & 0xFF) / 255.0f, \
                          (hex & 0xFF) / 255.0f }
  /* appearance */
  static const int sloppyfocus               = 1;  /* focus follows mouse */
  static const int bypass_surface_visibility = 0;  /* 1 means idle inhibitors will disable idle tracking even if it's surface isn't visible  */
  static const unsigned int borderpx         = 1;  /* border pixel of windows */
  /* gaps (patches/gaps.patch) */
  static const int smartgaps                 = 0;  /* 1 means no outer gap when there is only one window */
  static int gaps                            = 1;  /* 1 means gaps between windows are added */
  static const unsigned int gappx            = 8;  /* gap pixel between windows */
  static const unsigned int snap             = 32; /* snap pixel */
  /* polarity-neutral: same gray for both themes, focus only differs in alpha */
  static const float rootcolor[]             = COLOR(0x222222ff);
  static const float bordercolor[]           = COLOR(0x80808060);
  static const float focuscolor[]            = COLOR(0x808080d0);
  static const float urgentcolor[]           = COLOR(0xd05050ff);
  /* This conforms to the xdg-protocol. Set the alpha to zero to restore the old behavior */
  static const float fullscreen_bg[]         = {0.0f, 0.0f, 0.0f, 1.0f}; /* You can also use glsl colors */

  /* tagging - TAGCOUNT must be no greater than 31 */
  #define TAGCOUNT (9)

  /* logging */
  static int log_level = WLR_ERROR;

  static const Rule rules[] = {
  	/* app_id             title       tags mask     isfloating   monitor */
  	/* no-op placeholder: the array can't be empty, and dialogs still float
  	 * since applyrules() ORs in client_is_float_type() afterwards */
  	{ NULL,               NULL,       0,            0,           -1 },
  };

  /* layout(s) */
  static const Layout layouts[] = {
  	/* symbol     arrange function */
  	{ "[]=",      tile },
  	{ "><>",      NULL },    /* no layout function means floating behavior */
  	{ "[M]",      monocle },
  };

  /* monitors */
  /* (x=-1, y=-1) is reserved as an "autoconfigure" monitor position indicator
   * WARNING: negative values other than (-1, -1) cause problems with Xwayland clients due to
   * https://gitlab.freedesktop.org/xorg/xserver/-/issues/899 */
  static const MonitorRule monrules[] = {
     /* name        mfact  nmaster scale layout       rotate/reflect                x    y
      * example of a HiDPI laptop monitor:
      { "eDP-1",    0.5f,  1,      2,    &layouts[0], WL_OUTPUT_TRANSFORM_NORMAL,   -1,  -1 }, */
  	{ NULL,       0.55f, 1,      1,    &layouts[0], WL_OUTPUT_TRANSFORM_NORMAL,   -1,  -1 },
  	/* default monitor rule: can be changed but cannot be eliminated; at least one monitor rule must exist */
  };

  /* keyboard */
  static const struct xkb_rule_names xkb_rules = {
  	/* can specify fields: rules, model, layout, variant, options */
  	/* example:
  	.options = "ctrl:nocaps",
  	*/
  	.layout = "us,ru",
  	.options = "grp:alt_shift_toggle",
  };

  static const int repeat_rate = 25;
  static const int repeat_delay = 600;

  /* Trackpad */
  static const int tap_to_click = 0;
  static const int tap_and_drag = 1;
  static const int drag_lock = 1;
  static const int natural_scrolling = 1;
  static const int disable_while_typing = 1;
  static const int left_handed = 0;
  static const int middle_button_emulation = 0;
  /* You can choose between:
  LIBINPUT_CONFIG_SCROLL_NO_SCROLL
  LIBINPUT_CONFIG_SCROLL_2FG
  LIBINPUT_CONFIG_SCROLL_EDGE
  LIBINPUT_CONFIG_SCROLL_ON_BUTTON_DOWN
  */
  static const enum libinput_config_scroll_method scroll_method = LIBINPUT_CONFIG_SCROLL_2FG;

  /* You can choose between:
  LIBINPUT_CONFIG_CLICK_METHOD_NONE
  LIBINPUT_CONFIG_CLICK_METHOD_BUTTON_AREAS
  LIBINPUT_CONFIG_CLICK_METHOD_CLICKFINGER
  */
  static const enum libinput_config_click_method click_method = LIBINPUT_CONFIG_CLICK_METHOD_CLICKFINGER;

  /* You can choose between:
  LIBINPUT_CONFIG_SEND_EVENTS_ENABLED
  LIBINPUT_CONFIG_SEND_EVENTS_DISABLED
  LIBINPUT_CONFIG_SEND_EVENTS_DISABLED_ON_EXTERNAL_MOUSE
  */
  static const uint32_t send_events_mode = LIBINPUT_CONFIG_SEND_EVENTS_ENABLED;

  /* You can choose between:
  LIBINPUT_CONFIG_ACCEL_PROFILE_FLAT
  LIBINPUT_CONFIG_ACCEL_PROFILE_ADAPTIVE
  */
  static const enum libinput_config_accel_profile accel_profile = LIBINPUT_CONFIG_ACCEL_PROFILE_ADAPTIVE;
  static const double accel_speed = 0.0;

  /* Scroll multiplier for touchpad (finger) scrolling (patches/input-config.patch) */
  static const double scroll_factor = 0.1;

  /* Mouse, i.e. any pointer without tap support (patches/input-config.patch) */
  static const int mouse_natural_scrolling = 0;
  static const enum libinput_config_accel_profile mouse_accel_profile = LIBINPUT_CONFIG_ACCEL_PROFILE_FLAT;
  static const double mouse_accel_speed = 0.0;

  /* Pointer devices to disable, by libinput name (patches/input-config.patch) */
  static const char *const disabled_devices[] = {
  	"Sony Interactive Entertainment DualSense Edge Wireless Controller Touchpad",
  	"DualSense Edge Wireless Controller Touchpad",
  };

  /* You can choose between:
  LIBINPUT_CONFIG_TAP_MAP_LRM -- 1/2/3 finger tap maps to left/right/middle
  LIBINPUT_CONFIG_TAP_MAP_LMR -- 1/2/3 finger tap maps to left/middle/right
  */
  static const enum libinput_config_tap_button_map button_map = LIBINPUT_CONFIG_TAP_MAP_LRM;

  /* If you want to use the windows key for MODKEY, use WLR_MODIFIER_LOGO */
  #define MODKEY WLR_MODIFIER_LOGO

  #define TAGKEYS(KEY,TAG) \
  	{ MODKEY,                    KEY,            view,            {.ui = 1 << TAG} }, \
  	{ MODKEY|WLR_MODIFIER_CTRL,  KEY,            toggleview,      {.ui = 1 << TAG} }, \
  	{ MODKEY|WLR_MODIFIER_SHIFT, KEY,            tag,             {.ui = 1 << TAG} }, \
  	{ MODKEY|WLR_MODIFIER_CTRL|WLR_MODIFIER_SHIFT,KEY,toggletag,  {.ui = 1 << TAG} }

  /* helper for spawning shell commands in the pre dwm-5.0 fashion */
  #define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

  /* commands */
  static const char *termcmd[] = { "ghostty", NULL };
  static const char *menucmd[] = { "qs", "-c", "mesa-shell", "ipc", "call", "dmenu", "toggle", NULL };

  static const Key keys[] = {
  	/* modifier                  key                  function          argument */
  	{ MODKEY,                    XKB_KEY_p,           spawn,            {.v = menucmd} },
  	{ MODKEY|WLR_MODIFIER_SHIFT, XKB_KEY_Return,      spawn,            {.v = termcmd} },
  	{ MODKEY,                    XKB_KEY_j,           focusstack,       {.i = +1} },
  	{ MODKEY,                    XKB_KEY_k,           focusstack,       {.i = -1} },
  	{ MODKEY,                    XKB_KEY_i,           incnmaster,       {.i = +1} },
  	{ MODKEY,                    XKB_KEY_d,           incnmaster,       {.i = -1} },
  	{ MODKEY,                    XKB_KEY_h,           setmfact,         {.f = -0.05f} },
  	{ MODKEY,                    XKB_KEY_l,           setmfact,         {.f = +0.05f} },
  	{ MODKEY,                    XKB_KEY_Return,      zoom,             {0} },
  	{ MODKEY,                    XKB_KEY_Tab,         view,             {0} },
  	{ MODKEY|WLR_MODIFIER_SHIFT, XKB_KEY_c,           killclient,       {0} },
  	{ MODKEY,                    XKB_KEY_t,           setlayout,        {.v = &layouts[0]} },
  	{ MODKEY,                    XKB_KEY_f,           setlayout,        {.v = &layouts[1]} },
  	{ MODKEY,                    XKB_KEY_m,           setlayout,        {.v = &layouts[2]} },
  	{ MODKEY,                    XKB_KEY_space,       setlayout,        {0} },
  	{ MODKEY|WLR_MODIFIER_SHIFT, XKB_KEY_space,       togglefloating,   {0} },
  	{ MODKEY,                    XKB_KEY_e,           togglefullscreen, {0} },
  	{ MODKEY,                    XKB_KEY_0,           view,             {.ui = ~0} },
  	{ MODKEY|WLR_MODIFIER_SHIFT, XKB_KEY_0,           tag,              {.ui = ~0} },
  	{ MODKEY,                    XKB_KEY_comma,       focusmon,         {.i = WLR_DIRECTION_LEFT} },
  	{ MODKEY,                    XKB_KEY_period,      focusmon,         {.i = WLR_DIRECTION_RIGHT} },
  	{ MODKEY|WLR_MODIFIER_SHIFT, XKB_KEY_comma,       tagmon,           {.i = WLR_DIRECTION_LEFT} },
  	{ MODKEY|WLR_MODIFIER_SHIFT, XKB_KEY_period,      tagmon,           {.i = WLR_DIRECTION_RIGHT} },
  	TAGKEYS(                     XKB_KEY_1,           0),
  	TAGKEYS(                     XKB_KEY_2,           1),
  	TAGKEYS(                     XKB_KEY_3,           2),
  	TAGKEYS(                     XKB_KEY_4,           3),
  	TAGKEYS(                     XKB_KEY_5,           4),
  	TAGKEYS(                     XKB_KEY_6,           5),
  	TAGKEYS(                     XKB_KEY_7,           6),
  	TAGKEYS(                     XKB_KEY_8,           7),
  	TAGKEYS(                     XKB_KEY_9,           8),
  	{ MODKEY|WLR_MODIFIER_SHIFT, XKB_KEY_q,           quit,             {0} },

  	/* volume via PipeWire */
  	{ 0, XKB_KEY_XF86AudioMute,        spawn, SHCMD("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle") },
  	{ 0, XKB_KEY_XF86AudioLowerVolume, spawn, SHCMD("wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-") },
  	{ 0, XKB_KEY_XF86AudioRaiseVolume, spawn, SHCMD("wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 1%+") },
  	{ 0, XKB_KEY_XF86AudioMicMute,     spawn, SHCMD("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle") },

  	/* media via playerctl */
  	{ 0, XKB_KEY_XF86AudioPlay,        spawn, SHCMD("playerctl play-pause") },
  	{ 0, XKB_KEY_XF86AudioPause,       spawn, SHCMD("playerctl play-pause") },
  	{ 0, XKB_KEY_XF86AudioPrev,        spawn, SHCMD("playerctl previous") },
  	{ 0, XKB_KEY_XF86AudioNext,        spawn, SHCMD("playerctl next") },
  	{ 0, XKB_KEY_XF86AudioStop,        spawn, SHCMD("playerctl stop") },

  	/* brightness via brightnessctl */
  	{ 0, XKB_KEY_XF86MonBrightnessDown, spawn, SHCMD("brightnessctl set 1%-") },
  	{ 0, XKB_KEY_XF86MonBrightnessUp,   spawn, SHCMD("brightnessctl set 1%+") },

  	/* mesa-shell panels */
  	{ MODKEY, XKB_KEY_a, spawn, SHCMD("qs -c mesa-shell ipc call panel toggle audio") },
  	{ MODKEY, XKB_KEY_s, spawn, SHCMD("qs -c mesa-shell ipc call panel toggle tray") },
  	{ MODKEY, XKB_KEY_q, spawn, SHCMD("qs -c mesa-shell ipc call panel toggle power") },
  	{ MODKEY, XKB_KEY_bracketleft, spawn, SHCMD("qs -c mesa-shell ipc call notifications dismissLast") },

  	/* screenshots */
  	{ 0,                  XKB_KEY_Print, spawn, SHCMD("${../../scripts/screenshot-full.sh}") },
  	{ WLR_MODIFIER_SHIFT, XKB_KEY_Print, spawn, SHCMD("${../../scripts/screenshot-area.sh}") },

  	/* Ctrl-Alt-Backspace and Ctrl-Alt-Fx used to be handled by X server */
  	{ WLR_MODIFIER_CTRL|WLR_MODIFIER_ALT,XKB_KEY_BackSpace, quit, {0} },
  	/* Ctrl-Alt-Fx is used to switch to another VT, if you don't know what a VT is
  	 * do not remove them.
  	 */
  #define CHVT(n) { WLR_MODIFIER_CTRL|WLR_MODIFIER_ALT,XKB_KEY_F##n, chvt, {.ui = (n)} }
  	CHVT(1), CHVT(2), CHVT(3), CHVT(4), CHVT(5), CHVT(6),
  	CHVT(7), CHVT(8), CHVT(9), CHVT(10), CHVT(11), CHVT(12),
  };

  static const Button buttons[] = {
  	{ MODKEY, BTN_LEFT,   moveresize,     {.ui = CurMove} },
  	{ MODKEY, BTN_MIDDLE, togglefloating, {0} },
  	{ MODKEY, BTN_RIGHT,  moveresize,     {.ui = CurResize} },
  };

  static const Axis axes[] = {
  	/* example of volume control:
  	{ MODKEY, AxisUp,   spawn, SHCMD("volume-up_EXAMPLE") },
  	{ MODKEY, AxisDown, spawn, SHCMD("volume-down_EXAMPLE") }, */
  	{ 0, 0, NULL, {0} },
  	/* does nothing, but the array cannot be empty */
  };
''
