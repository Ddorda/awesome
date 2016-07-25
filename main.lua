-- Generic libs
gears = require("gears") 
awful = require("awful") 
awful.rules = require("awful.rules") 
awful.autofocus = require("awful.autofocus") 
wibox = require("wibox")
beautiful = require("beautiful")
naughty = require("naughty") 
menubar = require("menubar") 

beautiful.init(confdir .. "/theme.lua")
require('pre_config')
require("config")
require('post_config')

require("debian.menu")		-- Load Debian menu entries  
require("look")            -- Theme / Layouts
require("tags")             -- Tags
require("menu")             -- Menu
require("widgets")              -- Widgets
require("keys")           -- Mouse and Key bindings
require("rules")           -- rules for 1 Screen
require("signals")              -- signals
require("startup")            -- Autostart
