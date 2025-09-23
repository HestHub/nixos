local icons = require("icons")
local settings = require("settings")
local colors = require("colors")
local color_state = require("color_state")

local popup_toggle = "sketchybar --set $NAME popup.drawing=toggle"

local apple_logo = sbar.add("item", {
	padding_left = 15,
	click_script = popup_toggle,
	icon = {
		padding_left = settings.padding.icon_item.icon.padding_left,
		padding_right = settings.padding.icon_item.icon.padding_right,
		string = icons.apple,
		color = colors.magenta.base,
	},
	label = { drawing = false },
	popup = {
		height = 25,
	},
})

apple_logo:subscribe({ "mouse.exited.global" }, function()
	apple_logo:set({ popup = { drawing = false } })
end)

apple_logo:subscribe("COLORS_UPDATED", function()
	if color_state.use_color then
		apple_logo:set({
			icon = { color = colors.magenta.base },
			background = { color = colors.black1 },
		})
	else
		apple_logo:set({
			icon = { color = colors.black1 },
			background = { color = colors.magenta.base },
		})
	end
end)

local function create_popup_item(icon, label, command)
	local item = sbar.add("item", {
		padding_left = 10,
		position = "popup." .. apple_logo.name,
		background = {
			border_width = 0,
			color = colors.transparent,
		},
		icon = {
			string = icon,
			color = colors.blue1,
		},
		label = label,
	})
	item:subscribe("mouse.clicked", function(_)
		sbar.exec(command)
		apple_logo:set({ popup = { drawing = false } })
	end)
	return item
end

create_popup_item("􀺽", "Settings", "open -a 'System Preferences'")
create_popup_item(
	"􀒳",
	"Lock",
	'osascript -e \'tell application "System Events" to keystroke "q" using {command down, control down}\''
)
create_popup_item("􀷄", "Shut down", "osascript -e 'tell app \"System Events\" to shut down'")
create_popup_item("􀷃", "Restart", "osascript -e 'tell app \"System Events\" to restart'")
create_popup_item("􀥦", "Sleep", "osascript -e 'tell app \"System Events\" to sleep'")
