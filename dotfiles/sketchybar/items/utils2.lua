local sbar = require("sketchybar")
local icons = require("icons")
local settings = require("settings")

-- Define the menu items
local amphetamine = sbar.add("alias", "Amphetamine", {
	drawing = false,
	position = "right",
	icon = {
		string = icons.amphetamine,
		font = "FiraCode Nerd Font:Bold:14.0",
		padding_left = settings.paddings,
	},
	click_script = 'osascript -e \'tell application "System Events" to tell process "Amphetamine" to click menu bar item 1 of menu bar 2\'',
})

local tunnelblick = sbar.add("alias", "Tunnelblick", {
	drawing = false,
	position = "right",
	icon = {
		string = icons.tunnelblick,
		font = "FiraCode Nerd Font:Bold:14.0",
		padding_left = settings.paddings,
	},
	click_script = 'osascript -e \'tell application "System Events" to tell process "Tunnelblick" to click menu bar item 1 of menu bar 2\'',
})

local tailscale = sbar.add("alias", "Tailscale", {
	drawing = false,
	position = "right",
	icon = {
		string = icons.tailscale,
		font = "FiraCode Nerd Font:Bold:14.0",
		padding_left = settings.paddings,
	},
	click_script = 'osascript -e \'tell application "System Events" to tell process "Tailscale" to click menu bar item 1 of menu bar 2\'',
})

-- Store them in a table for easy iteration
local menu_items = { amphetamine, tunnelblick, tailscale }

-- Create a menu trigger item
local utils_trigger = sbar.add("item", "utils_trigger", {
	position = "right",
	icon = {
		font = { size = 14.0 },
		string = icons.gear,
		padding_left = settings.padding.icon_item.icon.padding_left,
		padding_right = settings.padding.icon_item.icon.padding_right,
	},
	label = { drawing = false },
})

-- Menu state variable
local menu_visible = false

-- Function to toggle the menu
local function toggle_menu()
	menu_visible = not menu_visible

	if menu_visible then
		sbar.trigger("swap_menus_and_spaces")
		-- Prepare menu items but keep them hidden until animation starts
		for _, item in ipairs(menu_items) do
			item:set({
				drawing = false,
				width = 0,
				label = { drawing = false },
				icon = { drawing = false },
			})
		end

		-- First make them drawing=true but with label and icon still hidden
		for _, item in ipairs(menu_items) do
			item:set({ drawing = true })
		end

		-- Animate the expansion
		sbar.animate("tanh", 30, function()
			for _, item in ipairs(menu_items) do
				item:set({
					width = "dynamic",
					label = { drawing = true },
					icon = { drawing = true },
				})
			end
		end)
	else
		-- Hide menu items without animation for debugging
		for _, item in ipairs(menu_items) do
			item:set({ drawing = false })
		end
		sbar.trigger("swap_menus_and_spaces")
	end
end

-- Click to toggle menu
utils_trigger:subscribe("mouse.clicked", function(env)
	toggle_menu()
end)
