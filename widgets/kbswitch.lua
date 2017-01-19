-- Language switcher
local kbswitch = {}

kbswitch.init_command = 'setxkbmap -layout "us,il" -variant ",lyx" -option ""'
kbswitch.primary_lang = 'us'
kbswitch.change_layout_keys = {{ "Mod1" }, "Shift_L"} -- {{ "Mod1" }, "space"}
kbswitch.label = " %s " -- %s is layout name
kbswitch.get_layout_cmd = "xkb-switch -p"
kbswitch.switch_cmd = kbswitch.get_layout_cmd .. " -n"
kbswitch.set_layout_cmd = "xkb-switch -s %s" -- %s is layout name


kbswitch.switch = function(self)
  local current_kb
  current_kb = run(self.switch_cmd)
  self.widget:set_text(string.format(self.label, current_kb))
end

kbswitch.set_layout = function(self, layout)
  local current_kb
  run(string.format(self.set_layout_cmd, layout))
  current_kb = run(self.get_layout_cmd)
  self.widget:set_text(string.format(self.label, current_kb))
  if (current_kb == layout) then return true end
  return false
end

kbswitch._init = function()
  awful.util.spawn(kbswitch.init_command)
  kbswitch.widget = wibox.widget.textbox()
  kbswitch:set_layout(kbswitch.primary_lang)
  add_key(kbswitch.change_layout_keys, function () kbswitch:switch() end)
end
return kbswitch
