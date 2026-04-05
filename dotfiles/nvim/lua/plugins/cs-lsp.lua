return {
  "seblyng/roslyn.nvim",
  ft = { "cs", "razor" },
  dependencies = {
    "tris203/rzls.nvim",
  },
  config = function(_, opts)
    local dotnet_root = os.getenv("DOTNET_ROOT") or "/usr/local/share/dotnet"
    vim.lsp.config("roslyn", {
      cmd_env = {
        DOTNET_ROOT = dotnet_root,
        DOTNET_HOST_PATH = dotnet_root .. "/dotnet",
      },
    })
    require("roslyn").setup(opts)
  end,
  opts = {
    filewatching = "off",
  },
}
