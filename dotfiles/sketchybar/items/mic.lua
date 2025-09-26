-- Stolen from:
-- https://github.com/ian-pascoe/dotfiles/tree/master

local colors = require("colors")
local icons = {
	mic = {
		on = "􀊱",
		off = "􀊳",
	},
}

---@class items.mic
local M = {}

local last_volume = 0

---@param volume number
local set_last_volume = function(volume)
	if volume > 0 then
		last_volume = volume
	end
end

---@param input_volume number
local function update_microphone_display(input_volume)
	set_last_volume(input_volume)

	local is_muted = input_volume == 0
	sbar.animate("tanh", 10, function()
		M.button:set({
			icon = {
				string = is_muted and icons.mic.off or icons.mic.on,
				padding_right = is_muted and 8 or 4,
				color = is_muted and colors.red.base or colors.green.base,
			},
		})
	end)
end

M.button = sbar.add("item", "M.mic.icon", {
	position = "q",
	background = {
		border_color = colors.bg1,
	},
	icon = {
		padding_left = 8,
		padding_right = 8,
	},
	label = {
		drawing = false,
		padding_left = 0,
		padding_right = 8,
	},
})

M.button:subscribe("mouse.clicked", function()
	sbar.exec("osascript -e 'get volume settings'", function(volume_info)
		local input_volume_match = volume_info:match("input volume:(%d+)")
		local input_volume = tonumber(input_volume_match or 0)

		if input_volume == 0 then
			sbar.exec("osascript -e 'set volume input volume " .. last_volume .. "'")
			update_microphone_display(last_volume)
		else
			sbar.exec("osascript -e 'set volume input volume 0'")
			update_microphone_display(0)
		end
	end)
end)

M.button:subscribe({ "forced" }, function(_)
	sbar.exec("osascript -e 'get volume settings'", function(volume_info)
		local input_volume_match = volume_info:match("input volume:(%d+)")
		local input_volume = tonumber(input_volume_match or 0)
		update_microphone_display(input_volume or 0)
	end)
end)

return M
