-- Stolen from:
-- https://github.com/ian-pascoe/dotfiles/tree/master

local colors = require("colors")
local settings = require("settings")

local blueutil = settings.blueutil

local icons = {
	bluetooth = {
		on = "󰂯",
		off = "󰂲",
	},
}

---@class items.control_center.bluetooth
local M = {}

M.button = sbar.add("item", "bluetooth.button", {
	position = "q",
	padding_left = 0,
	padding_right = 0,
	background = {
		border_color = colors.transparent,
	},
	icon = {
		drawing = true,
		string = icons.bluetooth.on,
		font = {
			size = 19,
		},
		padding_left = 8,
	},
	label = {
		drawing = false,
		padding_left = 0,
		padding_right = 8,
	},
	popup = {
		height = 30,
	},
	update_freq = 60,
})

M.button:subscribe("mouse.entered", function()
	M.button:set({ popup = { drawing = true } })
end)

M.button:subscribe({
	"mouse.exited.global",
	"mouse.exited",
}, function()
	M.button:set({ popup = { drawing = false } })
end)

-- Toggle bluetooth with mouse click
M.button:subscribe("mouse.clicked", function()
	sbar.exec(blueutil .. "-p", function(state)
		if tonumber(state) == 0 then
			sbar.exec(blueutil .. "-p 1")
			M.button:set({
				icon = {
					string = icons.bluetooth.on,
					color = colors.blue2,
				},
			})
		else
			sbar.exec(blueutil .. "-p 0")
			M.button:set({
				icon = {
					string = icons.bluetooth.off,
					-- color = colors.muted.background,
				},
			})
		end

		-- Util.sleep(1)
		sbar.trigger("bluetooth_update")
	end)
end)

M.paired = {}

M.connected = {}

-- Sanitize a string so it can be safely used as a SketchyBar item name
local function sanitize_name(s)
	return (s or "")
		:gsub("%s+", "_") -- spaces -> underscore
		:gsub("[^%w_%-%./]", "_") -- any disallowed character -> underscore
end

-- Parse a device line to extract its MAC address (supports '-' or ':')
local function parse_address(line)
	local addr = line:match("address%s+([%x%-%:]+)")
	if not addr then
		addr = line:match("([%x][%x:%-][%x:%-][%x:%-][%x:%-][%x:%-][%x:%-]+)") -- very loose fallback
	end
	return addr
end

-- Fetch bluetooth status and devices
M.button:subscribe({
	"routine",
	"forced",
	"bluetooth_update",
	"system_woke",
}, function()
	sbar.exec(blueutil .. "-p", function(state)
		-- Clear existing devices in tooltip
		local existingEvents = M.button:query()
		if existingEvents.popup and next(existingEvents.popup.items) ~= nil then
			for _, item in pairs(existingEvents.popup.items) do
				sbar.remove(item)
			end
		end

		if tonumber(state) == 0 then
			M.button:set({
				icon = {
					string = icons.bluetooth.off,
					-- color = colors.muted.background,
				},
			})
			return
		end

		M.button:set({
			icon = {
				string = icons.bluetooth.on,
				color = colors.blue2,
			},
		})

		-- Get paired and connected devices
		sbar.exec(blueutil .. "--paired", function(paired)
			M.paired.header = sbar.add("item", "bluetooth.paired.header", {
				icon = {
					drawing = false,
				},
				label = {
					string = "Paired Devices",
					font = {
						style = "Bold",
						size = 14,
					},
				},
				position = "popup." .. M.button.name,
			})

			-- Iterate over the list of paired devices
			for device in paired:gmatch("[^\n]+") do
				local label = device:match('"(.*)"')
				local safe_label = sanitize_name(label)
				local address = parse_address(device)
				M.paired[safe_label] = sbar.add("item", "bluetooth.paired.device." .. safe_label, {
					icon = {
						drawing = false,
					},
					label = {
						string = label .. (address and "" or " (no addr)"),
					},
					position = "popup." .. M.button.name,
					click_script = address
							and ('if [ "$(blueutil --is-connected ' .. address .. ')" = 1 ]; then blueutil --disconnect ' .. address .. "; else blueutil --connect " .. address .. "; fi; sketchybar --trigger bluetooth_update")
						or nil,
				})
			end

			-- Fetch connected devices
			sbar.exec("blueutil --connected", function(connected)
				M.connected.header = sbar.add("item", "bluetooth.connected.header", {
					icon = {
						drawing = false,
					},
					label = {
						string = "Connected Devices",
						font = {
							style = "Bold",
							size = 14,
						},
					},
					position = "popup." .. M.button.name,
				})

				for device in connected:gmatch("[^\n]+") do
					local label = device:match('"(.*)"')
					local safe_label = sanitize_name(label)
					local address = parse_address(device)
					M.connected[safe_label] = sbar.add("item", "bluetooth.connected.device." .. safe_label, {
						icon = {
							drawing = false,
						},
						label = {
							string = label .. (address and "" or " (no addr)"),
						},
						position = "popup." .. M.button.name,
						click_script = address
								and (string.format(
									'if [ "$(%s --is-connected %s)" = 1 ]; then %s --disconnect %s; else %s --connect %s; fi; sketchybar --trigger bluetooth_update',
									blueutil,
									address,
									blueutil,
									address,
									blueutil,
									address
								))
							or nil,
					})
				end
			end)
		end)
	end)
end)

return M
