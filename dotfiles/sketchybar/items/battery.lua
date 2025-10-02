local colors = require("colors")

local num_hearts = 3
local states_per_heart = 4
local asset_dir = "assets/battery/"

local total_states = num_hearts * states_per_heart

local current_charge = {
	percentage = "N/A",
	time_remaining = "No estimate",
}

local hearts = {}
local heart_names = {}

for i = num_hearts, 1, -1 do
	local name = "battery." .. i
	local padding_opts = {}

	if i == 1 then
		padding_opts.padding_left = 10
	elseif i == num_hearts then
		padding_opts.padding_right = 10
	end

	hearts[i] = sbar.add("item", name, {
		position = "right",
		background = {
			color = colors.transparent,
			border_color = colors.transparent,
		},
		padding_left = padding_opts.padding_left,
		padding_right = padding_opts.padding_right,
	})
	table.insert(heart_names, name)
end

local bracket = sbar.add("bracket", heart_names, {
	update_freq = 30,
	background = {
		color = colors.bg1,
		border_color = colors.with_alpha(colors.red.dim, 0.7),
		border_width = 2,
	},
})

local popup_item = sbar.add("item", {
	position = "popup." .. bracket.name,
	icon = {
		align = "left",
		padding_left = 14,
	},
	label = {
		string = "00:00h",
		align = "right",
		padding_right = 14,
	},
})

local function calculate_heart_states(percentage)
	local states = {}
	local remaining_health = math.floor(percentage / 100 * total_states)

	for i = 1, num_hearts do
		local health = math.min(remaining_health, states_per_heart)
		states[i] = health
		remaining_health = remaining_health - health
	end
	return states
end

local function update_battery()
	sbar.exec("pmset -g batt", function(batt_info)
		local charge_str = batt_info:match("(%d+)%%")
		if not charge_str then
			return
		end

		local charge = tonumber(charge_str)
		current_charge.percentage = charge_str
		local _, _, remaining = batt_info:find(" (%d+:%d+) remaining")
		current_charge.time_remaining = remaining and (remaining .. "h") or "No estimate"

		local heart_states = calculate_heart_states(charge)
		local charging_prefix = batt_info:match("AC Power") and "charge_" or ""

		for i = 1, num_hearts do
			local icon_path = asset_dir .. charging_prefix .. "heart_" .. heart_states[i] .. ".png"
			hearts[i]:set({ background = { image = icon_path } })
		end
	end)
end

local function toggle_popup()
	local is_drawing = bracket:query().popup.drawing == "on"
	bracket:set({ popup = { drawing = not is_drawing } })

	if not is_drawing then
		popup_item:set({
			icon = current_charge.percentage .. "%  | ",
			label = "Time remaining: " .. current_charge.time_remaining,
		})
	end
end

bracket:subscribe({ "routine", "power_source_change", "system_woke" }, update_battery)
bracket:subscribe("mouse.clicked", toggle_popup)

for i = 1, #hearts do
	hearts[i]:subscribe("mouse.clicked", toggle_popup)
end

update_battery()
