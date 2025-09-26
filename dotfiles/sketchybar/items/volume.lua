-- Stolen from:
-- https://github.com/ian-pascoe/dotfiles/tree/master

local colors = require("colors")

local icons = {
	volume = {
		_100 = "􀊩",
		_66 = "􀊧",
		_33 = "􀊥",
		_10 = "􀊡",
		_0 = "􀊣",
	},
}

local M = {}

local last_volume = 0

---@param volume number
local set_last_volume = function(volume)
	if volume > 0 then
		last_volume = volume
	end
end

M.button = sbar.add("item", "M.vol.icon", {
	position = "q",
	padding_left = 0,
	padding_right = 0,
	icon = {
		padding_right = 8,
	},
	label = {
		drawing = false,
		padding_left = 0,
		padding_right = 8,
	},
	popup = {
		align = "center",
	},
	background = {
		corner_radius = 10,
		border_color = colors.transparent,
	},
})
M.button:subscribe("mouse.clicked", function()
	sbar.exec("osascript -e 'get volume settings'", function(volume_info)
		local output_volume_match = volume_info:match("output volume:(%d+)")
		local output_volume = tonumber(output_volume_match or 0)

		if output_volume == 0 then
			sbar.exec("osascript -e 'set volume output volume " .. last_volume .. "'")
		else
			sbar.exec("osascript -e 'set volume output volume 0'")
		end
	end)
end)

M.button:subscribe("mouse.entered", function()
	M.button:set({
		popup = { drawing = true },
		background = { color = colors.with_alpha(colors.bg1, 0.25) },
	})
end)

M.button:subscribe({ "mouse.exited", "mouse.exited.global" }, function()
	M.button:set({
		popup = { drawing = false },
	})
end)

M.button:subscribe("mouse.scrolled", function(env)
	local delta = env.INFO.delta
	if not (env.INFO.modifier == "ctrl") then
		delta = delta * 10.0
	end
	sbar.exec('osascript -e "set volume output volume (output volume of (get volume settings) + ' .. delta .. ')"')
end)

M.slider = sbar.add("slider", "volume_slider", 100, {
	width = 100,
	position = "popup." .. M.button.name,
	padding_left = 10,
	padding_right = 10,
	icon = { drawing = false },
	label = { drawing = false },
	slider = {
		highlight_color = colors.bg1,
		width = 100,
		background = {
			height = 6,
			corner_radius = 3,
		},
		knob = {
			string = "􀀁",
			drawing = true,
		},
	},
	updates = "when_shown",
})

M.slider:subscribe("mouse.clicked", function(env)
	sbar.exec("osascript -e 'set volume output volume " .. env["PERCENTAGE"] .. "'")
end)

---@param new_volume number
local function update_volume_display(new_volume)
	set_last_volume(new_volume)

	local icon = icons.volume._0
	if new_volume > 60 then
		icon = icons.volume._100
	elseif new_volume > 30 then
		icon = icons.volume._66
	elseif new_volume > 10 then
		icon = icons.volume._33
	elseif new_volume > 0 then
		icon = icons.volume._10
	end

	sbar.animate("tanh", 10, function()
		local is_muted = new_volume == 0
		M.button:set({
			icon = {
				string = icon,
				padding_right = is_muted and 8 or 4,
				color = is_muted and colors.red.base or colors.green.base,
			},
			label = {
				drawing = not is_muted,
				string = tostring(new_volume) .. "%",
			},
		})
		M.slider:set({
			slider = { percentage = new_volume },
		})
	end)
end

M.button:subscribe("volume_change", function(env)
	local new_volume = tonumber(env.INFO or 0)
	update_volume_display(new_volume or 0)
end)

M.button:subscribe("forced", function()
	sbar.exec("osascript -e 'get volume settings'", function(volume_info)
		local output_volume_match = volume_info:match("output volume:(%d+)")
		local output_volume = tonumber(output_volume_match or 0)
		update_volume_display(output_volume or 0)
	end)
end)

return M
