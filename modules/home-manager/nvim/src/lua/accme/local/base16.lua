local M = {}

function M.get_colors_from_yaml_file(filename)
  local file = io.open(filename, "r")
  if not file then
    return nil, "Failed to open file: " .. filename
  end

  local data = {}
  for line in file:lines() do
    local key, value = line:match("(%w+):%s*(.+)")
    if key and value then
      -- Strip quotes and whitespace from the value
      value = value:gsub('^%s*"', ''):gsub('"%s*$', '')
      value = value:gsub("^%s*'", ""):gsub("'%s*$", "")

      -- Add "#" prefix to base color values if missing
      if key:match("^base%x%x$") and not value:match("^#") then
        value = "#" .. value
      end

      data[key] = value
    end
  end

  file:close()

  return data
end

function M.adjust_color(hex, r_offset, g_offset, b_offset)
  local r = tonumber(hex:sub(2, 3), 16)
  local g = tonumber(hex:sub(4, 5), 16)
  local b = tonumber(hex:sub(6, 7), 16)

  r = math.max(0, math.min(255, r + r_offset))
  g = math.max(0, math.min(255, g + g_offset))
  b = math.max(0, math.min(255, b + b_offset))

  return string.format("#%02x%02x%02x", r, g, b)
end

-- Generate pink from base08 (red) by increasing blue
function M.get_pink(color)
  return M.adjust_color(color, 0, -16, 66)
end

return M
