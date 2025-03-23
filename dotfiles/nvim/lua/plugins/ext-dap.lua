return {
  "Cliffback/netcoredbg-macOS-arm64.nvim",
  dependencies = { "mfussenegger/nvim-dap" },

  init = function()
    require("netcoredbg-macOS-arm64").setup(require("dap"))
  end,
}
