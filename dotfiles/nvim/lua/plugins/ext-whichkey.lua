return {
  "folke/which-key.nvim",
  opts = {
    spec = {
      {
        "<leader>W",
        group = "windows",
        proxy = "<c-w>",
        expand = function()
          return require("which-key.extras").expand.win()
        end,
      },
    },
  },
}
