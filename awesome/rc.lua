-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local lain  = require("lain")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

HOME = "/home/ledity/"

-- {{{ Autolaunch
awful.spawn("pkill picom")
awful.spawn("pkill nm-applet")
awful.spawn("pkill blueman-applet")
awful.spawn("pkill loloswitcher")
awful.spawn("xbindkeys -p")
awful.spawn("nm-applet")
awful.spawn("blueman-applet")
awful.spawn("picom")
awful.spawn("nitrogen --restore")
awful.spawn("pulsemixer --get-volume")
awful.spawn("loloswitcher")
awful.spawn("emacs --daemon")
-- }}}

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init(HOME .. ".config/awesome/theme.lua")

-- Default progs
terminal = "alacritty"
editor = "vim"
browser = "firefox"
filemanager = "pcmanfm-qt"
calculator = "kcalc"
musicplayer = terminal .. " -e cmus"
proglauncher = "rofi -show drun"
winchooser = "rofi -show window"
runpromt = "rofi -show run"
editor_cmd =  'emacsclient -c -a "emacs"'

-- Tag names

t1 = ""
t2 = ""
t3 = ""
t4 = ""
t5 = ""
t6 = ""
t7 = ""
t8 = "" 

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.max,
    awful.layout.suit.magnifier,
    awful.layout.suit.floating,
    -- awful.layout.suit.max.fullscreen,
    -- awful.layout.suit.spiral,
    -- awful.layout.suit.spiral.dwindle,
    -- awful.layout.suit.corner.nw,
    -- awful.layout.suit.tile.left,
    -- awful.layout.suit.tile.bottom,
    -- awful.layout.suit.fair,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
}
-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
ledawesomemenu = {
    { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
    { "manual", terminal .. " -e man awesome" },
    { "edit config", editor_cmd .. " " .. awesome.conffile },
    { "restart", awesome.restart },
    { "quit", function() awesome.quit() end },
}

beautiful.menu_width = 280
ledmainmenu = awful.menu({
    items = {
        { " awesome",         ledawesomemenu},
        { " open browser",          browser},
        { " open  terminal",        terminal},
        { " open file manager", filemanager},
        { " open calculator",    calculator},
    }
})

ledlauncher = awful.widget.launcher({ image = "/home/ledity/.config/awesome/icons/th-solid.svg",
                                      menu  = ledmainmenu })
launcher_buttons  = (gears.table.join(
   awful.button({ }, 1, function () awful.spawn(proglauncher) end)))

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- {{{ Wibar
-- Require awesome-wm-widgets
local cpu_aw_wm = require("awesome-wm-widgets.cpu-widget.cpu-widget")
-- Require noobie
-- local noobie_emxaple_1 = require("noobie")

-- Textclock widget
local ledtextclock = wibox.widget {
    {
        {
            text   = '  ',
            widget = wibox.widget.textbox,
        },
        {
            text   = '',
            font   = 'FontAwesome5 Free Solid 10',
            widget = wibox.widget.textbox,
        },
        {
            format = ' %d.%m | ',
            widget = wibox.widget.textclock
        },
        {
            text   = '',
            font   = 'FontAwesome5 Free Solid 10',
            widget = wibox.widget.textbox,
        },
        {
            format = ' %H:%M  ',
            widget = wibox.widget.textclock
        },
        layout = wibox.layout.fixed.horizontal,
    },
    shape  = gears.shape.rounded_bar,
    -- shape_border_color = beautiful.white,
    -- shape_border_width = 3,
    bg     = beautiful.light,
    widget = wibox.widget.background,
}

-- Keyboard map indicator and switcher
local ledkeyboardlayout = {
    {
        {
            markup = '  <span foreground="' .. beautiful.blue .. '" font = "FontAwesome5 Free Solid 10"></span> :',
            align  = 'center',
            valign = 'center',
            widget = wibox.widget.textbox,
        },
        {
            widget       = awful.widget.keyboardlayout(),
        },
        {
            text   = ' ',
            widget = wibox.widget.textbox,
        },
        layout = wibox.layout.fixed.horizontal,
    },
    shape  = gears.shape.rounded_bar,
    -- shape_border_color = beautiful.white,
    -- shape_border_width = 3,
    bg     = beautiful.light,
    widget = wibox.widget.background,


}

-- Kernel widget
local ledkernel = wibox.widget {
    {
        {
            markup = '  <span foreground="' .. beautiful.green .. '" font = "FontAwesome5 Free Solid 10"></span> : ',
            widget = wibox.widget.textbox,
        },
        {
            widget = awful.widget.watch("/home/ledity/.config/awesome/scripts/kernel.sh", 60),
        },
        {
            text   = '  ',
            widget = wibox.widget.textbox,
        },
        layout = wibox.layout.fixed.horizontal,
    },
    shape  = gears.shape.rounded_bar,
    -- shape_border_color = beautiful.white,
    -- shape_border_width = 3,
    bg     = beautiful.light,
    widget = wibox.widget.background,
}

-- Volume widget
local vol_buttons = gears.table.join(
                    awful.button({ }, 1, function()  awful.spawn(terminal .. " -e pulsemixer") end),
                    awful.button({ }, 2, function()  awful.spawn("pulsemixer --toggle-mute") end),
                    awful.button({ }, 3, function()  awful.spawn(terminal .. " -e pulsemixer") end),
                    awful.button({ }, 4, function()  awful.spawn("pulsemixer --change-volume +5") end),
                    awful.button({ }, 5, function()  awful.spawn("pulsemixer --change-volume -5") end)
                )
local ledvolume = {
    {
        {
            markup = '  ',
            widget = wibox.widget.textbox,
        },
        {
            {
                font   = "FontAwesome5 Free Solid",
                widget = awful.widget.watch("/home/ledity/.config/awesome/scripts/vol.sh", 1),
            },
            fg     = beautiful.salad,
            widget = wibox.container.background,
        },
        lain.widget.pulse {
            timeout = 0.5,
            devicetype = "sink",
            cmd = "pulsemixer --list-sinks | grep 'Default'",
            settings = function()
                vol = tonumber(volume_now.left) or 10
                icon = "<span foreground = '" .. beautiful.salad .. "' font_family='FontAwesome5 Free Solid'></span>"
                if volume_now.muted == "no" then
                    if     vol < 25 then
                        icon = "<span foreground = '" .. beautiful.salad .. "' font_family='FontAwesome5 Free Solid'></span>"
                    elseif vol >= 25 and vol < 85 then
                        icon = "<span foreground = '" .. beautiful.salad .. "' font_family='FontAwesome5 Free Solid'></span>"
                    elseif vol >= 85 then
                        icon = "<span foreground = '" .. beautiful.salad .. "' font_family='FontAwesome5 Free Solid'></span>"
                    end
                end
                widget:set_markup(" : " .. vol .. " %  ")
            end,
            buttons = vol_buttons,
        },
        buttons = vol_buttons,
        layout = wibox.layout.fixed.horizontal,
    },
    shape  = gears.shape.rounded_bar,
    -- shape_border_color = beautiful.white,
    -- shape_border_width = 3,
    bg = beautiful.light,
    widget = wibox.container.background,
}

-- Brightness widget
local brightness_buttons = gears.table.join(
                    awful.button({ }, 1, function()  awful.spawn("brightnessctl s 100%") end),
                    awful.button({ }, 2, function()  awful.spawn("brightnessctl s 30%") end),
                    awful.button({ }, 3, function()  awful.spawn("brightnessctl s 0%") end),
                    awful.button({ }, 4, function()  awful.spawn("brightnessctl s 5%+") end),
                    awful.button({ }, 5, function()  awful.spawn("brightnessctl s 5%-") end)
                )
local ledbrightness = {
    {
        -- {
        --     text    = '  ',
        --     widget  = wibox.widget.textbox,
        --     buttons = brightness_buttons,
        -- },
        {
            markup  = '  <span foreground="' .. beautiful.orange .. '" font = "FontAwesome5 Free Solid 10"></span> : ',
            align   = 'center',
            valign  = 'center',
            widget  = wibox.widget.textbox,
            buttons = brightness_buttons,
        },
        {
            widget  = awful.widget.watch("bash -c ~/.config/awesome/scripts/br.sh", 0.25),
            buttons = brightness_buttons,
        },
        {
            markup  = ' %  ',
            widget  = wibox.widget.textbox,
            buttons = brightness_buttons,
        },
        layout = wibox.layout.fixed.horizontal,
    },
    shape  = gears.shape.rounded_bar,
    -- shape_border_color = beautiful.white,
    -- shape_border_width = 3,
    bg      = beautiful.light,
    widget  = wibox.widget.background,
}

-- Tray widget
beautiful.bg_systray = beautiful.light
beautiful.icon_spacing = 5

local ledtray = {
    {
        {
            markup = '  <span foreground="' .. beautiful.pink .. '" font = "FontAwesome5 Free Solid 10"></span> : ',
            widget  = wibox.widget.textbox,
        },
        {
                base_size = 40,
                horizontal = true,
                widget = wibox.widget.systray,
        },
        {
            forced_width = 15,
            widget  = wibox.widget.textbox,
        },
        layout = wibox.layout.fixed.horizontal,
    },
    shape  = gears.shape.rounded_bar,
    -- shape_border_color = beautiful.white,
    -- shape_border_width = 3,
    bg = beautiful.light,
    widget = wibox.container.background,
}

-- Battery widget
local ledbattery = wibox.widget {
    {
        lain.widget.bat {
            battery = "BAT0",
            settings = function()
                icon = "<span font_family='FontAwesome5 Free Solid'></span>"

                if     bat_now.status == "Discharging" then
                    status = "<span font_family='FontAwesome5 Free Solid'></span>"
                elseif bat_now.status >= "Charging"    then
                    status = "<span font_family='FontAwesome5 Free Solid'></span>"
                elseif bat_now.status >= "Full"        then
                    status = "<span font_family='FontAwesome5 Free Solid'></span>"
                else
                    status = "<span font_family='FontAwesome5 Free Solid'></span>"
                end

                if bat_now.perc == "N/A" then
                    widget:set_markup("  " .. icon .." | <span font_family='FontAwesome5 Free Solid'></span>  ")
                else
                    perc = tonumber(bat_now.perc)
                    if     perc < 15 then
                        icon = "<span foreground = '" .. beautiful.orange .. "' font_family='FontAwesome5 Free Solid'></span>"
                    elseif perc >= 15 and perc < 35 then
                        icon = "<span foreground = '" .. beautiful.bluish .. "' font_family='FontAwesome5 Free Solid'></span>"
                    elseif perc >= 35 and perc < 65 then
                        icon = "<span foreground = '" .. beautiful.bluish .. "' font_family='FontAwesome5 Free Solid'></span>"
                    elseif perc >= 65 and perc < 85 then
                        icon = "<span foreground = '" .. beautiful.bluish .. "' font_family='FontAwesome5 Free Solid'></span>"
                    else
                        icon = "<span foreground = '" .. beautiful.bluish .. "' font_family='FontAwesome5 Free Solid'></span>"
                    end

                    widget:set_markup("  " .. icon .. " : " .. status .. " | " .. perc .. " %  ")
                end

            end
        },
        layout = wibox.layout.fixed.horizontal,
    },
    shape  = gears.shape.rounded_bar,
    -- shape_border_color = beautiful.white,
    -- shape_border_width = 3,
    bg = beautiful.light ,
    widget = wibox.container.background,
}

-- CPU widget
local ledcpu = wibox.widget {
    {
        {
            markup  = '  <span foreground="' .. beautiful.red .. '" font = "FontAwesome5 Free Solid 10"></span> : ',
            widget = wibox.widget.textbox,
        },
        cpu_aw_wm({
            width = 80,
        }),
        lain.widget.cpu {
            timeout = 1,
            settings = function()
                widget:set_markup(" | " .. cpu_now.usage .. " %  ")
            end,
        },
        layout = wibox.layout.fixed.horizontal,
    },
    shape  = gears.shape.rounded_bar,
    -- shape_border_color = beautiful.white,
    -- shape_border_width = 3,
    bg = beautiful.light,
    widget = wibox.container.background,
}

-- Memory widget
local ledmem = wibox.widget {
    {
        lain.widget.mem {
            timeout = 2,
            settings = function()
                icon = "<span foreground='" .. beautiful.yellow .. "' font_family='FontAwesome5 Free Solid'></span>"
                widget:set_markup("  " .. icon .." : " .. mem_now.used .. " MiB | " .. mem_now.perc .. " %  ")
            end,
        },
        layout = wibox.layout.fixed.horizontal,
    },
    bg     = beautiful.light,
    shape  = gears.shape.rounded_bar,
    -- shape_border_color = beautiful.border_color,
    -- shape_border_width = 3,
    widget = wibox.container.background,
}

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
                    awful.button({ }, 1, function(t) t:view_only() end),
                    awful.button({ modkey }, 1, function(t)
                                              if client.focus then
                                                  client.focus:move_to_tag(t)
                                              end
                                          end),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, function(t)
                                              if client.focus then
                                                  client.focus:toggle_tag(t)
                                              end
                                          end),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
                )

local tasklist_buttons = gears.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  c:emit_signal(
                                                      "request::activate",
                                                      "tasklist",
                                                      {raise = true}
                                                  )
                                              end
                                          end),
                     awful.button({ }, 3, function()
                                              awful.menu.client_list({ theme = { width = 250 } })
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                          end))

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    -- set_wallpaper(s)

    -- Each screen has its own tag table.
    awful.tag({ t1, t2, t3, t4, t5, t6, t7, t8 }, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.ledpromptbox = awful.widget.prompt {
        prompt = "$ ",
        shape  = gears.shape.rounded_bar,
        bg     = beautiful.light,
        font   = "MesloLGS NF 10",
    }
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.ledlayoutbox = awful.widget.layoutbox(s)
    s.ledlayoutbox:buttons(gears.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))

    -- Create a taglist widget
    s.ledtaglist    = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons,
        style   = {
            font = "FontAwesome5 Free Solid 10",
            shape = gears.shape.rounded_bar,
        },
        layout  = {
            spacing = 10,
            spacing_widget = {
                {
                    forced_width  = 12,
                    forced_height = 5,
                    color         = beautiful.light,
                    shape         = gears.shape.partially_rounded_rect,
                    widget        = wibox.widget.separator
                },
                valign = "center",
                halign = "center",
                widget = wibox.container.place,
            },
            layout  = wibox.layout.fixed.horizontal
        },
        widget_template = {
            {
                id     = "text_role",
                align = "center",
                widget = wibox.widget.textbox,
            },
            id           = "background_role",
            forced_width = 50,
            widget       = wibox.container.background,
        },
    }

    -- Create a tasklist widget
    s.ledtasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons,
        style   = {
            font  = "MesloLGS NF 10",
            shape = gears.shape.rounded_bar,
            -- shape_border_color = beautiful.white,
            -- shape_border_width = 3,
        },
        layout   = {
            spacing = 10,
            spacing_widget = {
                {
                    forced_width  = 12,
                    forced_height = 5,
                    color         = beautiful.light,
                    shape         = gears.shape.partially_rounded_rect,
                    widget        = wibox.widget.separator
                },
                valign = "center",
                halign = "center",
                widget = wibox.container.place,
            },
            max_widget_size = 180,
            forced_width = 900,
            layout  = wibox.layout.flex.horizontal,
        },
        widget_template = {
            {
                {
                    {
                        {
                            id     = "icon_role",
                            widget = wibox.widget.imagebox,
                        },
                        top = 8,
                        right = 12,
                        bottom = 8,
                        widget  = wibox.container.margin,
                    },
                    {
                        id     = "text_role",
                        widget = wibox.widget.textbox,
                    },
                    layout = wibox.layout.fixed.horizontal,
                },
                left   = 20,
                right  = 12,
                widget = wibox.container.margin,
            },
            id     = "background_role",
            widget = wibox.container.background,
        },
    }


    -- Create the wibox
    s.topwibar = awful.wibar({ position = "top", screen = s })
    s.botwibar = awful.wibar({ position = "bottom", screen = s })

    -- Add widgets to the wibox
    s.topwibar:setup {
        { -- Left widgets
            s.ledtaglist,

            spacing = 10,
            spacing_widget = {
                {
                    forced_width = 12,
                    shape         = gears.shape.partially_rounded_rect,
                    color        = beautiful.light,
                    widget       = wibox.widget.separator
                },
                valign = "center",
                halign = "center",
                widget = wibox.container.place,
            },
            layout = wibox.layout.fixed.horizontal,
        },
        { -- Middle widgets
            ledtextclock,

            spacing = 10,
            spacing_widget = {
                {
                    forced_width  = 12,
                    forced_height = 5,
                    shape         = gears.shape.partially_rounded_rect,
                    color         = beautiful.light,
                    widget        = wibox.widget.separator
                },
                valign = "center",
                halign = "center",
                widget = wibox.container.place,
            },
            layout = wibox.layout.fixed.horizontal,
        },
        {
            {
                layout = wibox.layout.fixed.horizontal,
            },
            {
                layout = wibox.layout.fixed.horizontal,
            },
            { -- Right widgets
                ledbrightness,
                ledvolume,
                ledkeyboardlayout,
                {
                    {
                        {
                            markup = '  <span foreground="' .. beautiful.purple .. '" font = "FontAwesome5 Free Solid 10"></span> : ',
                            widget  = wibox.widget.textbox,
                        },
                        {
                            s.ledlayoutbox,
                            top     = 10,
                            bottom  = 10,
                            widget  = wibox.container.margin,
                        },
                        {
                            text    = '  ',
                            widget  = wibox.widget.textbox,
                        },
                        layout = wibox.layout.fixed.horizontal,
                    },
                    shape  = gears.shape.rounded_bar,
                    bg     = beautiful.light,
                    widget = wibox.container.background,
                },
                ledtray,

                spacing = 10,
                spacing_widget = {
                    {
                        forced_width  = 12,
                        forced_height = 5,
                        color         = beautiful.light,
                        shape         = gears.shape.partially_rounded_rect,
                        widget        = wibox.widget.separator
                    },
                    valign = "center",
                    halign = "center",
                    widget = wibox.container.place,
                },
                layout = wibox.layout.fixed.horizontal,
            },
            layout = wibox.layout.align.horizontal,
        },
        expand = "outside",
        layout = wibox.layout.align.horizontal,
    }

    -- Add widgets to the wibox
    s.botwibar:setup {
        { -- Left widgets
            {
                {
                    {
                        text    = '  ',
                        widget  = wibox.widget.textbox,
                        buttons = launcher_buttons,
                    },
                    {
                        ledlauncher,
                        top     = 10,
                        bottom  = 10,
                        widget  = wibox.container.margin,
                    },
                    {
                        text    = '  ',
                        widget  = wibox.widget.textbox,
                        buttons = launcher_buttons,
                    },
                    layout = wibox.layout.fixed.horizontal,
                },
                shape  = gears.shape.rounded_bar,
                bg     = beautiful.light,
                widget = wibox.container.background,
            },
			s.ledtasklist,
            spacing = 10,
            spacing_widget = {
                {
                    forced_width  = 12,
                    forced_height = 5,
                    color         = beautiful.light,
                    shape         = gears.shape.partially_rounded_rect,
                    widget        = wibox.widget.separator
                },
                valign = "center",
                halign = "center",
                widget = wibox.container.place,
            },
            layout = wibox.layout.fixed.horizontal,
        },
        { -- Middle widgets
            spacing = 10,
            spacing_widget = {
                {
                    forced_width  = 12,
                    forced_height = 5,
                    color         = beautiful.light,
                    shape         = gears.shape.partially_rounded_rect,
                    widget        = wibox.widget.separator
                },
                valign = "center",
                halign = "center",
                widget = wibox.container.place,
            },
            layout = wibox.layout.fixed.horizontal,
        },
        {
            {
                layout = wibox.layout.fixed.horizontal,
            },
            {
                layout = wibox.layout.fixed.horizontal,
            },
            { -- Right widgets
                ledcpu,
                ledmem,
                ledkernel,
                ledbattery,
                spacing = 10,
                spacing_widget = {
                    {
                        forced_width  = 12,
                        forced_height = 5,
                        color         = beautiful.light,
                        shape         = gears.shape.partially_rounded_rect,
                        widget        = wibox.widget.separator
                    },
                    valign = "center",
                    halign = "center",
                    widget = wibox.container.place,
                },
                layout = wibox.layout.fixed.horizontal,
            },
            layout = wibox.layout.align.horizontal,
        },
        -- expand = "outside",
        layout = wibox.layout.align.horizontal,
    }
