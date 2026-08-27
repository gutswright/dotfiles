-- Native Hyprland Lua config.
-- See https://wiki.hypr.land/Configuring/Start/

local hostname = assert(os.getenv 'HOSTNAME', 'HOSTNAME is not set')
local devices = {
  desktop = true,
  grk4 = true,
  slate = true,
  zigboi = true,
}

assert(devices[hostname], 'Unsupported hostname: ' .. hostname)
require('device.' .. hostname)

-- For Noctalia Color templates
require('noctalia').apply_theme()

-- # source = ~/dotfiles/.config/hypr/device/$HOSTNAME.conf # device specific
-- # source = ~/dotfiles/.config/hypr/device/grk4.conf # device specific
-- # source = ~/.config/hypr/device/desktop.conf # device specific
-- # source = ~/.config/hypr/device/zigboi.conf # device specific
--
-- ################
-- ### MONITORS ###
-- ################
--
-- # See https://wiki.hyprland.org/Configuring/Monitors/
-- # TODO blade specific
-- # monitor=eDP-1, 3840x2160@60, auto,2.0
-- # monitor=,preferred,auto,1
--
-- ###################
-- ### MY PROGRAMS ###
-- ###################
--
-- # Set programs that you use
-- $terminal = ghostty
-- $fileManager = dolphin
-- $menu = $(tofi-drun)
--
-- #################
-- ### AUTOSTART ###
-- #################
--
-- # exec-once = hyprpaper &
-- exec-once = wl-paste --type text --watch cliphist store
-- exec-once = wl-paste --type image --watch cliphist store
-- # exec-once = ~/dotfiles/.config/hypr/scripts/change_wallpaper.sh
-- exec-once = dms run
-- exec-once = dms ipc call wallpaper next
-- exec-once = hyprctl setcursor Adwaita 24
--
--
-- #############################
-- ### ENVIRONMENT VARIABLES ###
-- #############################
--
-- env = XCURSOR_SIZE,24
-- env = XCURSOR_THEME,Adwaita
-- # env = HYPRCURSOR_SIZE,24
--
--
-- #####################
-- ### LOOK AND FEEL ###
-- #####################
--
-- cursor {
--   inactive_timeout = 0
--   no_hardware_cursors = true
--   enable_hyprcursor = false
-- }
