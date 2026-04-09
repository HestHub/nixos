return {
  "seblyng/roslyn.nvim",
  ft = { "cs", "razor" },
  dependencies = {
    "tris203/rzls.nvim",
  },
  config = function(_, opts)
    require("roslyn").setup(opts)
  end,
  opts = {
    filewatching = "off",
  },
}
