vim.api.nvim_create_user_command("FormatTable", function(opts)
  -- Define potential paths for the GNU/util-linux version of column
  local paths = {
    "/opt/homebrew/opt/util-linux/bin/column", -- Apple Silicon Homebrew
    "/usr/local/opt/util-linux/bin/column", -- Intel Homebrew
    "column", -- Fallback/System
  }

  local cmd_path = "column" -- Default
  for _, path in ipairs(paths) do
    if vim.fn.executable(path) == 1 then
      cmd_path = path
      break
    end
  end

  -- Construct the command string
  -- We use the range passed to the command (opts.line1 to opts.line2)
  local range = opts.line1 .. "," .. opts.line2

  -- Note: We add spaces around the separator for better MD readability " | "
  local full_cmd = string.format("%s!%s -t -s '|' -o ' | '", range, cmd_path)

  vim.cmd(full_cmd)
end, {
  range = true,
  desc = "Format Markdown table using GNU column (Homebrew/Nix compatible)",
})
