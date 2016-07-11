-- {{{ Startup

autorun_apps =
{
   'setxkbmap -layout "us,il" -variant ",lyx" -option ""',
   "nm-applet",
   "xscreensaver -no-splash"
}
for app = 1, #autorun_apps do
   awful.util.spawn(app)
end

-- }}}
