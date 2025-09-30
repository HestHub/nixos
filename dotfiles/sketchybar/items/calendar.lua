local settings = require("settings")
local colors = require("colors")
local state = require("color_state")

local cal = sbar.add("item", {
	icon = {
		font = {
			family = settings.font.text,
			style = settings.font.style_map["Bold"],
			size = settings.font.size,
		},
		color = colors.orange.dim,
		padding_left = 8,
	},
	label = {
		align = "right",
		font = {
			family = settings.font.text,
			style = settings.font.style_map["Bold"],
			size = settings.font.size,
		},
		color = colors.orange.dim,
		padding_right = 10,
	},
	position = "right",
	padding_left = 1,
	padding_right = 0,
	update_freq = 30,
})

cal:subscribe({ "forced", "routine", "system_woke" }, function()
	cal:set({ icon = os.date("%d %b"), label = os.date("%H:%M") })
end)

cal:subscribe("colors_toggled", function()
	if state.use_color then
		cal:set({
			icon = { color = colors.orange.dim },
			label = { color = colors.orange.dim },
			background = { color = colors.bg1 },
		})
	else
		cal:set({
			icon = { color = colors.black1 },
			label = { color = colors.black1 },
			background = { color = colors.orange.dim },
		})
	end
end)
