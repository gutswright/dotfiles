-- Laptop setup.

hl.monitor({
  output = "eDP-1",
  mode = "3840x2160@60",
  position = "0x0",
  scale = 2,
})

hl.gesture({
  fingers = 3,
  direction = "horizontal",
  action = "workspace",
})

require("device.common")

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
