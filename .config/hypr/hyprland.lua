-- Native Hyprland Lua config.
-- See https://wiki.hypr.land/Configuring/Start/

local hostname = assert(os.getenv("HOSTNAME"), "HOSTNAME is not set")
local devices = {
  desktop = true,
  grk4 = true,
  slate = true,
  zigboi = true,
}

assert(devices[hostname], "Unsupported hostname: " .. hostname)
require("device." .. hostname)
