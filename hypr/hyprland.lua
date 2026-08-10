----------------------
------ MONITORS ------
----------------------
hl.monitor({
    output = "eDP-1",
    mode = "1920x1200",
    position = "0x0",
    scale = 1,
})

hl.monitor({
    output = "HDMI-A-1",
    mode = "preferred",
    position = "auto",
    scale = 1,
})

-- Workspaces
hl.workspace_rule({
    workspace = "1",
    monitor = "eDP-1",
})

hl.workspace_rule({
    workspace = "9",
    monitor = "HDMI-A-1",
})


---------------------
---- MY PROGRAMS ----
---------------------

local terminal    = "kitty"
local fileManager = "nautilus"
local menu        = "fuzzel --launch-prefix=\"uwsm app --\""


-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
    hl.exec_cmd("uwsm app -- waybar")
    hl.exec_cmd("uwsm app -- hyprpaper")
    hl.exec_cmd("uwsm app -- gnome-keyring-daemon --start")
end)


-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")


-----------------------
----- PERMISSIONS -----
-----------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Permissions/
-- Please note permission changes here require a Hyprland restart and are not applied on-the-fly
-- for security reasons

-- hl.config({
--   ecosystem = {
--     enforce_permissions = true,
--   },
-- })

-- hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")
-- hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")
-- hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")


-----------------------
---- LOOK AND FEEL ----
-----------------------

-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
    general = {
        gaps_in  = 1,
        gaps_out = 2,
        border_size = 2,

        col = {
            active_border   = {
                colors = {"rgba(004ec9b0)", "rgba(00c586c0)"},
                angle = 45
            },
            inactive_border = "rgba(00808080)",
        },

        resize_on_border = false,
        allow_tearing = false,
        layout = "scrolling",
    },

    decoration = {
        rounding       = 16,
        rounding_power = 2,

        -- Change transparency of focused and unfocused windows
        active_opacity   = 1.0,
        inactive_opacity = 0.9,

        shadow = {
            enabled      = true,
            range        = 50,
            render_power = 4,
            color        = "rgba(00202020)",
            color_inactive = "rgba(00202020)",
            offset = {5, 5},
        },

        blur = {
            enabled   = false,
            size      = 3,
            passes    = 1,
            vibrancy  = 0.1696,
        },
    },

    animations = {
        enabled = true,
    },
})

hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1}    } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1}    } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}       } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1}    } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1}     } })

-- Default springs
hl.curve("easy",           { type = "spring", mass = 1, stiffness = 238.1191, dampening = 24.21279333 })

hl.animation({ leaf = "global",        enabled = true,  speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",        enabled = true,  speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",       enabled = true,  speed = 4.79, spring = "easy" })
hl.animation({ leaf = "windowsIn",     enabled = true,  speed = 4.1,  spring = "easy",         style = "popin 87%" })
hl.animation({ leaf = "windowsOut",    enabled = true,  speed = 1.49, bezier = "linear",       style = "popin 87%" })
hl.animation({ leaf = "fadeIn",        enabled = true,  speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",       enabled = true,  speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade",          enabled = true,  speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers",        enabled = true,  speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",      enabled = true,  speed = 4,    bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true,  speed = 1.5,  bezier = "linear",       style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true,  speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true,  speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces",    enabled = true,  speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn",  enabled = true,  speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true,  speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor",    enabled = true,  speed = 7,    bezier = "quick" })

-- Ref https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
-- "Smart gaps" / "No gaps when only"
-- uncomment all if you wish to use that.
-- hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
-- hl.workspace_rule({ workspace = "f[1]",   gaps_out = 0, gaps_in = 0 })
-- hl.window_rule({
--     name  = "no-gaps-wtv1",
--     match = { float = false, workspace = "w[tv1]" },
--     border_size = 0,
--     rounding    = 0,
-- })
-- hl.window_rule({
--     name  = "no-gaps-f1",
--     match = { float = false, workspace = "f[1]" },
--     border_size = 0,
--     rounding    = 0,
-- })

-- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/ for more
hl.config({
    dwindle = {
        preserve_split = true, -- You probably want this
    },
})

-- See https://wiki.hypr.land/Configuring/Layouts/Master-Layout/ for more
hl.config({
    master = {
        new_status = "master",
    },
})

-- See https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/ for more
hl.config({
    scrolling = {
        fullscreen_on_one_column = true,
        column_width = 0.75,
        direction = right,
        focus_fit_method = 0,
    },
})

----------------
----  MISC  ----
----------------

hl.config({
    misc = {
        force_default_wallpaper = 1,    -- Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo   = true, -- If true disables the random hyprland logo / anime girl background. :(
        -- enable_swallos = true,
    },
})


---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout  = "it",
        kb_variant = "",
        kb_model   = "",
        kb_options = "",
        kb_rules   = "",
        follow_mouse = 1,
        sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.
        touchpad = {
            natural_scroll = false,
        },
    },
})

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace"
})

