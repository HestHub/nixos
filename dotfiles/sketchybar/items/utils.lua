local sbar = require("sketchybar")
local icons = require("icons")
local colors = require("colors")
local settings = require("settings")
local color_state = require("color_state")

local collection_items = {}

local function toggle()
	color_state.use_color = not color_state.use_color
	sbar.exec("sketchybar --trigger colors_toggled")
end

local control_button = sbar.add("item", "c.control", {
	position = "right",
	label = {
		drawing = false,
	},
	background = {
		color = colors.transparent,
		border_color = colors.with_alpha(colors.yellow.dim, 0.7),
	},
	icon = {
		string = "􀆔",
		padding_left = settings.padding.icon_item.icon.padding_left - 4,
		padding_right = settings.padding.icon_item.icon.padding_right - 4,
		color = colors.yellow.dim,
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
		name = "Control Center,WiFi",
		click_script = 'osascript -e \'tell application "System Events" to tell process "Control Center" to click menu bar item 1 of menu bar 2\'',
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
	{
		name = "Control Center,BentoBox",
		click_script = 'osascript -e \'tell application "System Events" to tell process "Control Center" to click menu bar item 2 of menu bar 1\'',
	},
}

local aliases_to_toggle = {}

for _, item in ipairs(items_to_add) do
	local config = {
		position = "right",
		label = {
			drawing = false,
		},
		icon = {
			font = "FiraCode Nerd Font:Bold:12.0",
		},
		background = {
			border_width = 0,
		},
		drawing = false,
		click_script = item.click_script,
	}

	if item.icon then
		config.icon.string = item.icon
	end

	local alias_item = sbar.add("alias", item.name, config)
	table.insert(aliases_to_toggle, alias_item)
	table.insert(collection_items, item.name)
end

local collection_bracket = sbar.add("bracket", "collection", collection_items, {
	background = {
		color = colors.bg1,
	},
})

local menu_visible = false
control_button:subscribe("mouse.clicked", function(env)
	if env["BUTTON"] == "right" then
		toggle()
		return
	end

	menu_visible = not menu_visible
	sbar.animate("spring", 15, function()
		for _, alias in ipairs(aliases_to_toggle) do
			alias:set({ drawing = menu_visible })
		end
	end)
end)

-- Strange bug, must leave right side of monitor to trigger
collection_bracket:subscribe("mouse.exited.global", function()
	if menu_visible then
		menu_visible = false
		sbar.animate("spring", 15, function()
			for _, alias in ipairs(aliases_to_toggle) do
				alias:set({ drawing = false })
			end
		end)
	end
end)

control_button:subscribe("colors_toggled", function()
	if color_state.use_color then
		control_button:set({
			icon = { color = colors.yellow.dim },
			background = { color = colors.transparent },
		})
		collection_bracket:set({
			background = { color = colors.transparent },
		})
	else
		control_button:set({
			icon = { color = colors.black1 },
			background = { color = colors.yellow.dim },
		})
	end
end)

control_button:subscribe("colors_cli_toggle", function()
	toggle()
end)
