--- Custom awesomewm theme
---
--- Cris Mihalache - Dec 2014
--- cris@spectrumcoding.com

local gears     = require("gears")
local awful     = require("awful")
awful.rules     = require("awful.rules")

require("awful.autofocus")

local wibox     = require("wibox")
local beautiful = require("beautiful")
local naughty   = require("naughty")
local lain      = require("lain")

--- Error handling
if awesome.startup_errors then
  naughty.notify({ preset = naughty.config.presets.critical,
    title = "Oops, there were errors during startup!",
    text = awesome.startup_errors })
end

do
  local in_error = false
  awesome.connect_signal("debug::error", function (err)
    if in_error then return end
    in_error = true

    naughty.notify({ preset = naughty.config.presets.critical,
             title = "Oops, an error happened!",
             text = err })
    in_error = false
  end)
end

--- Autostart applications
function run_once(cmd)
  findme = cmd
  firstspace = cmd:find(" ")
  if firstspace then
   findme = cmd:sub(0, firstspace-1)
  end
  awful.util.spawn_with_shell("pgrep -u $USER -x " .. findme .. " > /dev/null || (" .. cmd .. ")")
end

run_once("urxvtd")
run_once("unclutter")

--- Variable definitions
os.setlocale(os.getenv("LANG"))
beautiful.init(os.getenv("HOME") .. "/.config/awesome/theme/theme.lua")

-- Common
modkey     = "Mod4"
altkey     = "Mod1"
terminal   = "urxvt"
editor     = os.getenv("EDITOR") or "vim" or "nano"
editor_cmd = terminal .. " -e " .. editor
browser    = "chromium"
iptraf     = terminal .. " -g 180x54-20+34 -e sudo iptraf-ng -i all "
ncmpcpp    = terminal .. " -g 130x34-320+16 -e ncmpcpp "

local layouts = {
  awful.layout.suit.floating,         -- 0
  awful.layout.suit.tile,             -- 1
  awful.layout.suit.tile.bottom,      -- 2
  awful.layout.suit.fair,             -- 3
  awful.layout.suit.fair.horizontal   -- 4
}

-- Tags
tags = {
   names = { "web", "comms", "code", "terms", "etc"},
   layout = { layouts[2], layouts[3], layouts[2], layouts[3], layouts[3] }
}

for s = 1, screen.count() do
   tags[s] = awful.tag(tags.names, s, tags.layout)
end

-- Wibox
markup = lain.util.markup

-- Textclock
clockicon = wibox.widget.imagebox(beautiful.widget_clock)
textClock = awful.widget.textclock("%a %d %b  %H:%M")

-- MPD status
mpdicon = wibox.widget.imagebox(beautiful.widget_music)
mpdicon:buttons(awful.util.table.join(awful.button({ }, 1, function () awful.util.spawn_with_shell(ncmpcpp) end)))
mpdwidget = lain.widgets.mpd({
  settings = function()
    if mpd_now.state == "play" then
      artist = " " .. mpd_now.artist .. " "
      title  = mpd_now.title  .. " "
      mpdicon:set_image(beautiful.widget_music_on)
    elseif mpd_now.state == "pause" then
      artist = " mpd "
      title  = "paused "
    else
      artist = ""
      title  = ""
      mpdicon:set_image(beautiful.widget_music)
    end

    widget:set_markup(markup("#EA6F81", artist) .. title)
  end
})
mpdwidgetbg = wibox.widget.background(mpdwidget, "#222222")

-- ALSA volume
volicon = wibox.widget.imagebox(beautiful.widget_vol)
volumewidget = lain.widgets.alsa({
  settings = function()
    if volume_now.status == "off" then
      volicon:set_image(beautiful.widget_vol_mute)
    elseif tonumber(volume_now.level) == 0 then
      volicon:set_image(beautiful.widget_vol_no)
    elseif tonumber(volume_now.level) <= 50 then
      volicon:set_image(beautiful.widget_vol_low)
    else
      volicon:set_image(beautiful.widget_vol)
    end

    widget:set_text(" " .. volume_now.level .. "% ")
  end
})

