return {
  "folke/snacks.nvim",
  opts = {
    indent = {
      indent = {
        enabled = false,
      },
      chunk = {
        enabled = true,
        only_current = true,
        char = {
          horizontal = "─",
          vertical = "│",
          corner_top = "╭",
          corner_bottom = "╰",
          -- corner_top = "╭",
          -- corner_bottom = "╰",
          arrow = "─",
        },
      },
    },
  },
}
