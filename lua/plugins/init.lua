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
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig" -- ваш файл с настройками
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "vim", "lua", "cpp", "c", "cmake" },
    },
  },

  {
    "Civitasv/cmake-tools.nvim",
    event = "VeryLazy",
    dependencies = { "stevearc/overseer.nvim" },
    opts = {
      cmake_executor = { name = "overseer" }, -- Вывод сборки в панель Overseer
      cmake_runner = { name = "overseer" }, -- Запуск программы в панели Overseer
      cmake_notifications = { runner = { enabled = true } },
      cmake_generate_options = { "-G", "Ninja" },
      save_before_run = false,
      post_build_save_before_run = false, -- ← ADD THIS
    },
  },
  {
    "stevearc/overseer.nvim",
    opts = {
      cmake_executor = {
        name = "overseer",
        opts = {},
      },
    },
  },

  {
    "stevearc/dressing.nvim",
    lazy = false,
    opts = {},
  },
  {
    "kdheepak/lazygit.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  {
    "folke/trouble.nvim",
    opts = {},
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },
  {
    "MagicDuck/grug-far.nvim",
    event = "VeryLazy",

    config = function()
      vim.g.maplocalleader = ","
      require("grug-far").setup {}
    end,
  },
  {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
    build = "make install_jsregexp",
    config = function()
      require "nvchad.configs.luasnip"
      require("luasnip.loaders.from_vscode").lazy_load {
        paths = { vim.fn.stdpath "config" .. "/lua/snippets" },
      }
    end,
  },
  {
    "nvimdev/lspsaga.nvim",
    event = "LspAttach",
    config = function()
      require("lspsaga").setup {
        ui = {
          border = "rounded",
          devicon = true,
        },
        hover = {
          max_width = 0.6,
          open_link = "gx",
        },
      }
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
  },
  {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    event = "BufReadPost",
    opts = {
      provider_selector = function(bufnr, filetype, buftype)
        return { "treesitter", "indent" }
      end,
    },
    config = function(_, opts)
      local ufo = require "ufo"
      ufo.setup(opts)

      vim.api.nvim_create_autocmd("BufReadPost", {
        callback = function()
          ufo.openAllFolds()
        end,
      })
    end,
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      -- Это сделает уведомления и hover красивыми
    },
    opts = {
      lsp = {
        hover = { enabled = true },
        signature = { 
          enabled = true,      -- Enable noice to capture signature help
          auto_open = {
            enabled = false,
          }, -- Don't open automatically on typing
        },
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.set_autocmds_to_reply_to_context"] = true,
          ["interface.hover"] = true,
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
      },
    },
  },
  {
    "p00f/clangd_extensions.nvim",
    config = function()
      require("clangd_extensions").setup({
        symbol_info = {
          border = "rounded",  -- Optional styling
        },
      })
    end,
  },
  -- Mason DAP для автоматической установки codelldb
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      automatic_installation = true,
      handlers = {
        function(config)
          require("mason-nvim-dap").default_setup(config)
        end,
        codelldb = function(config)
          config.adapters = {
            type = "server",
            host = "127.0.0.1",
            port = "${port}",
            executable = {
              command = "codelldb",
              args = { "--port", "${port}" },
            },
          }
          require("mason-nvim-dap").default_setup(config)
        end,
      },
    },
  },
  -- NVIM DAP с автоматическим получением цели из CMake
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "jay-babu/mason-nvim-dap.nvim",
      "igorlfs/nvim-dap-view",
    },
    config = function()
      local dap = require("dap")
      local dap_view = require("dap-view")

      dap_view.setup()

      -- Автоматическое открытие/закрытие интерфейса отладки
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dap_view.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dap_view.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dap_view.close()
      end

      -- Настройка конфигурации для C++
      dap.configurations.cpp = {
        {
          name = "Launch CMake Target (codelldb)",
          type = "codelldb",
          request = "launch",
          -- Автоматическое получение пути к исполняемому файлу из cmake-tools
          program = function()
            local ok, cmake = pcall(require, "cmake-tools")
            if not ok then
              print("cmake-tools not found")
              return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/build/", "file")
            end
            local target_name = cmake.get_build_target()
            local build_dir = cmake.get_build_directory()

            if not target_name or target_name == "" then
              print("CMake: Target not selected! Use :CMakeSelectTarget")
              return vim.fn.input("Path to executable (fallback): ", vim.fn.getcwd() .. "/build/", "file")
            end

            -- Путь обычно: build_dir/<target_name>
            local exec_path = build_dir .. "/" .. target_name
            
            -- Проверка существования файла
            if vim.fn.executable(exec_path) == 0 then
              print("Executable not found at: " .. exec_path)
              print("Make sure you built the project with CMake (Debug mode).")
              return vim.fn.input("Path to executable (fallback): ", build_dir .. "/", "file")
            end
            
            return exec_path
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
          console = "integratedTerminal",
        },
      }
      dap.configurations.c = dap.configurations.cpp
    end,
  },
}