-- Net
neticon = wibox.widget.imagebox(beautiful.widget_net)
neticon:buttons(awful.util.table.join(awful.button({ }, 1, function () awful.util.spawn_with_shell(iptraf) end)))
netwidget = lain.widgets.net({
  settings = function()
    widget:set_markup(markup("#7AC82E", " " .. net_now.received)
              .. " " ..
              markup("#46A8C3", " " .. net_now.sent .. " "))
  end
})

-- Separators
separator = wibox.widget.textbox(' ')

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
          awful.button({ }, 1, awful.tag.viewonly),
          awful.button({ modkey }, 1, awful.client.movetotag),
          awful.button({ }, 3, awful.tag.viewtoggle),
          awful.button({ modkey }, 3, awful.client.toggletag),
          awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
          awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
          )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
           awful.button({ }, 1, function (c)
                        if c == client.focus then
                          c.minimized = true
                        else
                          -- Without this, the following
                          -- :isvisible() makes no sense
                          c.minimized = false
                          if not c:isvisible() then
                            awful.tag.viewonly(c:tags()[1])
                          end
                          -- This will also un-minimize
                          -- the client, if needed
                          client.focus = c
                          c:raise()
                        end
                      end),
           awful.button({ }, 3, function ()
                        if instance then
                          instance:hide()
                          instance = nil
                        else
                          instance = awful.menu.clients({ width=250 })
                        end
                      end),
           awful.button({ }, 4, function ()
                        awful.client.focus.byidx(1)
                        if client.focus then client.focus:raise() end
                      end),
           awful.button({ }, 5, function ()
                        awful.client.focus.byidx(-1)
                        if client.focus then client.focus:raise() end
                      end))

for s = 1, screen.count() do

  -- Create a promptbox for each screen
  mypromptbox[s] = awful.widget.prompt()

  -- We need one layoutbox per screen.
  mylayoutbox[s] = awful.widget.layoutbox(s)
  mylayoutbox[s]:buttons(awful.util.table.join(
              awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
              awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
              awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
              awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))

  -- Create a taglist widget
  mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

  -- Create a tasklist widget
  mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)

  -- Create the wibox
  mywibox[s] = awful.wibox({ position = "top", screen = s, height = 18 })

  -- Widgets that are aligned to the upper left
  local left_layout = wibox.layout.fixed.horizontal()
  left_layout:add(separator)
  left_layout:add(mytaglist[s])
  left_layout:add(mypromptbox[s])
  left_layout:add(separator)

  -- Widgets that are aligned to the upper right
  -- If you are moving widgets from a section with light grey background to dark grey or vice versa,
  -- use a replacement icon as appropriate from themes/powerarrow-darker/alticons so your icons match the bg.
  local right_layout = wibox.layout.fixed.horizontal()
  if s == 1 then right_layout:add(wibox.widget.systray()) end
  right_layout:add(separator)
  right_layout:add(mpdicon)
  right_layout:add(mpdwidgetbg)
  right_layout:add(separator)
  right_layout:add(volicon)
  right_layout:add(volumewidget)
  right_layout:add(separator)
  right_layout:add(neticon)
  right_layout:add(netwidget)
  right_layout:add(separator)
  right_layout:add(textClock)
  right_layout:add(separator)
  right_layout:add(mylayoutbox[s])

  -- Now bring it all together (with the tasklist in the middle)
  local layout = wibox.layout.align.horizontal()
  layout:set_left(left_layout)
  layout:set_middle(mytasklist[s])
  layout:set_right(right_layout)
  mywibox[s]:set_widget(layout)

