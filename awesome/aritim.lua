---------------------------
-- Default awesome theme --
---------------------------

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()

local theme = {}

theme.font = "MesloLGS NF 11"

theme.dark    = "#10151ad9"
theme.lighter = "#141a21"
theme.light   = "#172a3d"

theme.gray  = "#cecece"
theme.sizy  = "#c2c6ca"
theme.white = "#ffffff"

theme.red    = "#e25270"
theme.orange = "#e2a052"
theme.yellow = "#e2c552"
theme.salad  = "#b8e252"
theme.green  = "#52e258"
theme.cyan   = "#52e2c4"
theme.blue   = "#5294e2"
theme.bluish = "#5454ff"
theme.purple = "#7c52e2"
theme.pink   = "#e252dc"

theme.bg_normal   = theme.dark
theme.bg_focus    = theme.blue
theme.bg_urgent   = theme.red
theme.bg_minimize = theme.lighter

theme.fg_normal   = theme.white
theme.fg_focus    = theme.white
theme.fg_urgent   = theme.white
theme.fg_minimize = theme.white

theme.useless_gap   = dpi(5)
theme.border_width  = dpi(4)
theme.border_color  = theme.white
theme.border_normal = theme.dark
theme.border_focus  = theme.blue
theme.border_marked = theme.red

-- theme.taglist_bg_occupied = theme.yellow
-- theme.taglist_fg_occupied = theme.white
-- theme.taglist_bg_empty    = theme.light
-- theme.taglist_fg_empty    = theme.white
-- theme.taglist_bg_urgent   = theme.red
-- theme.taglist_fg_urgent   = theme.white

theme.taglist_bg_focus    = theme.light
theme.taglist_fg_focus    = theme.blue
theme.taglist_bg_occupied = theme.light
theme.taglist_fg_occupied = theme.yellow
theme.taglist_bg_empty    = theme.light
theme.taglist_fg_empty    = theme.white
theme.taglist_bg_urgent   = theme.light
theme.taglist_fg_urgent   = theme.red

theme.tasklist_bg_focus    = theme.light
theme.tasklist_fg_focus    = theme.blue
theme.tasklist_bg_minimize = theme.light
theme.tasklist_fg_minimize = theme.white
theme.tasklist_bg_normal   = theme.light
theme.tasklist_fg_normal   = theme.yellow
theme.tasklist_bg_urgent   = theme.light
theme.tasklist_fg_urgent   = theme.red

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]
theme.tasklist_disable_task_name  = false
theme.tasklist_plain_task_name    = false
theme.tasklist_sticky             = " "
theme.tasklist_ontop              = " "
theme.tasklist_above              = " "
theme.tasklist_below              = " "
theme.tasklist_floating           = " "
theme.tasklist_minimize           = " "
theme.tasklist_maximized          = " "
theme.tasklist_maximized_vertical = " "
theme.tasklist_maximized_horizontal = " "

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = themes_path.."default/submenu.png"
theme.menu_height       = dpi(15)
theme.menu_width        = dpi(100)

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
theme.titlebar_close_button_normal = themes_path.."default/titlebar/close_normal.png"
theme.titlebar_close_button_focus  = themes_path.."default/titlebar/close_focus.png"

theme.titlebar_minimize_button_normal = themes_path.."default/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus  = themes_path.."default/titlebar/minimize_focus.png"

theme.titlebar_ontop_button_normal_inactive = themes_path.."default/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = themes_path.."default/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = themes_path.."default/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = themes_path.."default/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = themes_path.."default/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = themes_path.."default/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = themes_path.."default/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = themes_path.."default/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = themes_path.."default/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = themes_path.."default/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = themes_path.."default/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = themes_path.."default/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = themes_path.."default/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = themes_path.."default/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = themes_path.."default/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = themes_path.."default/titlebar/maximized_focus_active.png"

wallpaper = "/home/ledity/Images/Wallpapers/"
theme.wallpaper = wallpaper.."1.jpg"

-- You can use your own layout icons like this:
theme.layout_fairh      = "/home/ledity/.config/awesome/icons/fairh.svg"
theme.layout_fairv      = "/home/ledity/.config/awesome/icons/grip-horizontal-solid.svg"
theme.layout_floating   = "/home/ledity/.config/awesome/icons/window-restore-solid.svg"
theme.layout_magnifier  = "/home/ledity/.config/awesome/icons/search-plus-solid.svg"
theme.layout_max        = "/home/ledity/.config/awesome/icons/window-maximize-solid.svg"
theme.layout_fullscreen = themes_path.."default/layouts/fullscreenw.png"
theme.layout_tilebottom = "/home/ledity/.config/awesome/icons/tile-top.svg"
theme.layout_tileleft = themes_path.."default/layouts/tileleftw.png"
theme.layout_tile     = "/home/ledity/.config/awesome/icons/tile.svg"
theme.layout_tiletop  = "/home/ledity/.config/awesome/icons/tile-top.svg"
theme.layout_spiral   = themes_path.."default/layouts/spiralw.png"
theme.layout_dwindle  = themes_path.."default/layouts/dwindlew.png"
theme.layout_cornernw = themes_path.."default/layouts/cornernww.png"
theme.layout_cornerne = themes_path.."default/layouts/cornernew.png"
theme.layout_cornersw = themes_path.."default/layouts/cornersww.png"
theme.layout_cornerse = themes_path.."default/layouts/cornersew.png"

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
    theme.menu_height, theme.blue, theme.dark
)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = "/usr/share/icons/Qogir-dark"

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
