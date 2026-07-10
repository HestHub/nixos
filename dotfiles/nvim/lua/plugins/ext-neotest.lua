return {
  "nvim-neotest/neotest",
  commit = "52fca6717ef972113ddd6ca223e30ad0abb2800c",
  ft = { "go", "rust", "python", "cs", "typescript", "javascript" },
  dependencies = {
    -- "nvim-neotest/neotest-go",
    "rouge8/neotest-rust",
    "nvim-neotest/neotest-jest",
    -- "rcasia/neotest-java",
  },
  opts = function()
    return {
      -- your neotest config here
      adapters = {
        require("neotest-rust"),
        -- require("neotest-go"),
        require("neotest-jest"),
      },
    }
  end,
}
