require "core"
local custom_init_path = vim.api.nvim_get_runtime_file("lua/custom/init.lua", false)[1]

if custom_init_path then
  dofile(custom_init_path)
end

require("core.utils").load_mappings()

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

-- bootstrap lazy.nvim!
if not vim.loop.fs_stat(lazypath) then
  require("core.bootstrap").gen_chadrc_template()
  require("core.bootstrap").lazy(lazypath)
end

dofile(vim.g.base46_cache .. "defaults")
vim.opt.rtp:prepend(lazypath)
require "plugins"

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- empty setup using defaults
require("nvim-tree").setup()

-- OR setup with some options
--require("nvim-tree").setup({
--  sort_by = "case_sensitive",
--  view = {
--    width = 30,
--  },
--  renderer = {
--    group_empty = true,
--  },
--  filters = {
--    dotfiles = true,
--  },
--})

--local function my_on_attach(bufnr)
--  local api = require "nvim-tree.api"

--  local function opts(desc)
--    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
--  end

  -- default mappings
 -- api.config.mappings.default_on_attach(bufnr)

  -- custom mappings
 -- vim.keymap.set('n', '<C-t>', api.tree.change_root_to_parent,        opts('Up'))
 -- vim.keymap.set('n', '?',     api.tree.toggle_help,                  opts('Help'))
--end

-- pass to setup along with your other options
--require("nvim-tree").setup {
  ---
--  on_attach = my_on_attach,
  ---
--}
-- IMPORTS
require("test2")
--require('plugin')         -- Variables
--require('opts')         -- Options
--require('keys')         -- Keymaps
--require('plug')         -- Plugins: UNCOMMENT THIS LINE
