return {
  "ray-x/go.nvim",
  dependencies = { -- optional packages
    "ray-x/guihua.lua",
    "neovim/nvim-lspconfig",
    -- "nvim-treesitter/nvim-treesitter",
  },
  opts = function()
    require("go").setup({ lsp_inlay_hints = { enable = false } })
    local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*.go",
      callback = function()
        require("go.format").goimports()
      end,
      group = format_sync_grp,
    })
    return {}
  end,
  event = { "CmdlineEnter" },
  ft = { "go", "gomod" },
}
