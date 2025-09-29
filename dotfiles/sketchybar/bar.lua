local colors = require("colors")
local settings = require("settings")

sbar.bar({
	color = colors.bar.bg,
	height = settings.height,
	padding_right = 20,
	padding_left = 20,
	sticky = "on",
	topmost = "window",
	y_offset = 1,
	notch_width = 190,
})
