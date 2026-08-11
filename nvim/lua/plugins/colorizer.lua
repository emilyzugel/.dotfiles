return {
  {
    "NvChad/nvim-colorizer.lua",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      filetypes = { "*" }, -- ativa em todos os tipos de arquivo
      user_default_options = {
        RGB = true, -- #RGB
        RRGGBB = true, -- #RRGGBB
        names = true, -- nomes tipo "blue", "red"
        RRGGBBAA = true, -- #RRGGBBAA
        rgb_fn = true, -- rgb(), rgba()
        hsl_fn = true, -- hsl(), hsla()
        css = true, -- suporte a cores CSS
        css_fn = true,
        tailwind = true, -- (opcional) suporte a cores Tailwind
      },
    },
  },
}
