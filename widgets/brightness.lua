-- Brightness widget
-- based on our volume widget and https://github.com/velovix/awesome.brightness-widget

-- you may want to try using "acpilight" if xbacklight doesn't work, for backward-compatibility reasons.
-- can also be found in my git: https://github.com/Ddorda/acpilight

local brightness = {}

brightness.refresh_timeout = 5
brightness.step = 5
brightness.cmd = "xbacklight"
brightness.inc = "-inc"
brightness.dec = "-dec"
brightness.set = "-set"
brightness.get = "-get"
brightness.label = "%d%% Brightness"

--widget functions
brightness.execute_and_update_widget = function(self, command)
  --execute given command, parse it and update the widget
  run(command)
  self:refresh()
end

brightness.get_brightness = function(self)
  return run(self.cmd.." "..self.get)
end

brightness.brightness_cmd = function(self, control, amount)
  self:execute_and_update_widget(string.format("%s %s %s", self.cmd, control, amount))
end

brightness.set = function(self, amount)
  self:brightness_cmd(self.set, amount)
end

brightness.up = function(self)
  self:brightness_cmd(self.inc, self.step)
end

brightness.down = function(self)
  self:brightness_cmd(self.dec, self.step)
end

brightness.get_tooltip_text = function(self)
  return string.format(self.label, string.sub(self:get_brightness(), 0, 2))
end

brightness.refresh = function(self)
  local b = self:get_brightness()
  local level = math.floor((b/100)*7)
  self.icon:set_image(beautiful.brightness_prefix .. level .. beautiful.brightness_extension)
end

--actual widget
brightness._init = function()
  -- Create imagebox widget
  brightness.icon = wibox.widget.imagebox()
  brightness.icon:set_resize(false)
  brightness.icon:set_image(beautiful.brightness_prefix .. "4" .. beautiful.brightness_extension)

  -- Add a tooltip to the imagebox
  brightness.tooltip = awful.tooltip({ objects = { K },
    timer_function = function() return brightness:get_tooltip_text() end } )
  brightness.tooltip:add_to_object(brightness.icon)
  brightness:refresh()

  --TODO add dbus event
  -- timer declaration
  brightness.timer = timer({timeout = brightness.refresh_timeout})
  brightness.timer:connect_signal("timeout", function() brightness:refresh() end)
  brightness.timer:start()
end

return brightness
