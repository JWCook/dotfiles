local wezterm = require("wezterm")
local act = wezterm.action
local config = {}

-- Helper functions
----------------------------------------

local function split(direction)
    return wezterm.action_callback(function(window, pane)
        local cwd = pane:get_current_working_dir()
        window:perform_action(
            act.SplitPane({
                direction = direction,
                command = { cwd = cwd and cwd.file_path or nil },
            }),
            pane
        )
    end)
end

-- Using act.Multiple here doesn't work due to https://github.com/wezterm/wezterm/issues/4390
local function activate_quadrant(dir1, dir2)
    return wezterm.action_callback(function(window, pane)
        for _, pane_info in ipairs(window:active_tab():panes_with_info()) do
            if pane_info.is_zoomed then
                return
            end
        end
        window:perform_action(act.ActivatePaneDirection(dir1), pane)
        wezterm.sleep_ms(5)
        window:perform_action(act.ActivatePaneDirection(dir2), pane)
    end)
end

local function when_not_zoomed(action, passthrough)
    return wezterm.action_callback(function(window, pane)
        for _, pane_info in ipairs(window:active_tab():panes_with_info()) do
            if pane_info.is_zoomed then
                if passthrough then
                    window:perform_action(passthrough, pane)
                end
                return
            end
        end
        window:perform_action(action, pane)
    end)
end

-- OS-specific settings
----------------------------------------

local function getOS()
    -- ask LuaJIT first
    if jit then
        return jit.os
    end

    -- Unix, Linux variants
    local fh, err = assert(io.popen("uname -o 2>/dev/null", "r"))
    if fh then
        osname = fh:read()
    end

    return osname or "Windows"
end

if getOS() == "Windows" then
    config.default_prog = { "wsl", "~" }
else
    config.default_prog = { "/usr/bin/fish", "-l" }
end

--  Tabs & Windows
----------------------------------------

hide_tab_bar_if_only_one_tab = true
config.enable_scroll_bar = true
config.check_for_updates = false
config.scrollback_lines = 20000
config.window_close_confirmation = "NeverPrompt"
config.window_decorations = "RESIZE"

--  Colors & Fonts
----------------------------------------

-- config.color_scheme = 'Catppuccin Macchiato'
-- config.color_scheme = 'Everforest Dark (Gogh)'
-- config.color_scheme = 'Gruvbox dark, medium (base16)'
-- config.color_scheme = 'Monokai Remastered'
-- config.color_scheme = 'nord'
config.color_scheme = "Tokyo Night Storm"
config.font = wezterm.font("JetBrainsMono NF")
config.font_size = 14.0
config.window_background_opacity = 0.9
config.inactive_pane_hsb = {
    saturation = 0.7,
    brightness = 0.7,
}

config.window_background_gradient = {
    colors = {
        -- '#282828',
        "#3c3836",
        "#1d2021",
    },
    -- preset = 'Viridis',
    orientation = "Vertical",
    -- orientation = { Linear = { angle = -80.0 } },
}

-- Keybindings
----------------------------------------

