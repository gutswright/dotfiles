-- Desktop NixOS setup.

hl.monitor({
  output = "DP-2",
  mode = "3840x2160@60",
  position = "3840x0",
  scale = 1,
})

hl.monitor({
  output = "DP-4",
  mode = "3840x2160@60",
  position = "0x0",
  scale = 1,
})

hl.workspace_rule({
  workspace = "3",
  monitor = "DP-2",
})

hl.on("hyprland.start", function()
  hl.exec_cmd("ghostty")
end)

require("device.common")
