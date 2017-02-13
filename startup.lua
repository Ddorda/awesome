-- {{{ Startup

for app = 1, #config.autorun_apps do
	local cur_app = config.autorun_apps[app]
	-- notice no output == nil
	local test_output = io.popen(cur_app.test):read("*l")
	if cur_app.test_func(test_output, cur_app.expected) then
	   awful.spawn(cur_app.cmd)
	end
end

-- }}}
