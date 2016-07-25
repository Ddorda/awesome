-- DO NOT MODIFY

config = {}
config.keyboard = {}
config.theme = {}
config.programs = {}
config.layouts = {}
config.tags = { 1, 2, 3, 4, 5, 6, 7, 8, 9 }
config.widgets = {}

--
-- Keyboard
--

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
config.keyboard.modkey = "Mod4"

--
-- Theme
--

config.theme.path = "/usr/share/awesome/themes/default/theme.lua"


--
-- Widgets
--

-- register widgets
function scan_lua_files(dir)
    local files = {}
    local pfile = io.popen(string.format('ls %s/*.lua', dir))
    for line in pfile:lines() do
        table.insert(files, line)
    end
    pfile:close()
    table.sort(files)
    return files
end

function Set (list)
  local set = {}
  for _, l in ipairs(list) do set[l] = true end
  return set
end

function countSet(set)
  local count = 0
  for _ in pairs(set) do count = count + 1 end
  return count
end

config.widgets.libs = Set {}

justwidgets = scan_lua_files(confdir .. '/widgets')
for i=1, #justwidgets do
    local widget_name = justwidgets[i]:match("([a-zA-Z0-9_-]+)\.lua$")
    config.widgets.libs[widget_name] = require(".widgets." .. widget_name)
end

config.widgets.layouts = {}
config.widgets.divider = wibox.widget.textbox(" | ")