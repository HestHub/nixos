return {
  "seblyng/roslyn.nvim",
  ft = { "cs", "razor" },
  dependencies = {
    "tris203/rzls.nvim",
  },
  opts = {
    config = {
      settings = {
        ["csharp|background_analysis"] = {
          dotnet_analyzer_diagnostics_scope = "openFiles",
          dotnet_compiler_diagnostics_scope = "openFiles",
        },
      },
    },
    filewatching = "off",
  },
  init = function()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false

    require("roslyn").setup({
      capabilities = capabilities,
      filewatching = "off",
      on_attach = function(client, bufnr) end,
    })
  end,
}
