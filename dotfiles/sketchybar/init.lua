-- Require the sketchybar module
sbar = require("sketchybar")

-- Set the bar name, if you are using another bar instance than sketchybar
-- sbar.set_bar_name("bottom_bar")

-- Bundle the entire initial configuration into a single message to sketchybar
sbar.begin_config()
require("bar")
require("default")
require("items")

-- Add a new item that is running a script
sbar.add("item", "clock", "right")
sbar.set("clock", {
  script = "$HOME/.config/sketchybar/scripts/clock.sh", 
  update_freq = 10,
})

sbar.end_config()

-- Run the event loop of the sketchybar module (without this there will be no
-- callback functions executed in the lua module)
sbar.event_loop()
