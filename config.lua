-- Configurations

config.widgets.enable = Set {'kbswitch', 'volume', 'battery'}

f = io.open("/tmp/output", "a")
f:write(#config.widgets.enable)
f:close()

config.keyboard.switch_keys = {{ "Mod1" }, "space"}

-- Programs
config.programs.terminal = "x-terminal-emulator"
config.programs.editor = os.getenv("EDITOR") or "vim"
