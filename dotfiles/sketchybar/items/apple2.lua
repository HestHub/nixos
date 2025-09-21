local sbar = require("sketchybar")

-- Corresponds to: --add item apple.logo ... and all --set apple.logo ...
-- and all the --add item ... popup.apple.logo commands.
sbar.add("item", "apple.logo", {
	position = "left",
	icon = {
		string = "", -- Apple Logo SF Symbol
		font = "SF Pro:Black:16.0",
	},
	label = {
		drawing = false,
	},
	click_script = "sketchybar -m --set $NAME popup.drawing=toggle",

	-- The popup items are defined declaratively inside a `popup` table
	popup = {
		background = {
			border_width = 2,
			corner_radius = 3,
			border_color = 0xff9dd274,
		},
		-- The `items` key holds an array of all items inside the popup
		items = {
			{
				-- Corresponds to: apple.preferences
				icon = "􀺽", -- Preferences SF Symbol
				label = "Preferences",
				click_script = [[
                    open -a 'System Settings';
                    sketchybar -m --set apple.logo popup.drawing=off
                ]],
			},
			{
				-- Corresponds to: apple.activity
				icon = "􀒓", -- Activity Monitor SF Symbol
				label = "Activity",
				click_script = [[
                    open -a 'Activity Monitor';
                    sketchybar -m --set apple.logo popup.drawing=off
                ]],
			},
			{
				-- Corresponds to: apple.lock
				icon = "􀒳", -- Lock Screen SF Symbol
				label = "Lock Screen",
				click_script = [[
                    pmset displaysleepnow;
                    sketchybar -m --set apple.logo popup.drawing=off
                ]],
			},
		},
	},
})
