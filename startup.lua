-- {{{ Startup

autorun_apps =
{
   'setxkbmap -layout "us,il" -variant ",lyx" -option ""',
   "nm-applet"
}
for app = 1, #autorun_apps do
   awful.util.spawn(app)
end

-- }}}
