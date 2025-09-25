local colors = require("colors")
local settings = require("settings")

local media = sbar.add("item", {
	drawing = "off",
	icon = {
		string = "􀑪",
		font = {
			family = settings.font.text,
			style = settings.font.style_map["Bold"],
			size = settings.font.size,
		},
		color = colors.green.dim,
		padding_left = 8,
	},
	label = {
		align = "left",
		font = {
			family = settings.font.text,
			style = settings.font.style_map["Bold"],
			size = settings.font.size,
		},
		color = colors.green.dim,
	},
	position = "e",
	padding_left = 1,
	padding_right = 1,
})

media:subscribe("mouse.clicked", function()
	sbar.exec("media-control toggle-play-pause && media-control get | jq -r '.playing'", function(playing)
		if playing:match("true") then
			media:set({ icon = { string = " 􀊆 " } })
		else
			media:set({ icon = { string = " 􀊄 " } })
		end
	end)
end)

media:subscribe("media_stream_changed", function(env)
	media:set({ drawing = "on" })
	if env.playing:match("true") then
		media:set({ icon = { string = " 􀊆 " } })
	else
		media:set({ icon = { string = " 􀊄 " } })
	end

	if
		env.artist
		and env.artist ~= ""
		and env.artist ~= "null"
		and env.title
		and env.title ~= ""
		and env.title ~= "null"
	then
		local label = " " .. env.artist .. " • " .. env.title .. "  "
		media:set({ label = { string = label, padding_right = 16 } })
	end
end)

media:subscribe("media_app_inactive", function()
	print("INACTIVE")
	media:set({ drawing = "off" })
end)

