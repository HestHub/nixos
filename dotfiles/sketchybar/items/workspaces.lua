local colors = require("colors")
local app_icons = require("helpers.app_icons")
local color_state = require("color_state")
local settings = require("settings")

local aerospace = settings.aerospace

local query_workspaces = ""
	.. aerospace
	.. "list-workspaces --all --format '%{workspace}%{monitor-appkit-nsscreen-screens-id}' --json"
-- Root is used to handle event subscriptions
local root = sbar.add("item", { drawing = false, update_freq = 10 })
local workspaces = {}

local function get_notifications_and_update(open_windows, focused_workspaces, visible_workspaces, f)
	local apps_to_check = {}
	for _, apps in pairs(open_windows) do
		for _, app in ipairs(apps) do
			apps_to_check[app] = true
		end
	end

	local app_count = 0
	for _ in pairs(apps_to_check) do
		app_count = app_count + 1
	end

	if app_count == 0 then
		local args = {
			open_windows = open_windows,
			focused_workspaces = focused_workspaces,
			visible_workspaces = visible_workspaces,
			notifications = {}, -- no apps, so no notifications
		}
		f(args)
		return
	end

	local notifications = {}
	local completed_checks = 0

	for app, _ in pairs(apps_to_check) do
		sbar.exec('lsappinfo info -only StatusLabel "' .. app .. '"', function(result)
			local label = ""
			if result then
				local extracted_value = result:match('"label"=s*"([^"]*)"')
				if
					extracted_value
					and extracted_value ~= "kCFNULL"
					and extracted_value ~= "NULL"
					and extracted_value ~= ""
				then
					label = "˚"
				end
			end
			notifications[app] = label
			completed_checks = completed_checks + 1

			if completed_checks == app_count then
				local args = {
					open_windows = open_windows,
					focused_workspaces = focused_workspaces,
					visible_workspaces = visible_workspaces,
					notifications = notifications,
				}
				f(args)
			end
		end)
	end
end

local function withWindows(f)
	local open_windows = {}
	-- Include the window ID in the query so we can track unique windows

	local get_windows = ""
		.. aerospace
		.. "list-windows --monitor all --format '%{workspace}%{app-name}%{window-id}' --json"

	local query_visible_workspaces = ""
		.. aerospace
		.. "list-workspaces --visible --monitor all --format '%{workspace}%{monitor-appkit-nsscreen-screens-id}' --json"
	local get_focus_workspaces = "" .. aerospace .. "list-workspaces --focused"
	sbar.exec(get_windows, function(workspace_and_windows)
		-- Use a set to track unique window IDs
		local processed_windows = {}

		for _, entry in ipairs(workspace_and_windows) do
			local workspace_index = entry.workspace
			local app = entry["app-name"]
			local window_id = entry["window-id"]

			-- Only process each window ID once
			if not processed_windows[window_id] then
				processed_windows[window_id] = true

				if open_windows[workspace_index] == nil then
					open_windows[workspace_index] = {}
				end

				-- Check if this app is already in the list for this workspace
				local app_exists = false
				for _, existing_app in ipairs(open_windows[workspace_index]) do
					if existing_app == app then
						app_exists = true
						break
					end
				end

				-- Only add the app if it's not already in the list
				if not app_exists then
					table.insert(open_windows[workspace_index], app)
				end
			end
		end

		sbar.exec(get_focus_workspaces, function(focused_workspaces)
			sbar.exec(query_visible_workspaces, function(visible_workspaces)
				get_notifications_and_update(open_windows, focused_workspaces, visible_workspaces, f)
			end)
		end)
	end)
end

