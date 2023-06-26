
local plugins = {
  {
    "wbthomason/packer.nvim",
  },
  {
    "wakatime/vim-wakatime",
    config = function()
      require("wakatime").setup({
        api_key_cmd = "echo 'waka_2c25f337-d60e-41a6-9c8b-a2856fc8dd94'",
      })
    end,
  },
  {
    "Hublot/vim-gromacs",
    ft = "gro",
  },
  {
    "dreamsofcode-io/ChatGPT.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim"
    },
    config = function()
      require("chatgpt").setup({
        api_key_cmd = "echo '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'",
      })
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end
  },
  {
    "mfussenegger/nvim-dap",
    config = function(_, opts)
    require("core.utils").load_mappings("dap")
    end
  },
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = {
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
    },
    config = function(_, opts)
    local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
    require("dap-python").setup(path)
    require("core.utils").load_mappings("dap")
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    ft = {"python"},
    opts = function()
      return require "custom.configs.null-ls"
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "black",
        "mypy",
        "ruff",
        "pyright",
      },
    },
  },
  {
      "neovim/nvim-lspconfig",
      config = function()
          require "plugins.configs.lspconfig"
          require "custom.configs.lspconfig"
      end,
  },
}
return plugins

