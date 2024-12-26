--TODO: Make better comment about plugins...
--NOTE: Taking notes about learnings...
--WARNING: Stop procastinating..
--BUG: Testing features of NVChad
--
vim.opt.cmdheight = 0
return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    opts = function()
      local dashboard = require "alpha.themes.dashboard"

      dashboard.section.header.val = {
        "                                                    ",
        " ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
        " ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
        " ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
        " ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
        " ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
        " ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
        "                                                    ",
      }

      dashboard.section.buttons.val = {
        dashboard.button("n", "  New file", "<cmd>ene<CR>"),
        dashboard.button(
          "SPC q l",
          "  Restore last session",
          [[<cmd>lua require("persistence").load({ last = true })<CR>]]
        ),
        dashboard.button("SPC f r", "  Recent files", "<cmd>Telescope oldfiles<CR>"),
        dashboard.button("SPC f f", "  Find file", "<cmd>Telescope find_files<CR>"),
        dashboard.button("SPC f p", "  Projects", "<cmd>Telescope projects<CR>"),
        dashboard.button("l", "󰒲  Lazy", "<cmd>Lazy<CR>"),
        dashboard.button("m", "󱌣  Mason", "<cmd>Mason<CR>"),
        dashboard.button("q", "  Quit", "<cmd>qa<CR>"),
      }

      return dashboard
    end,
    config = function(_, dashboard)
      local alpha = require "alpha"

      vim.api.nvim_create_autocmd("User", {
        callback = function()
          local stats = require("lazy").stats()
          local ms = math.floor(stats.startuptime * 100) / 100
          dashboard.section.footer.val = "󱐌 Lazy-loaded "
            .. stats.loaded
            .. "/"
            .. stats.count
            .. " plugins in "
            .. ms
            .. "ms"
          pcall(vim.cmd.AlphaRedraw)
        end,
      })

      alpha.setup(dashboard.opts)
    end,
  },
  {
    "Pocco81/auto-save.nvim",
  },
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local conform = require "conform"

      conform.setup {
        formatters_by_ft = {
          javascript = { "prettier" },
          typescript = { "prettier" },
          javascriptreact = { "prettier" },
          typescriptreact = { "prettier" },
          svelte = { "prettier" },
          css = { "prettier" },
          html = { "prettier" },
          json = { "prettier" },
          yaml = { "prettier" },
          markdown = { "prettier" },
          graphql = { "prettier" },
          liquid = { "prettier" },
          lua = { "stylua" },
          python = { "isort", "black" },
        },
        format_on_save = {
          lsp_fallback = true,
          async = false,
          timeout_ms = 1000,
        },
      }

      vim.keymap.set({ "n", "v" }, "<leader>mp", function()
        conform.format {
          lsp_fallback = true,
          async = false,
          timeout_ms = 1000,
        }
      end, { desc = "Format file or range (in visual mode)" })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
      },
    },
  },
  {
    "OXY2DEV/markview.nvim",
    lazy = false, -- Recommended
    -- ft = "markdown" -- If you decide to lazy-load anyway

    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
  },
  {
    "folke/todo-comments.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local todo_comments = require "todo-comments"

      -- set keymaps
      local keymap = vim.keymap -- for conciseness

      keymap.set("n", "]t", function()
        todo_comments.jump_next()
      end, { desc = "Next todo comment" })

      keymap.set("n", "[t", function()
        todo_comments.jump_prev()
      end, { desc = "Previous todo comment" })

      todo_comments.setup()
    end,
  },
  {
    "wakatime/vim-wakatime",
    event = "VeryLazy",
  },
  {
    "olimorris/onedarkpro.nvim",
    priority = 1000, -- Ensure it loads first
  },
  {
    "navarasu/onedark.nvim",
  },
  {
    "ethanholz/nvim-lastplace",
  },
  {
    "tribela/transparent.nvim",
    event = "VimEnter",
    config = true,
  },
}
