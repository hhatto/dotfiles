local wezterm = require 'wezterm'
local act = wezterm.action
local config = wezterm.config_builder()

config.initial_rows = 50
config.initial_cols = 250

config.selection_word_boundary = ' \t\n{}[]()"\'`,;:'
config.send_composed_key_when_left_alt_is_pressed = true
-- config.send_composed_key_when_right_alt_is_pressed = false

config.keys = {
  {
    key = "¥",
    action = wezterm.action.SendKey { key = '\\' }
  },
  -- clear session
  {
    key = 'k',
    mods = 'CMD',
    action = act.Multiple {
      act.ClearScrollback 'ScrollbackAndViewport',
      act.SendKey { key = 'L', mods = 'CTRL' },
    },
  },
  -- move tab
  {
    key = 'LeftArrow',
    mods = 'CTRL|SHIFT',
    action = wezterm.action{ MoveTabRelative = -1 },
  },
  {
    key = 'RightArrow',
    mods = 'CTRL|SHIFT',
    action = wezterm.action{ MoveTabRelative = 1 },
  },
}
config.window_background_opacity = 0.89

return config
