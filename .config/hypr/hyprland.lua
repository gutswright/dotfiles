-- Native Hyprland Lua config.
-- See https://wiki.hypr.land/Configuring/Start/

local hostname = os.getenv("HOSTNAME")
require("device." .. hostname)

---------------------
---- MY PROGRAMS ----
---------------------

local terminal = "ghostty"
local fileManager = "dolphin"
local menu = "tofi-drun"
local mainMod = "MOD4"
-- local hyperMod = mainMod .. " + Alt_r + Control_L + Shift_R"
local hyperMod = mainMod .. " + ALT + CTRL + SHIFT"

-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
  hl.exec_cmd("wl-paste --type text --watch cliphist store")
  hl.exec_cmd("wl-paste --type image --watch cliphist store")
  hl.exec_cmd("dms run")
  hl.exec_cmd("dms ipc call wallpaper next")
  hl.exec_cmd("hyprctl setcursor Adwaita 24")
end)

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("XCURSOR_SIZE", "24")
hl.env("XCURSOR_THEME", "Adwaita")

-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
  cursor = {
    inactive_timeout = 0,
    no_hardware_cursors = true,
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

  master = {
    new_status = "master",
  },

  misc = {
    force_default_wallpaper = -1,
    disable_hyprland_logo = false,
  },

  input = {
    kb_layout = "us",
    kb_variant = "",
    kb_model = "",
    kb_options = "",
    kb_rules = "",

    follow_mouse = 1,
    repeat_rate = 80,
    repeat_delay = 165,
    sensitivity = 0,

    touchpad = {
      natural_scroll = true,
      scroll_factor = 0.3,
    },
  },

  xwayland = {
    force_zero_scaling = false,
  },
})

-- require_optional("dms.layout")

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

hl.bind(mainMod .. " + S", hl.dsp.exec_cmd([[grim -g "$(slurp)" - | swappy -f -]]))

hl.bind(mainMod .. " + F", hl.dsp.exec_cmd("firefox-developer-edition || firefox-devedition"))
hl.bind(hyperMod .. " + G", hl.dsp.exec_cmd("chromium --force-device-scale-factor=1.3"))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd("chromium --app=https://draw.rk4.dev --force-device-scale-factor=1.6 &"))

hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + Z", hl.dsp.exec_cmd(terminal))
hl.bind(hyperMod .. " + Z", hl.dsp.exec_cmd(terminal))
hl.bind(hyperMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd("hyprpicker | wl-copy"))
hl.bind(hyperMod .. " + P", hl.dsp.exec_cmd("hyprpicker | wl-copy"))
hl.bind(hyperMod .. " + K", hl.dsp.exec_cmd("hyprctl kill"))
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("dms ipc call bar toggle index 0"))

hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(hyperMod .. " + V", hl.dsp.exec_cmd("cliphist list | tofi | cliphist decode | wl-copy"))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + T", hl.dsp.window.float({ action = "toggle" }))

hl.bind(mainMod .. " + O", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))

hl.bind("Alt_r + Left", hl.dsp.exec_cmd("hyprctl dispatch swapwindow l"))
hl.bind("Alt_r + Down", hl.dsp.exec_cmd("hyprctl dispatch swapwindow d"))
hl.bind("Alt_r + Up", hl.dsp.exec_cmd("hyprctl dispatch swapwindow u"))
hl.bind("Alt_r + Right", hl.dsp.exec_cmd("hyprctl dispatch swapwindow r"))

hl.bind(mainMod .. " + Left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + Right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + Up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + Down", hl.dsp.focus({ direction = "down" }))

hl.bind(mainMod .. " + H", hl.dsp.focus({ workspace = "-1" }))
hl.bind(mainMod .. " + apostrophe", hl.dsp.focus({ workspace = "+1" }))
hl.bind(mainMod .. " + J", hl.dsp.window.move({ workspace = "-1" }))
hl.bind(mainMod .. " + K", hl.dsp.window.move({ workspace = "+1" }))

hl.bind("Shift_L + Alt_L + F", hl.dsp.exec_cmd("hyprctl dispatch fullscreen"))

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- SCREENBRIGHTNESS --
-- hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 10%-"), { locked = true, repeating = true })

hl.bind(
  "XF86MonBrightnessDown",
  hl.dsp.exec_cmd([[sh -c 'brightnessctl s "$(brightnessctl g | awk "{printf \"%.0f\", \$1/1.30}")"' ]]),
  { locked = true, repeating = true }
)

hl.bind(
  "XF86MonBrightnessUP",
  hl.dsp.exec_cmd([[sh -c 'brightnessctl s "$(brightnessctl g | awk "{printf \"%.0f\", \$1*1.30}")"' ]]),
  { locked = true, repeating = true }
)

-- SYSTEMVOLUME --
hl.bind(
  "XF86AudioLowerVolume",
  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 5%-"),
  { locked = true, repeating = true }
)

hl.bind(
  "XF86AudioRaiseVolume",
  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 5%+"),
  { locked = true, repeating = true }
)
