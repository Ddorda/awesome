-- Language switcher
kbdcfg = {}
kbdcfg.widget = wibox.widget.textbox()
kbdcfg.switch = function ()
  current_kb = io.popen("xkb-switch -p -n"):read("*l")
  kbdcfg.widget:set_text(" " .. current_kb .. " ")
end
kbdcfg.switch()
