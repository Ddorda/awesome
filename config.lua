-- Configurations

config.widgets.enable = Set {'kbswitch', 'volume', 'battery'}

config.keyboard.switch_keys = {{ "Mod1" }, "space"}

-- Programs
config.programs.terminal = "x-terminal-emulator"
config.programs.editor = os.getenv("EDITOR") or "vim"
