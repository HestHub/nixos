-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.list = false
vim.opt.scrolloff = 10

-- In Docker containers, inherit PATH from a login shell so version managers
-- (SDKMAN, nvm, etc.) are visible to LSP servers started by Neovim
if vim.fn.filereadable("/.dockerenv") == 1 then
  local handle = io.popen('bash -l -c "echo $PATH" 2>/dev/null')
  if handle then
    local path = handle:read("*l")
    handle:close()
    if path and path ~= "" then
      vim.env.PATH = path
    end
  end
end
