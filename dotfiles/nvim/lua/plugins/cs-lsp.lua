return {
  "seblyng/roslyn.nvim",
  ft = { "cs", "razor" },
  dependencies = {
    "tris203/rzls.nvim",
  },
  config = function(_, opts)
    vim.lsp.config("roslyn", {
      cmd_env = {
        DOTNET_ROOT = "/usr/local/share/dotnet",
        DOTNET_HOST_PATH = "/usr/local/share/dotnet/dotnet",
      },
    })
    require("roslyn").setup(opts)
  end,
  opts = {
    filewatching = "off",
  },
}
