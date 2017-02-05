-- Generic libs
gears = require("gears") 
awful = require("awful") 
require("awful.autofocus") 
wibox = require("wibox")
beautiful = require("beautiful")
naughty = require("naughty") 
menubar = require("menubar") 
hotkeys_popup = require("awful.hotkeys_popup").widget
require("functions")

require("pre_config")
pcall(function() require("config") end)
require("post_config")

require("debian.menu")		-- Load Debian menu entries  
require("look")            -- Theme / Layouts
require("tags")             -- Tags
require("menu")             -- Menu
require("widgets")              -- Widgets
require("keys")           -- Mouse and Key bindings
require("rules")           -- rules for 1 Screen
require("signals")              -- signals
require("startup")            -- Autostart
