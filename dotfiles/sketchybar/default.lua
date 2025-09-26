local settings = require("settings")
local colors = require("colors")

-- Equivalent to the --default domain
sbar.default({
	background = {
		border_color = colors.black0,
		border_width = 2,
		color = colors.bg2,
		corner_radius = 20,
		height = settings.height,
		image = {
			corner_radius = 9,
			border_color = colors.grey,
			border_width = 1,
		},
	},
	icon = {
		font = {
			family = settings.font_icon.text,
			style = settings.font_icon.style_map["Bold"],
			size = settings.font_icon.size,
		},
		color = colors.white0_normal,
		highlight_color = colors.bg1,
		padding_left = 0,
		padding_right = 0,
	},
	label = {
		font = {
			family = settings.font.text,
			style = settings.font.style_map["Semibold"],
			size = settings.font.size,
		},
		color = colors.white0_normal,
		padding_left = settings.paddings,
		padding_right = settings.paddings,
	},
	popup = {
		align = "left",
		background = {
			border_width = 2,
			corner_radius = 15,
			color = colors.popup.bg,
			border_color = colors.popup.border,
			shadow = { drawing = true },
		},
		blur_radius = 50,
		y_offset = 0,
	},
	padding_left = 3,
	padding_right = 3,
	scroll_texts = true,
	updates = "on",
})
