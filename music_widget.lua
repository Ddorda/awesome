music = {}
music.template_cmd = "rhythmbox-client %s"
music.toggle_cmd = "--play-pause"
music.next_cmd = "--next"
music.prev_cmd = "--previous"

music.control = function(self, command)
	awful.util.spawn(string.format(self.template_cmd, command))
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

