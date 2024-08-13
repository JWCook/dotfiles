local wezterm = require 'wezterm'
local act = wezterm.action
local config = {}

hide_tab_bar_if_only_one_tab = true
config.enable_scroll_bar = true
config.default_prog = { '/usr/bin/fish', '-l' }


--  Colors & Fonts
----------------------------------------

config.color_scheme = 'Gruvbox dark, medium (base16)'
-- config.color_scheme = 'nord'
config.font = wezterm.font 'JetBrains Mono'
config.font_size = 14.0


-- Keybindings
----------------------------------------

config.keys = {
    -- Windows
    {
        key = 'F11',
        action = act.ToggleFullScreen,
    },
    {
        key = 'n',
        mods = 'CTRL|SHIFT',
        action = act.SpawnWindow,
    },
    -- Tabs
    {
        key = 't',
        mods = 'CTRL',
        action = act.SpawnTab "CurrentPaneDomain",
    },
    {
        key = 'w',
        mods = 'CTRL',
        action = act { CloseCurrentTab = { confirm = true } },
    },
    {
        key = 'Tab',
        mods = 'CTRL',
        action = act { ActivateTabRelative = 1 },
    },
    {
        key = 'Tab',
        mods = 'CTRL|SHIFT',
        action = act { ActivateTabRelative = -1 },
    },
    -- Splits
    {
        key = 'h',
        mods = 'CTRL|SHIFT',
        action = act { SplitHorizontal = { domain = "CurrentPaneDomain" } },
    },
    {
        key = 'y',
        mods = 'CTRL|SHIFT',
        action = act { SplitVertical = { domain = "CurrentPaneDomain" } },
    },
    {
        key = 'x',
        mods = 'CTRL|SHIFT',
        action = act.TogglePaneZoomState,
    },
    {
        key = 'LeftArrow',
        mods = 'ALT',
        action = act { ActivatePaneDirection = "Left" },
    },
    {
        key = 'RightArrow',
        mods = 'ALT',
        action = act { ActivatePaneDirection = "Right" },
    },
    {
        key = 'UpArrow',
        mods = 'ALT',
        action = act { ActivatePaneDirection = "Up" },
    },
    {
        key = 'DownArrow',
        mods = 'ALT',
        action = act { ActivatePaneDirection = "Down" },
    },

}

return config
