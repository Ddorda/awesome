-- {{{ Startup

EQ_FUNC = function(test_o, expected_o) return test_o == expected_o end
NE_FUNC = function(test_o, expected_o) return test_o ~= expected_o end

autorun_apps =
{
   {['cmd'] = 'nm-applet',
      ['test'] = 'pgrep nm-applet',
      ['test_func'] = EQ_FUNC,
      ['expected'] = nil},
   {['cmd'] = config.keyboard.init_cmd,
      ['test'] = 'echo',
      ['test_func'] = EQ_FUNC,
      ['expected'] = nil}
}

for app = 1, #autorun_apps do
	local cur_app = autorun_apps[app]
	-- notice no output == nil
	local test_output = io.popen(cur_app.test):read("*l")
	if cur_app.test_func(test_output, cur_app.expected) then
	   awful.spawn(cur_app.cmd)
	end
end

-- }}}
