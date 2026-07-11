return {
  "nvim-neotest/neotest",
  ft = { "go", "rust", "python", "cs", "typescript", "javascript" },
  dependencies = {
    "nvim-neotest/neotest-go",
    "rouge8/neotest-rust",
    "nvim-neotest/neotest-jest",
    -- "rcasia/neotest-java",
  },
  opts = function()
    return {
      adapters = {
        require("neotest-go"),
        require("neotest-rust"),
        require("neotest-jest"),
      },
    }
  end,
}
