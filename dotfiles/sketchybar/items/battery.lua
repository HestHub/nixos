local colors = require("colors")
local settings = require("settings")

local asset_dir = "/Users/hest/dev/me/nixos/dotfiles/sketchybar/assets/battery/"
local heart_4 = asset_dir .. "heart_4.png"
local heart_3 = asset_dir .. "heart_3.png"
local heart_2 = asset_dir .. "heart_2.png"
local heart_1 = asset_dir .. "heart_1.png"
local heart_0 = asset_dir .. "heart_0.png"

local root = sbar.add("item", { drawing = false })

local heart3 = sbar.add("item", "widgets.battery.1", {
	position = "right",
	padding_right = 10,
	background = {
		color = colors.transparent,
		border_color = colors.transparent,
	},
})

local heart2 = sbar.add("item", "widgets.battery.2", {
	position = "right",
	background = {
		color = colors.transparent,
		border_color = colors.transparent,
	},
})

local heart1 = sbar.add("item", "widgets.battery.3", {
	position = "right",
	padding_left = 10,
	background = {
		color = colors.transparent,
		border_color = colors.bg1,
	},
})

sbar.add("bracket", { heart1.name, heart2.name, heart3.name }, {
	background = {
		color = colors.bg1,
		border_color = colors.black0,
		border_width = 4,
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
		local charge_str = batt_info:match("(%d+)%%")
		if not charge_str then
			return
		end
		local charge = tonumber(charge_str)

		local charging, _, _ = batt_info:find("AC Power")

		local total_health = 12
		local current_health = math.floor(charge / 100 * total_health)

		local h1, h2, h3 = heart_4, heart_4, heart_4

		heart1:set({ background = { image = h1 } })
		heart2:set({ background = { image = h2 } })
		heart3:set({ background = { image = h3 } })
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
