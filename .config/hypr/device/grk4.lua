------------------
---- MONITORS ----
------------------

hl.monitor({
  output = "eDP-1",
  mode = "3840x2160@60",
  position = "3840x0",
  scale = 2.0,
})

----------------
---- INPUT ----
----------------

hl.gesture({
  fingers = 3,
  direction = "horizontal",
  action = "workspace",
})

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
  hl.bind(mainMod .. " + " .. key, hl.dsp.exec_cmd('hyprctl hyprpaper wallpaper "eDP-1,' .. path .. '"'))
end
