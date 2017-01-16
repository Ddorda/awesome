-- Language switcher
local kbswitch = {}

kbswitch.init_command = 'setxkbmap -layout "us,il" -variant ",lyx" -option ""'
kbswitch.primary_lang = 'us'

kbswitch.switch = function ()
  local current_kb
  current_kb = run("xkb-switch -p -n")
  kbswitch.widget:set_text(" " .. current_kb .. " ")
end
kbswitch.set_layout = function(layout)
  local current_kb
  run("xkb-switch -s " .. layout)
  current_kb = run("xkb-switch -p")
  kbswitch.widget:set_text(" " .. current_kb .. " ")
  if (current_kb == layout) then
    return true 
  end
    return false
end
kbswitch._init = function()
  awful.util.spawn(kbswitch.init_command)
  kbswitch.widget = wibox.widget.textbox()
  kbswitch.set_layout(kbswitch.primary_lang)
end
return kbswitch