end)
-- }}}

-- {{{ Mouse bindings
root.buttons(gears.table.join(
    awful.button({ }, 3, function () ledmainmenu:toggle() end)
))
-- }}}

-- {{{ Key bindings
globalkeys = gears.table.join(
    awful.key({ modkey, "Control" }, "s",      hotkeys_popup.show_help,
              {description="show help", group="awesome"}),
    awful.key({ modkey,           }, "h",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ modkey,           }, "l",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
              {description = "go back", group = "tag"}),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),
    -- awful.key({ modkey,           }, "w", function () ledmainmenu:show() end,
    --           {description = "show main menu", group = "awesome"}),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),

    -- Choosing layouts
              -- Main And Vert Stack
    awful.key({ modkey,           }, "a", function () awful.layout.set(awful.layout.suit.tile)    end,
              {description = "change to main and vert stack layout", group = "layout"}),
        
              -- Main And Hor Stack
    awful.key({ modkey, "Shift"   }, "a", function () awful.layout.set(awful.layout.suit.tile.bottom)    end,
              {description = "change to main and hor stack layout", group = "layout"}),

              -- Fair Horisontal
    awful.key({ modkey,           }, "s", function () awful.layout.set(awful.layout.suit.fair.horizontal)    end,
              {description = "change to fair horisontal layout", group = "layout"}),
        
              -- Monocle
    awful.key({ modkey, "Shift"   }, "s", function () awful.layout.set(awful.layout.suit.max)    end,
              {description = "change to monocle layout", group = "layout"}),
        
              -- Magnifier
    awful.key({ modkey,           }, "d", function () awful.layout.set(awful.layout.suit.magnifier)    end,
              {description = "change to magnifier layout", group = "layout"}),
        
              -- Floating
    awful.key({ modkey, "Shift"   }, "d", function () awful.layout.set(awful.layout.suit.floating)    end,
              {description = "change to floating layout", group = "layout"}),
        
    -- Standard program
              -- Launcher
    awful.key({ modkey,           }, "p", function () awful.spawn(proglauncher) end,
              {description = "open a launcher", group = "launcher"}),
    awful.key({ modkey, "Shift"   }, "p", function () awful.spawn(winchooser) end,
              {description = "open a launcher", group = "launcher"}),
    awful.key({ modkey, "Control" }, "p", function () awful.spawn(runpromt) end,
              {description = "open a launcher", group = "launcher"}),

              -- Terminal
    awful.key({ modkey,           }, "Return", function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[2]
                        if tag then
                           tag:view_only()
                        end
                        awful.spawn(terminal) end,
              {description = "open a terminal on tag 2", group = "launcher"}),

              -- Editor
    awful.key({ modkey, "Shift"   }, "Return", function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[2]
                        if tag then
                           tag:view_only()
                        end
                        awful.spawn(editor_cmd) end,
              {description = "open a editor on tag 2", group = "launcher"}),

              -- Browser
    awful.key({ modkey,           }, "b", function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[1]
                        if tag then
                           tag:view_only()
                        end
                        awful.spawn(browser) end,
              {description = "open a browser on tag 1", group = "launcher"}),
    awful.key({ modkey, "Shift"   }, "b", function () awful.spawn(browser) end,
              {description = "open a browser", group = "launcher"}),

              -- File manager
    awful.key({ modkey,           }, "f", function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[3]
                        if tag then
                           tag:view_only()
                        end
                        awful.spawn(filemanager) end,
              {description = "open a file manager on tag 3", group = "launcher"}),
    awful.key({ modkey, "Shift"   }, "f", function () awful.spawn(filemanager) end,
              {description = "open a file manager", group = "launcher"}),

              -- Calculator
    awful.key({ modkey,           }, "c", function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[3]
                        if tag then
                           tag:view_only()
                        end
                        awful.spawn(calculator) end,
              {description = "open a calculator on tag 3", group = "launcher"}),
    awful.key({ modkey, "Shift"   }, "c", function () awful.spawn(calculator) end,
              {description = "open a calculator", group = "launcher"}),

              -- Libre office
    awful.key({ modkey,           }, "o", function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[4]
                        if tag then
                           tag:view_only()
                        end
                        awful.spawn("libreoffice") end,
              {description = "open Libre Office on tag 4", group = "launcher"}),
    awful.key({ modkey, "Shift"   }, "o", function () awful.spawn("libreoffice") end,
              {description = "open Libre Office", group = "launcher"}),

              -- Music player
    awful.key({ modkey,           }, "m", function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[5]
                        if tag then
                           tag:view_only()
                        end
                        awful.spawn(musicplayer) end,
              {description = "open a music player on tag 5", group = "launcher"}),
    awful.key({ modkey, "Shift"   }, "m", function () awful.spawn(musicplayer) end,
              {description = "open a music player", group = "launcher"}),

              -- Screenshot manager
    awful.key({                   }, "Print", function () awful.spawn("spectacle") end,
              {description = "open spectacle", group = "launcher"}),
    awful.key({ modkey,           }, "Print", function () awful.spawn("spectacle -an") end,
              {description = "take a screenshot with spectacle", group = "launcher"}),

              -- Gimp
    awful.key({ modkey,           }, "v", function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[6]
                        if tag then
                           tag:view_only()
                        end
                        awful.spawn("gimp") end,
              {description = "open Gimp on tag 6", group = "launcher"}),

              -- Kdenlive
    awful.key({ modkey, "Control" }, "v", function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[6]
                        if tag then
                           tag:view_only()
                        end
                        awful.spawn("kdenlive") end,
              {description = "open Kdenlive on tag 6", group = "launcher"}),

              -- Inkscape
    awful.key({ modkey, "Shift"   }, "v", function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[6]
                        if tag then
                           tag:view_only()
                        end
                        awful.spawn("inkscape") end,
              {description = "open Inkscape on tag 6", group = "launcher"}),

              -- Steam
    awful.key({ modkey,           }, "g", function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[7]
                        if tag then
                           tag:view_only()
                        end
                        awful.spawn("steam") end,
              {description = "open Steam on tag 7", group = "launcher"}),

              -- VirtualBox
    awful.key({ modkey,           }, "x", function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[8]
                        if tag then
                           tag:view_only()
                        end
                        awful.spawn("virtualbox") end,
              {description = "open VirtualBox on tag 8", group = "launcher"}),

    awful.key({ modkey, "Shift"   }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Shift"   }, "x", awesome.quit,
              {description = "quit awesome", group = "awesome"}),

    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),
    -- awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
    --           {description = "increase the number of master clients", group = "layout"}),
    -- awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
    --           {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
              {description = "decrease the number of columns", group = "layout"}),
    awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
              {description = "select previous", group = "layout"}),

    awful.key({ modkey, "Control" }, "n",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                    c:emit_signal(
                        "request::activate", "key.unminimize", {raise = true}
                    )
                  end
              end,
              {description = "restore minimized", group = "client"}),

    -- Prompt
    awful.key({ modkey },            "r",     function () awful.screen.focused().ledpromptbox:run() end,
              {description = "run prompt", group = "launcher"})

    -- awful.key({ modkey }, "x",
    --           function ()
    --               awful.prompt.run {
    --                 prompt       = "Run Lua code: ",
    --                 textbox      = awful.screen.focused().mypromptbox.widget,
    --                 exe_callback = awful.util.eval,
    --                 history_path = awful.util.get_cache_dir() .. "/history_eval"
    --               }
    --           end,
    --           {description = "lua execute prompt", group = "awesome"}),
    -- Menubar
    -- awful.key({ modkey }, "p", function() menubar.show() end,
    --           {description = "show the menubar", group = "launcher"})
)

