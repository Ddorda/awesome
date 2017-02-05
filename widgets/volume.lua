-- Volume widget
local volume = {}

volume.main_control = "Master"
volume.refresh_timeout = 120
volume.set_volume_cmd = "amixer set %s %s -D pulse"
volume.get_info_cmd = "amixer get "
volume.toggle_cmd = "toggle"
volume.raise_step = "5%+"
volume.lower_step = "5%-"
volume.state = ""
volume.level = 0
volume.raise_key = {{ }, "XF86AudioRaiseVolume"}
volume.lower_key = {{ }, "XF86AudioLowerVolume"}
volume.toggle_key = {{ }, "XF86AudioMute"}


--widget functions
volume.execute_and_update_widget = function(self, command)
  --execute given command, parse it and update the widget
  local current_line
  local stream = io.popen(command)

  current_line = stream:read("*l")
  while (current_line) do
    level, state = string.match(current_line, ".*%[(%d+)%%%].*%[([onf]+)%]")
    if level and state then
      break
    end
    current_line = stream:read("*l")
  end
  self.state = state
  self.level = tonumber(level)

  if state == 'off' or self.level == 0 then
    self.icon:set_image(beautiful.vol_off)
  else 
    self.icon:set_image(beautiful.vol_on)
  end

  self.bar:set_value(self.level)
end

volume.set_volume = function(self, control, amount)
  self:execute_and_update_widget(string.format(self.set_volume_cmd, control, amount))
end

volume.raise = function(self)
  self:set_volume(self.main_control, self.raise_step)
end

volume.lower = function(self)
  self:set_volume(self.main_control, self.lower_step)
end

volume.toggle = function(self)
  self:set_volume(self.main_control, self.toggle_cmd)
end


volume.refresh = function(self)
  self:execute_and_update_widget(self.get_info_cmd .. self.main_control)
end

--actual widget
volume._init = function()
  volume.icon = wibox.widget.imagebox(beautiful.vol_on)
  volume.bar = wibox.widget.progressbar() 
  volume.bar:set_ticks(true)
  volume.bar:set_ticks_size(1)
  volume.bar.forced_width = 48
  volume.bar:set_max_value(100)

  volume.bar:set_color(beautiful.fg_normal)
  volume.bar:set_background_color(beautiful.volume_bg)
  volume.layout = wibox.layout.fixed.horizontal()
  volume.layout:add(volume.bar)
  volume.barmargin = wibox.container.margin(volume.layout, 0, 2, 5, 6)
  volume:refresh()


  --TODO add dbus event
  -- timer declaration
  volume.timer = gears.timer({timeout = volume.refresh_timeout})
  volume.timer:connect_signal("timeout", function()  volume:refresh() end)
  volume.timer:start()

  -- volume keys
  add_key(volume.raise_key, function () volume:raise() end)
  add_key(volume.lower_key, function () volume:lower() end)
  add_key(volume.toggle_key, function () volume:toggle() end)
end

return volume
