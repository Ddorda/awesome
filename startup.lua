-- {{{ Startup

EQ_FUNC = function(test_o, expected_o) return test_o == expected_o end
NE_FUNC = function(test_o, expected_o) return test_o ~= expected_o end

autorun_apps =
{
   {['cmd'] = 'setxkbmap -layout "us,il" -variant ",lyx" -option ""',
      ['test'] = 'setxkbmap -print -verbose| md5sum',
      ['test_func'] = NE_FUNC,
      ['expected'] = '364337ac32b1330c981fb61904e033a9  -'},
   {['cmd'] = 'nm-applet',
      ['test'] = 'pgrep nm-applet',
      ['test_func'] = EQ_FUNC,
      ['expected'] = nil},
   {['cmd'] = 'xscreensaver -no-splash',
      ['test'] = 'pgrep xscreensaver',
      ['test_func'] = EQ_FUNC,
      ['expected'] = nil}
}

for app = 1, #autorun_apps do
	local cur_app = autorun_apps[app]
	-- notice no output == nil
	local test_output = io.popen(cur_app.test):read("*l")
	if cur_app.test_func(test_output, cur_app.expected) then
	   awful.util.spawn(cur_app.cmd)
	end
end

kbdcfg.set_layout("us")

-- }}}