-- Example per-device config
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/ for more
hl.device({
    name        = "epic-mouse-v1",
    sensitivity = -0.5,
})


---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER" -- Sets "Windows" key as main modifier

-- Basic binds

hl.bind("SUPER + Return",
    hl.dsp.exec_cmd("uwsm app -- " .. terminal))

hl.bind("SUPER + SHIFT + C",
    hl.dsp.window.close())

hl.bind("SUPER + SHIFT + Q",
    hl.dsp.exit())

hl.bind("SUPER + SHIFT + F",
    hl.dsp.window.float({ action = "toggle" }))

hl.bind("SUPER + Space",
    hl.dsp.exec_cmd("uwsm app -- " .. menu))


-- Fits

hl.bind("SUPER + M",
    hl.dsp.layout("fit active"))

hl.bind("SUPER + A",
    hl.dsp.layout("fit all"))

hl.bind("SUPER + E",
    hl.dsp.layout("fit toend"))

hl.bind("SUPER + B",
    hl.dsp.layout("fit tobeg"))

hl.bind("SUPER + V",
    hl.dsp.layout("fit visible"))


-- Focus

hl.bind("SUPER + H",
    hl.dsp.layout("focus left"))

hl.bind("SUPER + J",
    hl.dsp.focus({ direction = "d" }))

hl.bind("SUPER + K",
    hl.dsp.focus({ direction = "u" }))

hl.bind("SUPER + L",
    hl.dsp.layout("focus right"))

hl.bind("SUPER + LEFT",
    hl.dsp.focus({ direction = "l" }))

hl.bind("SUPER + DOWN",
    hl.dsp.focus({ direction = "d" }))

hl.bind("SUPER + UP",
    hl.dsp.focus({ direction = "u" }))

hl.bind("SUPER + RIGHT",
    hl.dsp.focus({ direction = "r" }))


-- Move / swap windows

hl.bind("SUPER + ALT + H",
    hl.dsp.window.move({ direction = "l" }))

hl.bind("SUPER + ALT + J",
    hl.dsp.window.swap({ direction = "d" }))

hl.bind("SUPER + ALT + K",
    hl.dsp.window.swap({ direction = "u" }))

hl.bind("SUPER + ALT + L",
    hl.dsp.window.move({ direction = "r" }))


-- Column operations

hl.bind("SUPER + SHIFT + H",
    hl.dsp.layout("swapcol l"))

hl.bind("SUPER + SHIFT + J",
    hl.dsp.layout("swapcol r"))

hl.bind("SUPER + SHIFT + K",
    hl.dsp.layout("swapcol l"))

hl.bind("SUPER + SHIFT + L",
    hl.dsp.layout("swapcol r"))

hl.bind("SUPER + SHIFT + PERIOD",
    hl.dsp.layout("promote"))


-- Column resize

