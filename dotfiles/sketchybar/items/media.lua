local colors = require("colors")
local settings = require("settings")
local state = require("color_state")

local media = sbar.add("item", {
	scroll_texts = "off",
	icon = {
		string = "􀑪",
		font = {
			family = settings.font.text,
			style = settings.font.style_map["Bold"],
			size = settings.font.size,
		},
		color = colors.green.dim,
		padding_left = 10,
		padding_right = 10,
	},
	label = {
		drawing = "off",
		align = "left",
		max_chars = 40,
		font = {
			family = settings.font.text,
			style = settings.font.style_map["Bold"],
			size = settings.font.size,
		},
		color = colors.green.dim,
	},
	background = {
		border_color = colors.with_alpha(colors.green.dim, 0.7),
	},
	position = "e",
	padding_left = 1,
	padding_right = 1,
})

media:subscribe("mouse.clicked", function()
	sbar.exec(settings.aerospace .. "list-apps | grep 'youtube-music'", function(_, exitCode)
		if exitCode == 1 then
			sbar.exec("open -a 'Youtube Music'")
			return
		end

		sbar.exec("media-control toggle-play-pause && media-control get | jq -r '.playing'", function(playing)
			if playing:match("true") then
				media:set({ icon = { string = "􀊆" } })
			else
				media:set({ icon = { string = "􀊄" } })
			end
		end)
	end)
end)

media:subscribe("mouse.entered", function()
	media:set({ scroll_texts = "on" })
end)

media:subscribe("mouse.exited", function()
	media:set({ scroll_texts = "off" })
end)

media:subscribe("media_stream_changed", function(env)
	if env.playing:match("true") then
		media:set({ icon = { string = "􀊆", padding_right = 5 } })
	else
		media:set({ icon = { string = "􀊄", padding_right = 5 } })
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
		media:set({ label = { string = label, padding_right = 16, drawing = "on" } })
	end
end)

media:subscribe("media_app_inactive", function()
	media:set({
		label = {
			drawing = "off",
			string = "",
		},
		icon = {
			string = "􀑪",
			padding_left = 10,
			padding_right = 10,
		},
	})
end)

media:subscribe("colors_toggled", function()
	if state.use_color then
		media:set({
			icon = { color = colors.green.dim },
			label = { color = colors.green.dim },
			background = { color = colors.bg1 },
		})
	else
		media:set({
			icon = { color = colors.black1 },
			label = { color = colors.black1 },
			background = { color = colors.green.dim },
		})
	end
end)
