return {
  "neovim/nvim-lspconfig",
  opts = {
    inlay_hints = { enabled = false },
    tab_line = { enabled = false },
    servers = {
      -- Enable the bicep server
      bicep = {
        cmd = { "Bicep.LangServer" },
        mason = false,
      },
    },
  },
}