end
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
  -- Take a screenshot
  -- https://github.com/copycat-killer/dots/blob/master/bin/screenshot
  awful.key({ altkey }, "p", function() os.execute("screenshot") end),

  -- Tag browsing
  awful.key({ modkey }, "Left",   awful.tag.viewprev       ),
  awful.key({ modkey }, "Right",  awful.tag.viewnext       ),
  awful.key({ modkey }, "Escape", awful.tag.history.restore),

  -- Non-empty tag browsing
  awful.key({ altkey }, "Left", function () lain.util.tag_view_nonempty(-1) end),
  awful.key({ altkey }, "Right", function () lain.util.tag_view_nonempty(1) end),

  -- Default client focus
  awful.key({ altkey }, "k",
    function ()
      awful.client.focus.byidx( 1)
      if client.focus then client.focus:raise() end
    end),
  awful.key({ altkey }, "j",
    function ()
      awful.client.focus.byidx(-1)
      if client.focus then client.focus:raise() end
    end),

  -- By direction client focus
  awful.key({ modkey }, "j",
    function()
      awful.client.focus.bydirection("down")
      if client.focus then client.focus:raise() end
    end),
  awful.key({ modkey }, "k",
    function()
      awful.client.focus.bydirection("up")
      if client.focus then client.focus:raise() end
    end),
  awful.key({ modkey }, "h",
    function()
      awful.client.focus.bydirection("left")
      if client.focus then client.focus:raise() end
    end),
  awful.key({ modkey }, "l",
    function()
      awful.client.focus.bydirection("right")
      if client.focus then client.focus:raise() end
    end),

  -- Show/Hide Wibox
  awful.key({ modkey }, "b", function ()
    mywibox[mouse.screen].visible = not mywibox[mouse.screen].visible
  end),

  -- Layout manipulation
  awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
  awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
  awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
  awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
  awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
  awful.key({ modkey,           }, "Tab",
    function ()
      awful.client.focus.history.previous()
      if client.focus then
        client.focus:raise()
      end
    end),
  awful.key({ altkey, "Shift"   }, "l",      function () awful.tag.incmwfact( 0.05)     end),
  awful.key({ altkey, "Shift"   }, "h",      function () awful.tag.incmwfact(-0.05)     end),
  awful.key({ modkey, "Shift"   }, "l",      function () awful.tag.incnmaster(-1)       end),
  awful.key({ modkey, "Shift"   }, "h",      function () awful.tag.incnmaster( 1)       end),
  awful.key({ modkey, "Control" }, "l",      function () awful.tag.incncol(-1)          end),
  awful.key({ modkey, "Control" }, "h",      function () awful.tag.incncol( 1)          end),
  awful.key({ modkey,           }, "space",  function () awful.layout.inc(layouts,  1)  end),
  awful.key({ modkey, "Shift"   }, "space",  function () awful.layout.inc(layouts, -1)  end),
  awful.key({ modkey, "Control" }, "n",      awful.client.restore),

  -- Standard program
  awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
  awful.key({ modkey, "Control" }, "r",      awesome.restart),
  awful.key({ modkey, "Shift"   }, "q",      awesome.quit),

  -- ALSA volume control
  awful.key({ altkey }, "Up",
    function ()
      awful.util.spawn("amixer -q set Master 1%+")
      volumewidget.update()
    end),
  awful.key({ altkey }, "Down",
    function ()
      awful.util.spawn("amixer -q set Master 1%-")
      volumewidget.update()
    end),
  awful.key({ altkey }, "m",
    function ()
      awful.util.spawn("amixer -q set Master playback toggle")
      volumewidget.update()
    end),

  -- MPD control
  awful.key({ altkey, "Control" }, "Up",
    function ()
      awful.util.spawn_with_shell("mpc toggle || ncmpc toggle || pms toggle")
      mpdwidget.update()
    end),
  awful.key({ altkey, "Control" }, "Down",
    function ()
      awful.util.spawn_with_shell("mpc stop || ncmpc stop || pms stop")
      mpdwidget.update()
    end),
  awful.key({ altkey, "Control" }, "Left",
    function ()
      awful.util.spawn_with_shell("mpc prev || ncmpc prev || pms prev")
      mpdwidget.update()
    end),
  awful.key({ altkey, "Control" }, "Right",
    function ()
      awful.util.spawn_with_shell("mpc next || ncmpc next || pms next")
      mpdwidget.update()
    end),

  -- Copy to clipboard
  awful.key({ modkey }, "c", function () os.execute("xsel -p -o | xsel -i -b") end),

  -- User programs
  awful.key({ modkey }, "q", function () awful.util.spawn(browser) end),

  -- Prompt
  awful.key({ modkey }, "r", function () mypromptbox[mouse.screen]:run() end),
  awful.key({ modkey }, "x",
        function ()
          awful.prompt.run({ prompt = "Run Lua code: " },
          mypromptbox[mouse.screen].widget,
          awful.util.eval, nil,
          awful.util.getdir("cache") .. "/history_eval")
        end)
)

