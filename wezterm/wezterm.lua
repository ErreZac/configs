local wezterm = require 'wezterm'
local os = require("os")

-- local theme = require "themes/wezterm.lua"

local function is_vim(pane)
    -- this is set by the plugin, and unset on ExitPre in Neovim
    return pane:get_user_vars().IS_NVIM == 'true'
end

local direction_keys = {
    Left = 'h',
    Down = 'j',
    Up = 'k',
    Right = 'l',
    -- reverse lookup
    h = 'Left',
    j = 'Down',
    k = 'Up',
    l = 'Right',
}

local function split_nav(resize_or_move, key)
    return {
        key = key,
        mods = resize_or_move == 'resize' and 'META' or 'CTRL',
        action = wezterm.action_callback(function(win, pane)
            if is_vim(pane) then
                -- pass the keys through to vim/nvim
                win:perform_action({
                    SendKey = { key = key, mods = resize_or_move == 'resize' and 'META' or 'CTRL' },
                }, pane)
            else
                if resize_or_move == 'resize' then
                    win:perform_action({ AdjustPaneSize = { direction_keys[key], 3 } }, pane)
                else
                    win:perform_action({ ActivatePaneDirection = direction_keys[key] }, pane)
                end
            end
        end),
    }
end

return {
    -- color_scheme = "gruvbox-dark",
    use_fancy_tab_bar = false,
    hide_tab_bar_if_only_one_tab = true,
    window_decorations = "NONE",
    tab_bar_at_bottom = true,
    adjust_window_size_when_changing_font_size = false,
    default_cursor_style = 'BlinkingBlock',
    cursor_blink_ease_in = "Constant",
    cursor_blink_ease_out = "Constant",
    cursor_blink_rate = 500,
    enable_wayland = true,
    -- colors = require('wezterm/lua/rose-pine-moon').colors(),
    font = wezterm.font("JetBrains Mono Nerd Font", {weight=Retina}),
    -- font = wezterm.font("EasyReadingPRO"),
    harfbuzz_features = { 'calt=1', 'clig=1', 'liga=1' },
    font_size=15,
    leader = { key = 'Space', mods = 'CTRL', timeout_milliseconds = 1000 },

    disable_default_key_bindings = true,
    -- color_scheme = theme,
    -- window_background_gradient = {
    --     -- Can be "Vertical" or "Horizontal".  Specifies the direction
    --     -- in which the color gradient varies.  The default is "Horizontal",
    --     -- with the gradient going from left-to-right.
    --     -- Linear and Radial gradients are also supported; see the other
    --     -- examples below
    --     orientation = 'Horizontal',
    --
    --     colors = {
    --         '#191724',
    --         '#232136',
    --         '#232136',
    --         '#2a273f',
    --         '#31748f',
    --     },
    --
    --     -- Instead of specifying `colors`, you can use one of a number of
    --     -- predefined, preset gradients.
    --     -- A list of presets is shown in a section below.
    --     -- preset = "Warm",
    --
    --     -- Specifies the interpolation style to be used.
    --     -- "Linear", "Basis" and "CatmullRom" as supported.
    --     -- The default is "Linear".
    --     interpolation = 'Basis',
    --
    --     -- How the colors are blended in the gradient.
    --     -- "Rgb", "LinearRgb", "Hsv" and "Oklab" are supported.
    --     -- The default is "Rgb".
    --     blend = 'Rgb',
    --
    --     -- To avoid vertical color banding for horizontal gradients, the
    --     -- gradient position is randomly shifted by up to the `noise` value
    --     -- for each pixel.
    --     -- Smaller values, or 0, will make bands more prominent.
    --     -- The default value is 64 which gives decent looking results
    --     -- on a retina macbook pro display.
    --     -- noise = 64,
    --
    --     -- By default, the gradient smoothly transitions between the colors.
    --     -- You can adjust the sharpness by specifying the segment_size and
    --     -- segment_smoothness parameters.
    --     -- segment_size configures how many segments are present.
    --     -- segment_smoothness is how hard the edge is; 0.0 is a hard edge,
    --     -- 1.0 is a soft edge.
    --
    --     -- segment_size = 11,
    --     -- segment_smoothness = 0.0,
    -- },
    window_background_opacity = 1.0,
    color_scheme = 'rose-pine',

    keys = {
        {
            key = '+',
            mods = 'LEADER',
            action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
        },
        {
            key = '-',
            mods = 'LEADER',
            action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
        },
        {
            key = 'h',
            mods = 'CTRL',
            action = wezterm.action.ActivatePaneDirection 'Left',
        },
        {
            key = 'j',
            mods = 'CTRL',
            action = wezterm.action.ActivatePaneDirection 'Down',
        },
        {
            key = 'k',
            mods = 'CTRL',
            action = wezterm.action.ActivatePaneDirection 'Up',
        },
        {
            key = 'l',
            mods = 'CTRL',
            action = wezterm.action.ActivatePaneDirection 'Right',
        },
        {
            key = 'c',
            mods = 'LEADER',
            action = wezterm.action.SpawnTab 'CurrentPaneDomain',
        },
        {
            key = 'd',
            mods = 'LEADER',
            action = wezterm.action.CloseCurrentTab{ confirm = true },
        },
        {
            key = 'Enter',
            mods = 'SHIFT|ALT',
            action = wezterm.action.SpawnWindow,
        },
        {
            key = 'n',
            mods = 'LEADER',
            action = wezterm.action.ActivateTabRelative(1),

        },

        {
            key = 'p',
            mods = 'LEADER',
            action = wezterm.action.ActivateTabRelative(-1),

        },
        { key = '-', mods = 'CTRL', action = wezterm.action.DecreaseFontSize },
        { key = '+', mods = 'CTRL', action = wezterm.action.IncreaseFontSize },
        { key = '0', mods = 'CTRL', action = wezterm.action.ResetFontSize },
        { key = 's', mods = 'LEADER', action = wezterm.action.QuickSelect },
        { key = 'v', mods = 'LEADER', action = wezterm.action.ActivateCopyMode },
        -- move between split panes
        split_nav('move', 'h'),
        split_nav('move', 'j'),
        split_nav('move', 'k'),
        split_nav('move', 'l'),
        -- resize panes
        split_nav('resize', 'h'),
        split_nav('resize', 'j'),
        split_nav('resize', 'k'),
        split_nav('resize', 'l'),
    },
}
