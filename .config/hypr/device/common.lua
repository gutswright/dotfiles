-- Configuration shared by every machine. Device files should contain only
-- monitor layout, hardware-specific settings, and machine-specific autostart.

local terminal = "ghostty"
local main_mod = "SUPER"
local hyper_mod = main_mod .. " + ALT + CTRL + SHIFT"

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("MOZ_ENABLE_WAYLAND", "1")
hl.env("GDK_BACKEND", "wayland,x11,*")
hl.env("SDL_VIDEODRIVER", "wayland")
hl.env("CLUTTER_BACKEND", "wayland")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("XCURSOR_SIZE", "24")
hl.env("XCURSOR_THEME", "Adwaita")

-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
  hl.exec_cmd("dms run")
  hl.exec_cmd("dms ipc call wallpaper next")
  hl.exec_cmd("hyprctl setcursor Adwaita 24")
end)

-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
  cursor = {
    inactive_timeout = 0,
    no_hardware_cursors = 2,
    enable_hyprcursor = false,
  },

  general = {
    gaps_in = 2,
    gaps_out = 3,
    border_size = 4,
    col = {
      active_border = { colors = { "rgba(ffbb00cc)", "rgba(0db6ffff)" }, angle = 45 },
      inactive_border = "rgba(595959aa)",
    },
    resize_on_border = false,
    allow_tearing = false,
    layout = "dwindle",
  },

  decoration = {
    rounding = 10,
    active_opacity = 1.0,
    inactive_opacity = 1.0,
    blur = {
      enabled = true,
      size = 12,
      passes = 4,
      vibrancy = 0.1696,
    },
  },

  animations = {
    enabled = true,
  },

  dwindle = {
    preserve_split = true,
  },

  misc = {
    force_default_wallpaper = -1,
    disable_hyprland_logo = false,
  },

  input = {
    kb_layout = "us",
    follow_mouse = 1,
    repeat_rate = 80,
    repeat_delay = 165,
    sensitivity = 0,
    touchpad = {
      natural_scroll = true,
      scroll_factor = 0.3,
    },
  },
})

hl.curve("myBezier", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })
hl.curve("linear", { type = "bezier", points = { { 0.0, 0.0 }, { 1.0, 1.0 } } })

hl.animation({ leaf = "windows", enabled = true, speed = 7, bezier = "myBezier" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 7, bezier = "default", style = "popin 80%" })
hl.animation({ leaf = "border", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "fade", enabled = true, speed = 7, bezier = "default" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 80, bezier = "linear", style = "loop" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 6, bezier = "default" })

hl.device({
  name = "epic-mouse-v1",
  sensitivity = -0.5,
})

---------------------
---- KEYBINDINGS ----
---------------------

hl.bind(main_mod .. " + C", hl.dsp.window.close(), { description = "Close window" })
hl.bind(hyper_mod .. " + C", hl.dsp.window.close())
hl.bind(main_mod .. " + D", hl.dsp.exec_cmd("codex-desktop"), { description = "Open Codex" })
hl.bind(
  main_mod .. " + E",
  hl.dsp.exec_cmd("dms ipc call spotlight toggleWith files"),
  { description = "Search files" }
)
hl.bind(
  main_mod .. " + F",
  hl.dsp.exec_cmd("firefox-developer-edition || firefox-devedition"),
  { description = "Open Firefox Developer Edition" }
)
hl.bind("SHIFT + ALT + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
hl.bind(hyper_mod .. " + G", hl.dsp.exec_cmd("chromium --force-device-scale-factor=1.3"))
hl.bind(hyper_mod .. " + K", hl.dsp.exec_cmd("hyprctl kill"), { description = "Select a window to kill" })
hl.bind(main_mod .. " + M", hl.dsp.exec_cmd("dms ipc call bar toggle index 0"), { description = "Toggle bar" })
hl.bind(main_mod .. " + O", hl.dsp.layout("togglesplit"), { description = "Toggle split direction" })
hl.bind(hyper_mod .. " + O", hl.dsp.exec_cmd("obsidian"), { description = "Open Obsidian" })
hl.bind(main_mod .. " + P", hl.dsp.exec_cmd("hyprpicker | wl-copy"), { description = "Pick color" })
hl.bind(hyper_mod .. " + P", hl.dsp.exec_cmd("hyprpicker | wl-copy"))
hl.bind(main_mod .. " + Q", hl.dsp.exec_cmd(terminal), { description = "Open terminal" })
hl.bind(
  main_mod .. " + R",
  hl.dsp.exec_cmd("dms ipc call spotlight toggleWith apps"),
  { description = "Open application launcher" }
)
hl.bind(main_mod .. " + T", hl.dsp.window.float({ action = "toggle" }), { description = "Toggle floating" })
hl.bind(
  hyper_mod .. " + V",
  hl.dsp.exec_cmd("dms ipc call clipboard toggle"),
  { description = "Open clipboard history" }
)
hl.bind(main_mod .. " + Z", hl.dsp.exec_cmd(terminal))
hl.bind(hyper_mod .. " + Z", hl.dsp.exec_cmd(terminal))

hl.bind(main_mod .. " + S", hl.dsp.exec_cmd("dms screenshot region"), { description = "Capture a region" })

hl.bind(
  main_mod .. " + Insert",
  hl.dsp.exec_cmd([[sh -c 'touch /tmp/whisper-live-translate.no-wtype; pkill -x wtype || true']]),
  { description = "Stop live translation typing" }
)
hl.bind(
  "Insert",
  hl.dsp.exec_cmd("fish ~/.config/fish/scripts/whisper-live-translate.fish"),
  { description = "Toggle live translation" }
)

local directions = {
  { key = "Down", direction = "down", short = "d" },
  { key = "Left", direction = "left", short = "l" },
  { key = "Right", direction = "right", short = "r" },
  { key = "Up", direction = "up", short = "u" },
}

for _, item in ipairs(directions) do
  hl.bind(main_mod .. " + " .. item.key, hl.dsp.focus({ direction = item.direction }))
  hl.bind("ALT + " .. item.key, hl.dsp.exec_cmd("hyprctl dispatch swapwindow " .. item.short))
end

hl.bind(main_mod .. " + H", hl.dsp.focus({ workspace = "-1" }))
hl.bind(main_mod .. " + J", hl.dsp.window.move({ workspace = "-1" }))
hl.bind(main_mod .. " + K", hl.dsp.window.move({ workspace = "+1" }))
hl.bind(main_mod .. " + apostrophe", hl.dsp.focus({ workspace = "+1" }))

hl.bind(main_mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(main_mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- hl.bind(
--   "XF86MonBrightnessDown",
--   hl.dsp.exec_cmd("dms ipc call brightness decrement 5"),
--   { locked = true, repeating = true }
-- )
-- hl.bind(
--   "XF86MonBrightnessUP",
--   hl.dsp.exec_cmd("dms ipc call brightness increment 5"),
--   { locked = true, repeating = true }
-- )

hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("dms ipc call audio decrement 5"), { locked = true, repeating = true })
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("dms ipc call audio increment 5"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("dms ipc call audio mute"), { locked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("dms ipc call mic mute"), { locked = true })

-- hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("dms ipc call mpris playPause"), { locked = true })
-- hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("dms ipc call mpris previous"), { locked = true })
-- hl.bind("XF86AudioNext", hl.dsp.exec_cmd("dms ipc call mpris next"), { locked = true })
--
-- Give hot-plugged, otherwise-unmatched monitors a usable default layout.
-- hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1 })
