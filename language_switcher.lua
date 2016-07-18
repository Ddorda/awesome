-- Language switcher
kbdcfg = {}
kbdcfg.widget = wibox.widget.textbox()
kbdcfg.switch = function ()
  local current_kb
  current_kb = io.popen("xkb-switch -p -n"):read("*l")
  kbdcfg.widget:set_text(" " .. current_kb .. " ")
end
kbdcfg.set_layout = function(layout)
  local current_kb
  io.popen("xkb-switch -s " .. layout)
  current_kb = io.popen("xkb-switch -p"):read("*l")
  kbdcfg.widget:set_text(" " .. current_kb .. " ")
  if (current_kb == layout) then
    return true 
  end
    return false
end