clientkeys = awful.util.table.join(
  awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
  awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
  awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
  awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
  awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
  awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
  awful.key({ modkey,           }, "n",
    function (c)
      -- The client currently has the input focus, so it cannot be
      -- minimized, since minimized clients can't have the focus.
      c.minimized = true
    end),
  awful.key({ modkey,           }, "m",
    function (c)
      c.maximized_horizontal = not c.maximized_horizontal
      c.maximized_vertical   = not c.maximized_vertical
    end)
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
  globalkeys = awful.util.table.join(globalkeys,
    awful.key({ modkey }, "#" .. i + 9,
          function ()
            local screen = mouse.screen
            local tag = awful.tag.gettags(screen)[i]
            if tag then
               awful.tag.viewonly(tag)
            end
          end),
    awful.key({ modkey, "Control" }, "#" .. i + 9,
          function ()
            local screen = mouse.screen
            local tag = awful.tag.gettags(screen)[i]
            if tag then
             awful.tag.viewtoggle(tag)
            end
          end),
    awful.key({ modkey, "Shift" }, "#" .. i + 9,
          function ()
            local tag = awful.tag.gettags(client.focus.screen)[i]
            if client.focus and tag then
              awful.client.movetotag(tag)
           end
          end),
    awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
          function ()
            local tag = awful.tag.gettags(client.focus.screen)[i]
            if client.focus and tag then
              awful.client.toggletag(tag)
            end
          end))
end

clientbuttons = awful.util.table.join(
  awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
  awful.button({ modkey }, 1, awful.mouse.client.move),
  awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     size_hints_honor = false } }
}
-- }}}

-- {{{ Signals
-- signal function to execute when a new client appears.
client.connect_signal("manage", function (c, startup)
  -- enable sloppy focus
  c:connect_signal("mouse::enter", function(c)
    if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
      and awful.client.focus.filter(c) then
      client.focus = c
    end
  end)

  if not startup and not c.size_hints.user_position
     and not c.size_hints.program_position then
    awful.placement.no_overlap(c)
    awful.placement.no_offscreen(c)
  end

  local titlebars_enabled = false
  if titlebars_enabled and (c.type == "normal" or c.type == "dialog") then
    -- buttons for the titlebar
    local buttons = awful.util.table.join(
        awful.button({ }, 1, function()
          client.focus = c
          c:raise()
          awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
          client.focus = c
          c:raise()
          awful.mouse.client.resize(c)
        end)
        )

    -- widgets that are aligned to the right
    local right_layout = wibox.layout.fixed.horizontal()
    right_layout:add(awful.titlebar.widget.floatingbutton(c))
    right_layout:add(awful.titlebar.widget.maximizedbutton(c))
    right_layout:add(awful.titlebar.widget.stickybutton(c))
    right_layout:add(awful.titlebar.widget.ontopbutton(c))
    right_layout:add(awful.titlebar.widget.closebutton(c))

    -- the title goes in the middle
    local middle_layout = wibox.layout.flex.horizontal()
    local title = awful.titlebar.widget.titlewidget(c)
    title:set_align("center")
    middle_layout:add(title)
    middle_layout:buttons(buttons)

    -- now bring it all together
    local layout = wibox.layout.align.horizontal()
    layout:set_right(right_layout)
    layout:set_middle(middle_layout)

    awful.titlebar(c,{size=16}):set_widget(layout)
  end
end)

-- No border for maximized clients
client.connect_signal("focus",
  function(c)
    if c.maximized_horizontal == true and c.maximized_vertical == true then
      c.border_color = beautiful.border_normal
    else
      c.border_color = beautiful.border_focus
    end
  end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

-- {{{ Arrange signal handler
for s = 1, screen.count() do screen[s]:connect_signal("arrange", function ()
    local clients = awful.client.visible(s)
    local layout  = awful.layout.getname(awful.layout.get(s))

    if #clients > 0 then -- Fine grained borders and floaters control
      for _, c in pairs(clients) do -- Floaters always have borders
        if awful.client.floating.get(c) or layout == "floating" then
          c.border_width = beautiful.border_width

        -- No borders with only one visible client
        elseif #clients == 1 or layout == "max" then
          clients[1].border_width = 0
        else
          c.border_width = beautiful.border_width
        end
      end
    end
    end)
end
-- }}}