-- GitHub issues and pull requests inside Neovim, via the `gh` CLI
-- See https://github.com/folke/snacks.nvim/blob/main/docs/gh.md

return {
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      gh = {},
      -- Snacks.gh is built on the snacks picker, so it has to be enabled
      picker = {
        enabled = true,
        -- telescope-ui-select already handles vim.ui.select
        ui_select = false,
        sources = {
          gh_issue = {},
          gh_pr = {},
        },
      },
    },
    keys = {
      { '<leader>gi', function() Snacks.picker.gh_issue() end, desc = '[G]itHub [i]ssues (open)' },
      { '<leader>gI', function() Snacks.picker.gh_issue { state = 'all' } end, desc = '[G]itHub [I]ssues (all)' },
      { '<leader>gp', function() Snacks.picker.gh_pr() end, desc = '[G]itHub [p]ull requests (open)' },
      { '<leader>gP', function() Snacks.picker.gh_pr { state = 'all' } end, desc = '[G]itHub [P]ull requests (all)' },
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
