local icons = require("icons")
local settings = require("settings")

local items = {}

local tails = sbar.add("alias", "Tailscale", {
	icon = {
		string = icons.tailscale,
		font = "FiraCode Nerd Font:Bold:14.0",
	},
	label = { drawing = false },
	click_script = 'osascript -e \'tell application "System Events" to tell process "Tailscale" to click menu bar item 1 of menu bar 2\'',
})

local tunnelblick = sbar.add("alias", "Tunnelblick", {
	icon = {
		string = icons.tunnelblick,
		font = "FiraCode Nerd Font:Bold:14.0",
	},
	label = { drawing = false },
	click_script = 'osascript -e \'tell application "System Events" to tell process "Tunnelblick" to click menu bar item 1 of menu bar 2\'',
})

local amp = sbar.add("alias", "Amphetamine", {
	icon = {
		string = icons.amphetamine,
		font = "FiraCode Nerd Font:Bold:14.0",
	},
	label = { drawing = false },
	click_script = 'osascript -e \'tell application "System Events" to tell process "Amphetamine" to click menu bar item 1 of menu bar 2\'',
})

items[0] = tunnelblick.name
items[1] = tails.name
items[2] = amp.name

sbar.add("bracket", items, { position = "right" })
