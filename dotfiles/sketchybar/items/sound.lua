local colors = require("colors")
local state = require("color_state")

local function addFiller()
	return sbar.add("item", {
		position = "q",
		icon = {
			drawing = false,
		},
		label = {
			drawing = false,
		},
	})
end

local filler1 = addFiller()

local volume = require("items.volume")
local mic = require("items.mic")
local bluetooth = require("items.bluetooth")

local itemList = {
	volume,
	mic,
	bluetooth,
}

local filler2 = addFiller()

local bracket = sbar.add(
	"bracket",
	"sound_bracket",
	{ volume.name, mic.name, bluetooth.name, filler1.name, filler2.name },
	{
		background = {
			color = colors.bg1,
			border_color = colors.with_alpha(colors.cyan.dim, 0.7),
		},
	}
)

bracket:subscribe("colors_toggled", function()
	if state.use_color then
		bracket:set({
			background = { color = colors.bg1 },
		})
		for _, v in pairs(itemList) do
			v.button:set({ label = { color = colors.cyan.dim }, icon = { color = colors.cyan.dim } })
		end
	else
		bracket:set({
			background = { color = colors.with_alpha(colors.cyan.dim, 0.9) },
		})
		for _, v in pairs(itemList) do
			v.button:set({ label = { color = colors.black0 }, icon = { color = colors.black0 } })
		end
	end
end)
