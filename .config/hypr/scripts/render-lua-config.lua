local files = {
  { "hyprland.lua", "hyprland.conf" },
  { "hyprpaper.lua", "hyprpaper.conf" },
  { "dms/layout.lua", "dms/layout.conf" },
  { "dms/windowrules.lua", "dms/windowrules.conf" },
  { "device/grk4.lua", "device/grk4.conf" },
  { "device/desktop_wall.lua", "device/desktop_wall.conf" },
  { "device/zigboi.lua", "device/zigboi.conf" },
  { "device/desktop.lua", "device/desktop.conf" },
  { "device/slate.lua", "device/slate.conf" },
  { "device/grk4_wall.lua", "device/grk4_wall.conf" },
  { "device/slate_wall.lua", "device/slate_wall.conf" },
}

local function read_source(path)
  local chunk, load_err = loadfile(path)
  if not chunk then
    error(string.format("failed to load %s: %s", path, load_err))
  end

  local ok, content = pcall(chunk)
  if not ok then
    error(string.format("failed to evaluate %s: %s", path, content))
  end
  if type(content) ~= "string" then
    error(string.format("%s must return a string", path))
  end

  return content
end

local function write_file(path, content)
  local handle, open_err = io.open(path, "w")
  if not handle then
    error(string.format("failed to open %s: %s", path, open_err))
  end

  local ok, write_err = handle:write(content)
  if not ok then
    handle:close()
    error(string.format("failed to write %s: %s", path, write_err))
  end

  local close_ok, close_err = handle:close()
  if not close_ok then
    error(string.format("failed to close %s: %s", path, close_err))
  end
end

for _, pair in ipairs(files) do
  local source = pair[1]
  local target = pair[2]
  write_file(target, read_source(source))
end
