-- {{{ Menu
-- Create a laucher widget and a main menu
editor_cmd = config.programs.terminal .. " -e " .. config.programs.editor
myawesomemenu = {
   { "manual", config.programs.terminal .. " -e man awesome" },
   { "hotkeys", function() return false, hotkeys_popup.show_help end},
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end}
}

mymainmenu = awful.menu({ items = {
  { "awesome", myawesomemenu, beautiful.awesome_icon },
    { "Debian", debian.menu.Debian_menu.Debian },
    { "open terminal", config.programs.terminal }
  }
})

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = config.programs.terminal -- Set the terminal for applications that require it
-- }}}