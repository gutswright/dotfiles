------------------
---- MONITORS ----
------------------

hl.env("MOZ_ENABLE_WAYLAND", "1")

hl.monitor({
  output = "DP-1",
  mode = "3840x2160@60",
  position = "3840x0",
  scale = 1,
})

hl.monitor({
  output = "DP-3",
  mode = "3840x2160@60",
  position = "0x0",
  scale = 1,
})

hl.workspace_rule({
  workspace = "3",
  monitor = "DP-1",
})

-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
  hl.exec_cmd("ghostty")
end)

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("GDK_BACKEND", "wayland,x11,*")
hl.env("SDL_VIDEODRIVER", "wayland")
hl.env("CLUTTER_BACKEND", "wayland")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
hl.env("NVD_BACKEND", "direct")
hl.env("GBM_BACKEND", "nvidia-drm")

---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "MOD4"

local wallpapers = {
  [2] = "black_sand.jpg",
  [3] = "capital_reef_lightning.jpg",
  [4] = "sky_bridge.jpg",
  [5] = "coral_sunset.jpg",
  [6] = "dramatic_mountains.jpg",
  [7] = "dream_mountain_lake_sunset.jpg",
  [8] = "island_sunset.jpg",
  [9] = "light_bulb.jpg",
  [0] = "starry_night_sunset.jpg",
}

for key, file in pairs(wallpapers) do
  local path = "~/.config/hypr/wallpapers/" .. file
  hl.bind(mainMod .. " + " .. key, hl.dsp.exec_cmd('hyprctl hyprpaper wallpaper "DP-1,' .. path .. '"'))
  hl.bind(mainMod .. " + " .. key, hl.dsp.exec_cmd('hyprctl hyprpaper wallpaper "HDMI-A-1,' .. path .. '"'))
end

hl.bind(mainMod .. " + S", hl.dsp.exec_cmd([[grim -g "$(slurp)" - | satty --no-window-decoration --filename - --output-filename ~/Downloads/satty-$(date '+%Y%m%d-%H:%M:%S').png --copy-command wl-copy]]))
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("pavucontrol"))
