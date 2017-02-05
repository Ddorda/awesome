local music = {}

music.template_cmd = "rhythmbox-client %s"
music.toggle_cmd = "--play-pause"
music.next_cmd = "--next"
music.prev_cmd = "--previous"
music.next_key = {{ }, "XF86AudioNext"}
music.toggle_key = {{ }, "XF86AudioPlay"}
music.prev_key = {{ }, "XF86AudioPrev"}


music.control = function(self, command)
	awful.spawn(string.format(self.template_cmd, command))
end

music.toggle = function(self)
	self:control(self.toggle_cmd)
end

music.next = function(self)
	self:control(self.next_cmd)
end

music.prev = function(self)
	self:control(self.prev_cmd)
end

music._init = function()
	add_key(music.next_key, function () config.widgets.libs.music:next() end)
	add_key(music.toggle_key, function () config.widgets.libs.music:toggle() end)
	add_key(music.prev_key, function () config.widgets.libs.music:prev() end)
	return
end

return music