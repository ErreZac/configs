local wezterm = require 'wezterm'
local os = require("os")

local move_around = function(window, pane, direction_wez, direction_nvim)
  local result = os.execute("env NVIM_LISTEN_ADDRESS=/tmp/nvim" .. pane:pane_id() ..  " wezterm.nvim.navigator " .. direction_nvim)
  if result then
		window:perform_action(wezterm.action({ SendString = "\x17" .. direction_nvim }), pane)
  else
		window:perform_action(wezterm.action({ ActivatePaneDirection = direction_wez }), pane)
  end
end

wezterm.on("move-left", function(window, pane)
	move_around(window, pane, "Left", "h")
end)

wezterm.on("move-right", function(window, pane)
	move_around(window, pane, "Right", "l")
end)

wezterm.on("move-up", function(window, pane)
	move_around(window, pane, "Up", "k")
end)

wezterm.on("move-down", function(window, pane)
	move_around(window, pane, "Down", "j")
end)

return {
    color_scheme = "rose-pine",
    use_fancy_tab_bar = false,
    hide_tab_bar_if_only_one_tab = true,
    window_decorations = "NONE",
    tab_bar_at_bottom = true,
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
    },
    font = wezterm.font("Fira Code Nerd Font", {weight=Retina}),
    font_size=20,
    leader = { key = 'Space', mods = 'CTRL', timeout_milliseconds = 1000 },
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
{ key = "h", mods = "CTRL", action = wezterm.action({ EmitEvent = "move-left" }) },
{ key = "l", mods = "CTRL", action = wezterm.action({ EmitEvent = "move-right" }) },
{ key = "k", mods = "CTRL", action = wezterm.action({ EmitEvent = "move-up" }) },
{ key = "j", mods = "CTRL", action = wezterm.action({ EmitEvent = "move-down" }) },
    },
}
