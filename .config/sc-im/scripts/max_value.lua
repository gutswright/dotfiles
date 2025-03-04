-- max_value.lua
function main()
  local max_val = nil
  local col = curcol() -- Get current column

  for r = 1, maxrows() do
    local val = get(r, col)
    if val and tonumber(val) then
      val = tonumber(val)
      if max_val == nil or val > max_val then
        max_val = val
      end
    end
  end

  print('Maximum Value: ' .. (max_val or 'No numeric values'))
end
