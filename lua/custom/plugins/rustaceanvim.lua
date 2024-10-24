-- rustaceanvim
-- https://github.com/saecki/rustaceanvim

return {
  'mrcjkb/rustaceanvim',
  version = '^5', -- Recommended
  lazy = false, -- This plugin is already lazy
  init = function()
    -- Configure rustaceanvim here
    vim.g.rustaceanvim = {
      server = {
        default_settings = {
          ['rust-analyzer'] = {
            files = {
              excludeDirs = { './target', './.direnv' },
            },
          },
        },
      },
    }
  end,
}