config.keys = {
    -- Windows
    {
        key = "F11",
        action = act.ToggleFullScreen,
    },
    {
        key = "n",
        mods = "CTRL|SHIFT",
        action = act.SpawnWindow,
    },
    -- Tabs
    {
        key = "t",
        mods = "CTRL|SHIFT",
        action = act.SpawnTab("CurrentPaneDomain"),
    },
    {
        key = "w",
        mods = "CTRL",
        action = act({ CloseCurrentTab = { confirm = false } }),
    },
    {
        key = "Tab",
        mods = "CTRL",
        action = act({ ActivateTabRelative = 1 }),
    },
    {
        key = "Tab",
        mods = "CTRL|SHIFT",
        action = act({ ActivateTabRelative = -1 }),
    },
    {
        key = "PageDown",
        mods = "CTRL|SHIFT",
        action = act({ MoveTabRelative = 1 }),
    },
    {
        key = "PageUp",
        mods = "CTRL|SHIFT",
        action = act({ MoveTabRelative = -1 }),
    },
    -- Splits
    {
        key = "y",
        mods = "CTRL|SHIFT",
        action = when_not_zoomed(split("Right")),
    },
    {
        key = "h",
        mods = "CTRL|SHIFT",
        action = when_not_zoomed(split("Down")),
    },
    {
        key = "=",
        mods = "ALT",
        action = when_not_zoomed(split("Right")),
    },
    {
        key = "-",
        mods = "ALT",
        action = when_not_zoomed(split("Down")),
    },
    {
        key = "x",
        mods = "CTRL|SHIFT",
        action = act.TogglePaneZoomState,
    },
    {
        key = "Space",
        mods = "CTRL|SHIFT",
        action = act.ActivateCopyMode,
    },
    {
        key = "x",
        mods = "CTRL|SHIFT|ALT",
        action = act.TogglePaneZoomState,
    },
    {
        key = "LeftArrow",
        mods = "ALT",
        action = when_not_zoomed(act.ActivatePaneDirection("Left"), act.SendKey({ key = "LeftArrow", mods = "ALT" })),
    },
    {
        key = "RightArrow",
        mods = "ALT",
        action = when_not_zoomed(act.ActivatePaneDirection("Right"), act.SendKey({ key = "RightArrow", mods = "ALT" })),
    },
    {
        key = "UpArrow",
        mods = "ALT",
        action = when_not_zoomed(act.ActivatePaneDirection("Up"), act.SendKey({ key = "UpArrow", mods = "ALT" })),
    },
    {
        key = "DownArrow",
        mods = "ALT",
        action = when_not_zoomed(act.ActivatePaneDirection("Down"), act.SendKey({ key = "DownArrow", mods = "ALT" })),
    },
    {
        key = "LeftArrow",
        mods = "CTRL|ALT",
        action = when_not_zoomed(act.AdjustPaneSize({ "Left", 5 })),
    },
    {
        key = "RightArrow",
        mods = "CTRL|ALT",
        action = when_not_zoomed(act.AdjustPaneSize({ "Right", 5 })),
    },
    {
        key = "UpArrow",
        mods = "CTRL|ALT",
        action = when_not_zoomed(act.AdjustPaneSize({ "Up", 5 })),
    },
    {
        key = "DownArrow",
        mods = "CTRL|ALT",
        action = when_not_zoomed(act.AdjustPaneSize({ "Down", 5 })),
    },

    -- Direct quadrant mappings (for macros)
    {
        key = "F1",
        mods = "ALT|SHIFT",
        action = activate_quadrant("Up", "Left"),
    },
    {
        key = "F2",
        mods = "ALT|SHIFT",
        action = activate_quadrant("Up", "Right"),
    },
    {
        key = "F3",
        mods = "ALT|SHIFT",
        action = activate_quadrant("Down", "Left"),
    },
    {
        key = "F4",
        mods = "ALT|SHIFT",
        action = activate_quadrant("Down", "Right"),
    },
}

config.mouse_bindings = {
    -- On left mouse release, complete selection into primary selection only
    -- (not system clipboard). This replaces the default which uses
    -- CompleteSelectionOrOpenLinkAtMouseCursor('PrimarySelection').
    {
        event = { Up = { streak = 1, button = "Left" } },
        mods = "NONE",
        action = act.CompleteSelection("PrimarySelection"),
    },
    -- Mousewheel scroll distance
    {
        event = { Down = { streak = 1, button = { WheelUp = 1 } } },
        mods = "NONE",
        action = wezterm.action.ScrollByLine(-3),
    },
    {
        event = { Down = { streak = 1, button = { WheelDown = 1 } } },
        mods = "NONE",
        action = wezterm.action.ScrollByLine(3),
    },
    {
        event = { Down = { streak = 1, button = { WheelUp = 1 } } },
        mods = "CTRL",
        action = wezterm.action.ScrollByPage(-1),
    },
    {
        event = { Down = { streak = 1, button = { WheelDown = 1 } } },
        mods = "CTRL",
        action = wezterm.action.ScrollByPage(1),
    },
}

return config
