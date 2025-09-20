local wezterm = require 'wezterm'
local act = wezterm.action
local config = {}

-- OS-specific settings
----------------------------------------

local function getOS()
    -- ask LuaJIT first
    if jit then
        return jit.os
    end

    -- Unix, Linux variants
    local fh,err = assert(io.popen('uname -o 2>/dev/null','r'))
    if fh then
        osname = fh:read()
    end

    return osname or 'Windows'
end

if getOS() == 'Windows' then
    config.default_prog = { 'wsl', '~' }
else
    config.default_prog = {  '/usr/bin/fish', '-l' }
end


--  Tabs & Windows
----------------------------------------

hide_tab_bar_if_only_one_tab = true
config.enable_scroll_bar = true
config.window_close_confirmation = 'NeverPrompt'
config.window_decorations = 'RESIZE'


--  Colors & Fonts
----------------------------------------

-- config.color_scheme = 'Catppuccin Macchiato'
-- config.color_scheme = 'Everforest Dark (Gogh)'
-- config.color_scheme = 'Gruvbox dark, medium (base16)'
-- config.color_scheme = 'Monokai Remastered'
-- config.color_scheme = 'nord'
config.color_scheme = 'Tokyo Night Storm'
config.font = wezterm.font 'JetBrains Mono'
config.font_size = 14.0
config.window_background_opacity = 0.9

config.window_background_gradient = {
  colors = {
    -- '#282828',
    '#3c3836',
    '#1d2021',
  },
  -- preset = 'Viridis',
  orientation = 'Vertical',
  -- orientation = { Linear = { angle = -80.0 } },
}


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
        mods = 'CTRL|SHIFT',
        action = act.SpawnTab('CurrentPaneDomain'),
    },
    {
        key = 'w',
        mods = 'CTRL',
        action = act { CloseCurrentTab = { confirm = false } },
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
        key = 'y',
        mods = 'CTRL|SHIFT',
        action = act { SplitHorizontal = { domain = 'CurrentPaneDomain' } },
    },
    {
        key = 'h',
        mods = 'CTRL|SHIFT',
        action = act { SplitVertical = { domain = 'CurrentPaneDomain' } },
    },
    {
        key = 'x',
        mods = 'CTRL|SHIFT',
        action = act.TogglePaneZoomState,
    },
    {
        key = 'x',
        mods = 'CTRL|SHIFT|ALT',
        action = act.TogglePaneZoomState,
    },
    {
        key = 'LeftArrow',
        mods = 'CTRL|SHIFT',
        action = act { ActivatePaneDirection = 'Left' },
    },
    {
        key = 'RightArrow',
        mods = 'CTRL|SHIFT',
        action = act { ActivatePaneDirection = 'Right' },
    },
    {
        key = 'UpArrow',
        mods = 'CTRL|SHIFT',
        action = act { ActivatePaneDirection = 'Up' },
    },
    {
        key = 'DownArrow',
        mods = 'CTRL|SHIFT',
        action = act { ActivatePaneDirection = 'Down' },
    },
    {
        key = 'LeftArrow',
        mods = 'CTRL|ALT',
        action = act.AdjustPaneSize { 'Left', 5 },
    },
    {
        key = 'RightArrow',
        mods = 'CTRL|ALT',
        action = act.AdjustPaneSize { 'Right', 5 },
    },
    {
        key = 'UpArrow',
        mods = 'CTRL|ALT',
        action = act.AdjustPaneSize { 'Up', 5 },
    },
    {
        key = 'DownArrow',
        mods = 'CTRL|ALT',
        action = act.AdjustPaneSize { 'Down', 5 },
    },
}

return config
