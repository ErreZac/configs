local wezterm = require 'wezterm'
local os = require("os")

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
    color_scheme = "rose-pine",
    use_fancy_tab_bar = false,
    hide_tab_bar_if_only_one_tab = true,
    window_decorations = "NONE",
    tab_bar_at_bottom = true,
    adjust_window_size_when_changing_font_size = false,
    default_cursor_style = 'BlinkingBlock',
    cursor_blink_ease_in = "Constant",
    cursor_blink_ease_out = "Constant",
    cursor_blink_rate = 500,
    colors = {
        foreground = '#e0def4',
        background = '#191724',
        tab_bar = {
            background = '#1f1d2e',
            active_tab = {
                bg_color = '#403d52',
                fg_color = '#e0def4',
                intensity = 'Normal',
                underline = 'None',
                italic = false,
                strikethrough = false,
            },
            inactive_tab = {
                bg_color = '#1f1d2e',
                fg_color = '#908caa',
            },
            inactive_tab_hover = {
                bg_color = '#26233a',
                fg_color = '#e0def4',
            },
            new_tab = {
                bg_color = '#1f1d2e',
                fg_color = '#908caa',
            },
            new_tab_hover = {
                bg_color = '#26233a',
                fg_color = '#e0def4',
                italic = true,
            },
        },
        copy_mode_active_highlight_bg = { Color = '#c4a7e7' },
        copy_mode_active_highlight_fg = { Color = '#1f1d2e' },
        copy_mode_inactive_highlight_bg = { Color = '#26233a' },
        copy_mode_inactive_highlight_fg = { Color = '#e0def4' },
        selection_bg = '#f6c177',
        selection_fg = '#1f1d2e',
    },
    font = wezterm.font("Fira Code Nerd Font", {weight=Retina}),
    harfbuzz_features = { 'calt=1', 'clig=1', 'liga=1' },
    font_size=22,
    leader = { key = 'Space', mods = 'CTRL', timeout_milliseconds = 1000 },

        disable_default_key_bindings = true,
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
