-- Desktop NVIDIA setup.

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

hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
hl.env("NVD_BACKEND", "direct")
hl.env("GBM_BACKEND", "nvidia-drm")

hl.on("hyprland.start", function()
  hl.exec_cmd("ghostty")
end)

require("device.common")
