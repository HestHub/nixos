return {
  "neovim/nvim-lspconfig",
  opts = {
    inlay_hints = { enabled = false },
    tab_line = { enabled = false },
    servers = {
      nil_ls = {
        mason = false,
      },
    },
  },
}