local function updateWindow(workspace_index, args)
	local open_windows = args.open_windows[workspace_index]
	local focused_workspaces = args.focused_workspaces
	local visible_workspaces = args.visible_workspaces
	local notifications = args.notifications

	if open_windows == nil then
		open_windows = {}
	end

	local icon_line = ""
	local no_app = true
	for i, open_window in ipairs(open_windows) do
		no_app = false
		local app = open_window
		local lookup = app_icons[app]
		local icon = ((lookup == nil) and app_icons["Default"] or lookup)

		local notify = notifications[app] or ""

		icon_line = icon_line .. " " .. icon .. notify .. "  "
	end

	sbar.animate("tanh", 10, function()
		for i, visible_workspace in ipairs(visible_workspaces) do
			if no_app and workspace_index == visible_workspace["workspace"] then
				local monitor_id = visible_workspace["monitor-appkit-nsscreen-screens-id"]
				icon_line = " —"
				workspaces[workspace_index]:set({
					drawing = true,
					label = { string = icon_line },
					display = monitor_id,
				})
				return
			end
		end
		if no_app and workspace_index ~= focused_workspaces then
			workspaces[workspace_index]:set({
				drawing = false,
			})
			return
		end
		if no_app and workspace_index == focused_workspaces then
			icon_line = " —"
			workspaces[workspace_index]:set({
				drawing = true,
				label = { string = icon_line },
			})
		end

		workspaces[workspace_index]:set({
			drawing = true,
			label = { string = icon_line },
		})
	end)
end

local function updateWindows()
	withWindows(function(args)
		for workspace_index, _ in pairs(workspaces) do
			updateWindow(workspace_index, args)
		end
	end)
end

local function updateWorkspaceMonitor()
	local workspace_monitor = {}
	sbar.exec(query_workspaces, function(workspaces_and_monitors)
		for _, entry in ipairs(workspaces_and_monitors) do
			local space_index = entry.workspace
			local monitor_id = math.floor(entry["monitor-appkit-nsscreen-screens-id"])
			workspace_monitor[space_index] = monitor_id
		end
		for workspace_index, _ in pairs(workspaces) do
			workspaces[workspace_index]:set({
				display = workspace_monitor[workspace_index],
			})
		end
	end)
end

sbar.exec(query_workspaces, function(workspaces_and_monitors)
	for _, entry in ipairs(workspaces_and_monitors) do
		local workspace_index = entry.workspace

		local workspace = sbar.add("item", {
			background = {
				color = colors.transparent,
				drawing = true,
			},
			click_script = "" .. aerospace .. "workspace " .. workspace_index,
			drawing = false,
			icon = {
				drawing = false,
			},
			label = {
				color = colors.with_alpha(colors.blue2, 0.8),
				drawing = true,
				font = "sketchybar-app-font:Regular:16.0",
				highlight_color = colors.green.base,
				padding_left = 4,
				padding_right = 12,
				y_offset = -1,
			},
		})

		workspaces[workspace_index] = workspace

		workspace:subscribe("aerospace_workspace_change", function(env)
			local focused_workspace = env.FOCUSED_WORKSPACE
			local is_focused = focused_workspace == workspace_index

			sbar.animate("tanh", 10, function()
				workspace:set({
					icon = { highlight = is_focused },
					label = { highlight = is_focused },
					blur_radius = 30,
				})
			end)
		end)
	end

	-- Initial setup
	updateWindows()
	updateWorkspaceMonitor()

	-- Subscribe to window creation/destruction events
	root:subscribe("aerospace_workspace_change", function()
		updateWindows()
	end)

	-- Subscribe to front app changes too
	root:subscribe("front_app_switched", function()
		updateWindows()
	end)

	-- Subscribe to routine to update notifications
	root:subscribe("routine", function()
		updateWindows()
	end)

	root:subscribe("display_change", function()
		updateWorkspaceMonitor()
		updateWindows()
	end)

	sbar.exec("" .. aerospace .. "list-workspaces --focused", function(focused_workspace)
		local focused_workspace = focused_workspace:match("^%s*(.-)%s*$")
		workspaces[focused_workspace]:set({
			icon = { highlight = true },
			label = { highlight = true },
		})
	end)
end)

root:subscribe("colors_toggled", function()
	if color_state.use_color then
		for _, workspace in pairs(workspaces) do
			workspace:set({
				label = {
					color = colors.with_alpha(colors.blue2, 0.8),
					highlight_color = colors.green.base,
				},
				background = {
					color = colors.transparent,
				},
			})
		end
	else
		for _, workspace in pairs(workspaces) do
			workspace:set({
				label = {
					color = colors.black1,
					highlight_color = colors.white0_normal,
				},
				background = {
					color = colors.with_alpha(colors.blue0, 0.8),
				},
			})
		end
	end
end)