hl.bind("SUPER + CTRL + H",
    hl.dsp.layout("colresize -0.1"))

hl.bind("SUPER + CTRL + L",
    hl.dsp.layout("colresize +0.1"))

hl.bind("SUPER + CTRL + J",
    hl.dsp.layout("colresize -0.1"))

hl.bind("SUPER + CTRL + K",
    hl.dsp.layout("colresize +0.1"))


-- Fullscreen

hl.bind("SUPER + SHIFT + M",
    hl.dsp.window.fullscreen({ mode = 0 }))


-- Waybar

hl.bind("SUPER + SHIFT + R",
    hl.dsp.exec_cmd("~/.config/waybar/launch.sh"))


-- Screenshot

hl.bind("SUPER + P",
    hl.dsp.exec_cmd('uwsm app -- grim -g "$(slurp -d)" - | wl-copy'))

hl.bind("SUPER + SHIFT + P",
    hl.dsp.exec_cmd("/home/zac/.config/sway/cycle_profiles.sh"))

hl.bind("SUPER + CTRL + P",
    hl.dsp.exec_cmd(
        [[bash -c 'filename=$(wofi -d --allow-empty --lines 1 --prompt "Enter the screenshot name:"); slurp -d | grim -g - ~/Pictures/Screenshots/$filename.png']]
    ))

-- Function Keys Bindings

hl.bind(
    "XF86AudioRaiseVolume",
    hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_SINK@ 5%+"),
    { repeating = true }
)

hl.bind(
    "XF86AudioLowerVolume",
    hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_SINK@ 5%-"),
    { repeating = true }
)

hl.bind(
    "XF86AudioMute",
    hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_SINK@ toggle")
)

hl.bind(
    "XF86AudioMicMute",
    hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_SOURCE@ toggle")
)

hl.bind(
    "SHIFT + XF86AudioRaiseVolume",
    hl.dsp.exec_cmd("pactl set-source-volume @DEFAULT_SOURCE@ +5%"),
    { repeating = true }
)

hl.bind(
    "SHIFT + XF86AudioLowerVolume",
    hl.dsp.exec_cmd("pactl set-source-volume @DEFAULT_SOURCE@ -5%"),
    { repeating = true }
)

hl.bind(
    "XF86AudioPlay",
    hl.dsp.exec_cmd("playerctl play-pause")
)

hl.bind(
    "XF86AudioPause",
    hl.dsp.exec_cmd("playerctl play-pause")
)

hl.bind(
    "XF86AudioNext",
    hl.dsp.exec_cmd("playerctl next")
)

hl.bind(
    "XF86AudioPrev",
    hl.dsp.exec_cmd("playerctl previous")
)

hl.bind(
    "XF86MonBrightnessUp",
    hl.dsp.exec_cmd("brightnessctl -d intel_backlight s +10%"),
    { repeating = true }
)

hl.bind(
    "XF86MonBrightnessDown",
    hl.dsp.exec_cmd("brightnessctl -d intel_backlight s 10%-"),
    { repeating = true }
)


-- Switch workspaces with mainMod + [0-9]
--
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i}))
    hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end

-- Special workspace / scratchpad
--

hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Power

hl.bind(
    mainMod .. " + SHIFT + CTRL + Q",
    hl.dsp.exec_cmd("poweroff")
)

hl.bind(
    mainMod .. " + CTRL + SHIFT + L",
    hl.dsp.exec_cmd("hyprlock & disown; systemctl suspend")
)


--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- Example window rules that are useful

local suppressMaximizeRule = hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name  = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },
    no_focus = true,
})

-- Layer rules also return a handle.
-- local overlayLayerRule = hl.layer_rule({
--     name  = "no-anim-overlay",
--     match = { namespace = "^my-overlay$" },
--     no_anim = true,
-- })
-- overlayLayerRule:set_enabled(false)

-- Hyprland-run windowrule
hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },
    move  = "20 monitor_h-120",
    float = true,
})