clientkeys = gears.table.join(
    awful.key({ modkey            }, "q",      function (c) c:kill()                         end,
              {description = "close", group = "client"}),
    awful.key({ modkey            }, "e",  awful.client.floating.toggle                     ,
              {description = "toggle floating", group = "client"}),
    awful.key({ modkey, "Shift"   }, "e",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
    -- awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
    --           {description = "move to screen", group = "client"}),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
              {description = "toggle keep on top", group = "client"}),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "minimize", group = "client"}),
    awful.key({ modkey,           }, "w",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "(un)maximize", group = "client"}),
    awful.key({ modkey, "Control" }, "w",
        function (c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end ,
        {description = "(un)maximize vertically", group = "client"}),
    awful.key({ modkey, "Shift"   }, "w",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end ,
        {description = "(un)maximize horizontally", group = "client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"}),
        -- Move with a client to tag.
        awful.key({ modkey, "Shift"   }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                     local screen = awful.screen.focused()
                     local tag = screen.tags[i]
                      if tag then
                          tag:view_only()
                     end
                  end,
                  {description = "move with a focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "tag"})
        -- Toggle tag display.
        -- awful.key({ modkey, "Control" }, "#" .. i + 9,
                  -- function ()
                      -- local screen = awful.screen.focused()
                      -- local tag = screen.tags[i]
                      -- if tag then
                         -- awful.tag.viewtoggle(tag)
                      -- end
                  -- end,
                  -- {description = "toggle tag #" .. i, group = "tag"}),
    )
end

clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ modkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen
     }
    },

    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
          "pinentry",
        },
        class = {
          "Arandr",
          "Blueman-manager",
          "Gpick",
          "Kruler",
          "MessageWin",  -- kalarm.
          "Sxiv",
          "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
          "Wpa_gui",
          "veromix",
          "xtightvncviewer"},

        -- Note that the name property shown in xprop might be set slightly after creation of the client
        -- and the name shown there might not match defined rules here.
        name = {
          "Event Tester",  -- xev.
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "ConfigManager",  -- Thunderbird's about:config.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
      }, properties = { floating = true }},

    -- Add titlebars to normal clients and dialogs
    -- { rule_any = { type = { "normal", "dialog" }
        -- }, properties = { titlebars_enabled = true }
    -- },

}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c) end end)
-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({ }, 1, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(c)
        end)
    )

    local rightbar = awful.titlebar(c, {
    size      = 40,
    position = 'right',
	})

    rightbar : setup {
        { -- Left
            awful.titlebar.widget.iconwidget     (c),
            awful.titlebar.widget.stickybutton   (c),
            awful.titlebar.widget.floatingbutton (c),
            buttons = buttons,
            layout  = wibox.layout.fixed.vertical
        },
        { -- Middle
            -- { -- Title
                -- align  = "center",
                -- widget = awful.titlebar.widget.titlewidget(c)
            -- },
            buttons = buttons,
            layout  = wibox.layout.flex.vertical
        },
        { -- Right
            {
                awful.titlebar.widget.minimizebutton (c),
                awful.titlebar.widget.maximizedbutton(c),
                awful.titlebar.widget.closebutton    (c),
                layout = wibox.layout.fixed.horizontal()
            },
            layout = wibox.layout.align.vertical
        },
        layout = wibox.layout.align.vertical,
    }
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}
