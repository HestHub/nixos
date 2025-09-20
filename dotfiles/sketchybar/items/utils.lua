local sbar = require("sketchybar")
local icons = require("icons")
local colors = require("colors")

local collection_items = {}

local control_button = sbar.add("item", "c.control", {
	position = "right",
	label = {
		string = "",
		padding_left = 0,
		padding_right = 0,
	},
	icon = {
		string = "⚙️",
		padding_left = 1,
		padding_right = 1,
	},
})
table.insert(collection_items, "c.control")

local items_to_add = {
	{
		name = "Tailscale",
		icon = icons.tailscale,
		click_script = 'osascript -e \'tell application "System Events" to tell process "Tailscale" to click menu bar item 1 of menu bar 2\'',
	},
	{
		name = "Tunnelblick",
		icon = icons.tunnelblick,
		click_script = 'osascript -e \'tell application "System Events" to tell process "Tunnelblick" to click menu bar item 1 of menu bar 2\'',
	},
	{
		name = "Amphetamine",
		icon = icons.amphetamine,
		click_script = 'osascript -e \'tell application "System Events" to tell process "Amphetamine" to click menu bar item 1 of menu bar 2\'',
	},
}

local aliases_to_toggle = {}

for _, item in ipairs(items_to_add) do
	local alias_item = sbar.add("alias", item.name, {
		position = "right",
		label = {
			string = "",
			padding_left = 0,
			padding_right = 0,
		},
		icon = {
			string = item.icon,
			font = "FiraCode Nerd Font:Bold:12.0",
			padding_left = 1,
			padding_right = 1,
		},
		drawing = false,
		click_script = item.click_script,
	})
	table.insert(aliases_to_toggle, alias_item)
	table.insert(collection_items, item.name)
end

sbar.add("bracket", "collection", collection_items, {
	background = {
		height = 25,
		color = colors.bg1,
		corner_radius = 5,
	},
})

local menu_visible = false
control_button:subscribe("mouse.clicked", function()
	menu_visible = not menu_visible
	sbar.animate("spring", 15, function()
		for _, alias in ipairs(aliases_to_toggle) do
			alias:set({ drawing = menu_visible })
		end
	end)
end)
