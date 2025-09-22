return {
  "norcalli/nvim-colorizer.lua",
  config = function()
    require("colorizer").setup({
      filetypes = { "*" },
      user_default_options = {
        RGB = true, -- #RGB hex codes
        RRGGBB = true, -- #RRGGBB hex codes
        names = true, -- "Name" codes like Blue or blue
        RRGGBBAA = true, -- #RRGGBBAA hex codes
        AARRGGBB = true, -- 0xAARRGGBB hex codes
        rgb_fn = true, -- CSS rgb() and rgba() functions
        hsl_fn = true, -- CSS hsl() and hsla() functions
        css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
        -- Available modes for `mode`: foreground, background,  virtualtext
        mode = "virtualtext", -- Set the display mode.
        -- Available methods are false / true / "normal" / "lsp" / "both"
        -- True is same as normal
        tailwind = false, -- Enable tailwind colors
        -- parsers can contain values such as 'css', 'sass', 'scss' and 'less'
        sass = { enable = false, parsers = { "css" }, }, -- Enable sass colors
        virtualtext = "■",
      },
    })

    local color_file_path = vim.fn.expand("~") .. "/dev/me/nixos/dotfiles/sketchybar/colors.lua"
    local colors_lua = dofile(color_file_path)

    for name, value in pairs(colors_lua) do
      if type(value) == "number" then
        -- aarrggbb to #rrggbb
        local hex = string.format("#%06x", value & 0xffffff)
        require("colorizer").add_color(name, hex)
      end
    end
  end,
}
