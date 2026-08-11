return {
  {
    "LazyVim/LazyVim",
    init = function()
      -- só executa se estiver dentro do Kitty
      if vim.env.KITTY_WINDOW_ID then
        local function set_spacing(value)
          vim.fn.jobstart({
            "kitty",
            "@",
            "set-spacing",
            "padding=" .. value,
            "margin=" .. value,
          }, {
            detach = true,
          })
        end

        vim.api.nvim_create_autocmd("VimEnter", {
          callback = function()
            set_spacing("0")
          end,
        })

        vim.api.nvim_create_autocmd("VimLeavePre", {
          callback = function()
            set_spacing("10")
          end,
        })
      end
    end,
  },
}
