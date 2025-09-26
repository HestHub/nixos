local colors = require("colors")
local settings = require("settings")

local asset_dir = "/Users/hest/dev/me/nixos/dotfiles/sketchybar/assets/battery/"
local heart_full = asset_dir .. "hearts2.png"
local heart_half = asset_dir .. "hearts2.png"
local heart_empty = asset_dir .. "hearts2.png"
local heart_charging = asset_dir .. "hearts2.png"

local root = sbar.add("item", { drawing = false })

local heart3 = sbar.add("item", "widgets.battery.1", {
	position = "right",
	width = 24,
	background = {
		drawing = "on",
		color = colors.transparent,
		border_color = colors.transparent,
		padding_left = 2,
		padding_right = 2,
		border_width = 0,
	},
})

local heart2 = sbar.add("item", "widgets.battery.2", {
	position = "right",
	width = 24,
	background = {
		drawing = "on",
		color = colors.transparent,
		border_color = colors.transparent,
		padding_left = 2,
		padding_right = 2,
	},
})

local heart1 = sbar.add("item", "widgets.battery.3", {
	position = "right",
	width = 24,
	background = {

		border_color = colors.transparent,
		drawing = "off",
		padding_left = 2,
		padding_right = 2,
	},
})

local remaining_time = sbar.add("item", {
	position = "popup." .. heart3.name,
	icon = {
		string = "Time remaining:",
		align = "left",
		font = {
			family = settings.font.text,
			style = settings.font.style_map["Regular"],
			size = settings.font.size,
		},
		padding_left = 2,
	},
	label = {
		string = "00:00h",
		align = "right",
		padding_right = 4,
	},
})

local function update_battery()
	sbar.exec("pmset -g batt", function(batt_info)
		local charge_str, _, _ = batt_info:find("(%d+)%%")
		if not charge_str then
			return
		end
		local charge = tonumber(charge_str)

		local charging, _, _ = batt_info:find("AC Power")

		if charging then
			heart1:set({
				background = {
					color = colors.transparent,
					image = { string = heart_charging, scale = 0.8, border_width = 0 },
				},
			})
			heart2:set({
				background = {
					color = colors.transparent,
					image = { string = heart_charging, scale = 0.8, border_width = 0 },
				},
			})
			heart3:set({
				background = {
					color = colors.transparent,
					image = { string = heart_charging, scale = 0.8, border_width = 0 },
				},
			})
			return
		end

		local hearts = {}
		local total_health = 6
		local current_health = math.floor(charge / 100 * total_health)

		for i = 1, 3 do
			if current_health >= 2 then
				hearts[i] = heart_full
				current_health = current_health - 2
			elseif current_health == 1 then
				hearts[i] = heart_half
				current_health = current_health - 1
			else
				hearts[i] = heart_empty
			end
		end

		heart1:set({ background = { image = hearts[1] } })
		heart2:set({ background = { image = hearts[2] } })
		heart3:set({ background = { image = hearts[3] } })
	end)
end

-- Subscribe to events
root:subscribe({ "routine", "power_source_change", "system_woke" }, function()
	update_battery()
end)

heart3:subscribe("mouse.clicked", function()
	local drawing = heart3:query().popup.drawing
	heart3:set({ popup = { drawing = "toggle" } })

	if drawing == "off" then
		sbar.exec("pmset -g batt", function(batt_info)
			local found, _, remaining = batt_info:find(" (%d+:%d+) remaining")
			local label = found and remaining .. "h" or "No estimate"
			remaining_time:set({ label = { string = label } })
		end)
	end
end)

update_battery()
