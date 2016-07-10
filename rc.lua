--stolen from http://www.markurashi.de/dotfiles/awesome/rc.lua

-- failsafe mode
-- if the current config fail, load the default rc.lua
-- You can debug it using:
--   Xephyr -ac -nolisten tcp -br -noreset -screen 800x600 :1
--   DISPLAY=:1.0 awesome

awful = require("awful")
naughty = require("naughty")

confdir = awful.util.getdir("config")
local rc, err = loadfile(confdir .. "/main.lua");
if rc then
    rc, err = pcall(rc);
    if rc then
        return;
    end
end

dofile("/etc/xdg/awesome/rc.lua");

for s = 1,screen.count() do
    mypromptbox[s].text = awful.util.escape(err:match("[^\n]*"));
end

naughty.notify{text="Awesome crashed during startup on " .. os.date("%d/%m/%Y %T:\n\n") ..  err .. "\n", timeout = 0}
