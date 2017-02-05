-- Battery widget
local battery = {}

battery.battery = "BAT1"
battery.ac = "ACAD"
battery.timeout = 30
battery.ps_path = "/sys/class/power_supply/"
battery.critical_precentage = 15
--widget functions
battery.read_file_line = function(self,file_path)
  local f
  f = io.open(file_path) 
  if f then
    local to_ret = f:read()
    f:close()
    return to_ret
  end
  return false

end

battery.is_ac = function(self)
  local ac_path = self.ps_path .. self.ac .. "/online"
  local ac_status = self:read_file_line(ac_path)
  if ac_status == "1" then
    return true
  end
  return false
end

battery.is_battery = function(self)
  local battery_path = self.ps_path .. self.battery .. "/present"
  local battery_status = self:read_file_line(battery_path)
  if battery_status == "1" then
    return true
  end
  return false
end

battery.battery_precentage = function(self)
  local battery_path = self.ps_path .. self.battery .. "/capacity"
  local battery_precentage = self:read_file_line(battery_path)
  if (battery_precentage) then
    return tonumber(battery_precentage)
  end
  return false
end

battery.refresh = function(self)
  if self:is_ac() then
    self.icon:set_image(beautiful.ac)
  elseif self:is_battery() then
    self.icon:set_image(beautiful.battery)
  else
    self.icon:set_image(beautiful.layout_max)
  end
  local precentage = self:battery_precentage()
  
  if (precentage < self.critical_precentage) then
    battery.bar:set_color(beautiful.battery_critical_fg)
  else
    battery.bar:set_color(beautiful.fg_normal)
  end
  self.bar:set_value(precentage)
end

--actual widget
battery._init = function()
  battery.icon = wibox.widget.imagebox(beautiful.battery)
  battery.bar = wibox.widget.progressbar() 
  battery.bar:set_ticks(true)
  battery.bar:set_ticks_size(5)
  battery.bar.forced_width = 48
  battery.bar:set_max_value(100)

  battery.bar:set_color(beautiful.fg_normal)
  battery.bar:set_background_color(beautiful.battery_bg)
  battery.layout = wibox.layout.fixed.horizontal()
  battery.layout:add(battery.bar)
  battery.barmargin = wibox.container.margin(battery.layout, 2, 2, 5, 6)
  battery:refresh()


  --TODO add dbus event
  -- timer declaration
  battery.timer = gears.timer({timeout = battery.timeout})
  battery.timer:connect_signal("timeout", function()  battery:refresh() end)
  battery.timer:start()
end

return battery
