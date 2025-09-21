local icons = require("icons")
local settings = require("settings")
local colors = require("colors")

local popup_toggle = "sketchybar --set $NAME popup.drawing=toggle"

local apple_logo = sbar.add("item", {
	padding_left = 15,
	click_script = popup_toggle,
	icon = {
		padding_left = settings.padding.icon_item.icon.padding_left,
		padding_right = settings.padding.icon_item.icon.padding_right,
		string = icons.apple,
	},
	label = { drawing = false },
	popup = {
		height = 25,
		padding_left = 15,
	},
})

local apple_prefs = sbar.add("item", {
	padding_left = 10,
	position = "popup." .. apple_logo.name,
	background = {
		border_width = 0,
		color = colors.transparent,
	},
	icon = {
		string = "􀺽",
	},
	label = "Settings",
})

apple_prefs:subscribe("mouse.clicked", function(_)
	sbar.exec("open -a 'System Preferences'")
	apple_logo:set({ popup = { drawing = false } })
end)

local apple_lock = sbar.add("item", {
	padding_left = 10,
	position = "popup." .. apple_logo.name,
	background = {
		border_width = 0,
		color = colors.transparent,
	},
	icon = {
		string = "􀒳",
	},
	label = "Lock",
})

apple_lock:subscribe("mouse.clicked", function(_)
	sbar.exec('osascript -e \'tell application "System Events" to keystroke "q" using {command down, control down}\'')
	apple_logo:set({ popup = { drawing = false } })
end)

local apple_shutdown = sbar.add("item", {
	padding_left = 10,
	position = "popup." .. apple_logo.name,
	background = {
		border_width = 0,
		color = colors.transparent,
	},
	icon = {
		string = "􀷄",
	},
	label = "Shut down",
})

apple_shutdown:subscribe("mouse.clicked", function(_)
	sbar.exec("osascript -e 'tell app \"System Events\" to shut down'")
	apple_logo:set({ popup = { drawing = false } })
end)

local apple_restart = sbar.add("item", {
	padding_left = 10,
	position = "popup." .. apple_logo.name,
	background = {
		border_width = 0,
		color = colors.transparent,
	},
	icon = {
		string = "􀷃",
	},
	label = "Restart",
})

apple_restart:subscribe("mouse.clicked", function(_)
	sbar.exec("osascript -e 'tell app \"System Events\" to restart'")
	apple_logo:set({ popup = { drawing = false } })
end)

local apple_sleep = sbar.add("item", {
	padding_left = 10,
	position = "popup." .. apple_logo.name,
	background = {
		border_width = 0,
		color = colors.transparent,
	},
	icon = {
		string = "􀥦",
	},
	label = "Sleep",
})

apple_sleep:subscribe("mouse.clicked", function(_)
	sbar.exec("osascript -e 'tell app \"System Events\" to sleep'")
	apple_logo:set({ popup = { drawing = false } })
end)
