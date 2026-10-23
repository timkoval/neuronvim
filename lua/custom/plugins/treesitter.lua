-- Parsers to install up front, the rest are installed when a filetype first needs them
local ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'vim', 'vimdoc' }

-- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
--  If you are experiencing weird indenting issues, add the language to
--  the list of additional_vim_regex_highlighting and disabled languages for indent.
local additional_vim_regex_highlighting = { 'ruby' }
local indent_disable = { 'ruby' }

return {
  { -- Highlight, edit, and navigate code
    -- The `main` branch is the rewrite for Neovim 0.12+, `master` is archived and its
    -- query directives break on 0.12. Needs `tree-sitter` CLI >= 0.26.1 and a C compiler.
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false, -- does not support lazy-loading
    build = ':TSUpdate',
    config = function()
      local ts = require 'nvim-treesitter'
      ts.install(ensure_installed)

      local function attach(buf, lang)
        if not vim.api.nvim_buf_is_valid(buf) or not pcall(vim.treesitter.start, buf, lang) then
          return
        end
        if vim.list_contains(additional_vim_regex_highlighting, lang) then
          vim.bo[buf].syntax = 'ON'
        end
        if not vim.list_contains(indent_disable, lang) then
          vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end

      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('custom-treesitter', { clear = true }),
        callback = function(args)
          local lang = vim.treesitter.language.get_lang(args.match)
          if not lang then
            return
          end
          if vim.treesitter.language.add(lang) then
            attach(args.buf, lang)
          elseif vim.list_contains(ts.get_available(), lang) then
            -- Autoinstall languages that are not installed
            ts.install(lang):await(function(err)
              if not err then
                vim.schedule(function()
                  attach(args.buf, lang)
                end)
              end
            end)
          end
        end,
      })
    end,
    -- There are additional nvim-treesitter modules that you can use to interact
    -- with nvim-treesitter. You should go explore a few and see what interests you:
    --
    --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
    --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects (`main` branch)
  },
}
-- vim: ts=2 sts=2 sw=2 et
