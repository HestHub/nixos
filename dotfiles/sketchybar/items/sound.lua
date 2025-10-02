local colors = require("colors")

local filler1 = sbar.add("item", {
	position = "q",
	icon = {
		drawing = false,
	},
	label = {
		drawing = false,
	},
})

local volume = require("items.volume")
local mic = require("items.mic")
local bluetooth = require("items.bluetooth")

local filler2 = sbar.add("item", {
	position = "q",
	icon = {
		drawing = false,
	},
	label = {
		drawing = false,
	},
})

sbar.add("bracket", "sound_bracket", { volume.name, mic.name, bluetooth.name, filler1.name, filler2.name }, {
	background = {
		color = colors.bg1,
		border_color = colors.with_alpha(colors.cyan.dim, 0.7),
	},
})
