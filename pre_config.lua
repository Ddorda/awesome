-- DO NOT MODIFY

config = {}
config.keyboard = {}
config.theme = {}
config.programs = {}
config.layouts = {}
config.tags = { 1, 2, 3, 4, 5, 6, 7, 8, 9 }
config.widgets = {}
config.widgets.layouts = {}

--
-- Theme
--

-- init theme. can be modified on the fly
beautiful.init(confdir .. "/theme.lua")
config.theme = beautiful

--
-- Keyboard
--

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
config.keyboard.modkey = "Mod4"
config.keyboard._global_keys = {} -- don't use directly, instead use add_key()

-- will run on startup.
config.keyboard.init_cmd = 'setxkbmap -layout "us,il" -variant ",lyx" -option "grp:alt_space_toggle"'

function add_key(keys, func)
  config.keyboard._global_keys = awful.util.table.join(config.keyboard._global_keys, 
    awful.key(keys[1], keys[2], func))
end

config.programs.terminal = "x-terminal-emulator"
config.programs.editor = os.getenv("EDITOR") or "vim"


--
-- Startup 
--

config.autorun_apps =
{
   {['cmd'] = 'nm-applet',
      ['test'] = 'pgrep nm-applet',
      ['test_func'] = EQ_FUNC,
      ['expected'] = nil},
   {['cmd'] = config.keyboard.init_cmd,
      ['test'] = '',
      ['test_func'] = TRUE_FUNC, -- run anyway
      ['expected'] = nil}
}

--
-- Widgets
--

-- register widgets
config.widgets.libs = {}
config.widgets.enable = Set {}

justwidgets = scan_lua_files(confdir .. '/widgets')
for i=1, #justwidgets do
    local widget_name = justwidgets[i]:match("([a-zA-Z0-9_-]+)\.lua$")
    config.widgets.libs[widget_name] = require(".widgets." .. widget_name)
end

config.widgets.divider = wibox.widget.textbox(" | ")
config.widgets.systray = wibox.widget.systray()
config.widgets.keyboard = awful.widget.keyboardlayout()

config.widgets.layouts.right = {
  "config.widgets.systray",
  "config.widgets.divider",
  "config.widgets.libs.brightness.icon",
  "config.widgets.divider",
  "config.widgets.libs.volume.icon", -- volume
  "config.widgets.libs.volume.barmargin",
  "config.widgets.divider",
  "config.widgets.libs.battery.icon", -- battery
  "config.widgets.libs.battery.barmargin",
  "config.widgets.divider",
  "config.widgets.keyboard", -- keyboard
  "config.widgets.divider",
  "config.widgets.libs.clockal.clock_widget" -- clock+calendar
}