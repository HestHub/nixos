local colors = require("colors")
local settings = require("settings")

local asset_dir = "assets/battery/"

local current_charge = "0"

local heart3 = sbar.add("item", "battery.3", {
	position = "right",
	padding_right = 10,
	background = {
		color = colors.transparent,
		border_color = colors.transparent,
	},
})

local heart2 = sbar.add("item", "battery.2", {
	position = "right",
	background = {
		color = colors.transparent,
		border_color = colors.transparent,
	},
})

local heart1 = sbar.add("item", "battery.1", {
	position = "right",
	padding_left = 10,
	background = {
		color = colors.transparent,
		border_color = colors.transparent,
	},
})

local bracket = sbar.add("bracket", { heart1.name, heart2.name, heart3.name }, {
	update_freq = 30,
	background = {
		color = colors.bg1,
		border_color = colors.black0,
		border_width = 2,
	},
})

local remaining_time = sbar.add("item", {
	position = "popup." .. bracket.name,
	icon = {
		align = "left",
		font = {
			family = settings.font.text,
			style = settings.font.style_map["Bold"],
			size = settings.font.size,
		},
		padding_left = 12,
	},
	label = {
		string = "00:00h",
		align = "right",
		padding_right = 14,
	},
})

local function calculate_heart_states(percentage)
	local total_health = math.floor(percentage / 100 * 12)

	local heart1_health = math.min(total_health, 4)
	local heart2_health = math.min(math.max(0, total_health - 4), 4)
	local heart3_health = math.min(math.max(0, total_health - 8), 4)

	return heart1_health, heart2_health, heart3_health
end

local function update_battery()
	sbar.exec("pmset -g batt", function(batt_info)
		local charge_str = batt_info:match("(%d+)%%")
		if not charge_str then
			return
		end
		local charge = tonumber(charge_str)
		current_charge = charge_str

		local h1, h2, h3 = calculate_heart_states(charge)

		local charging = batt_info:match("AC Power") and "charge_" or ""

		local heart1_icon = asset_dir .. charging .. "heart_" .. h1 .. ".png"
		local heart2_icon = asset_dir .. charging .. "heart_" .. h2 .. ".png"
		local heart3_icon = asset_dir .. charging .. "heart_" .. h3 .. ".png"

		heart1:set({ background = { image = heart1_icon } })
		heart2:set({ background = { image = heart2_icon } })
		heart3:set({ background = { image = heart3_icon } })
	end)
end

-- Subscribe to events
bracket:subscribe({ "routine", "power_source_change", "system_woke" }, function()
	update_battery()
end)

local function popup()
	local drawing = bracket:query().popup.drawing
	bracket:set({ popup = { drawing = "toggle" } })

	if drawing == "off" then
		sbar.exec("pmset -g batt", function(batt_info)
			local found, _, remaining = batt_info:find(" (%d+:%d+) remaining")
			local label = "Time remaining: " .. (found and remaining .. "h" or "No estimate")
			remaining_time:set({ label = { string = label }, icon = " " .. current_charge .. "%  | " })
		end)
	end
end

bracket:subscribe("mouse.clicked", function()
	popup()
end)

heart1:subscribe("mouse.clicked", function()
	popup()
end)

heart2:subscribe("mouse.clicked", function()
	popup()
end)

heart3:subscribe("mouse.clicked", function()
	popup()
end)

update_battery()
