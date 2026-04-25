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
    cmake_runner = { name = "overseer" },   -- Запуск программы в панели Overseer
    cmake_notifications = { runner = { enabled = true } },
    cmake_generate_options = { "-G", "Ninja" },
    save_before_run = false,
    post_build_save_before_run = false,  -- ← ADD THIS
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
  lazy = false, -- Чтобы подхватывал все системные окна сразу
  opts = {},
},
{
  "kdheepak/lazygit.nvim",
  lazy = false, -- Чтобы плагин был доступен сразу
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
},
{
  "folke/trouble.nvim",
  opts = {}, -- for default options, refer to the configuration section for custom setup.
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
{ "nvim-tree/nvim-web-devicons", opts = {} },
  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },

 {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "ravitemer/codecompanion-history.nvim",
    },
    event = "VeryLazy",
    display = {
      action_palette = {
        prompt = "Prompt ",
        provider = "default", -- Or "telescope"
        opts = {
          show_default_actions = true,
          show_default_prompt_library = true,
        },
      },
    },
    config = function()
      require("codecompanion").setup {
        -- Прямая привязка стратегий к адаптеру
        strategies = {
          chat = { adapter = "ollama" },
          inline = { adapter = "ollama" },
        },
        adapters = {
          ollama = function()
            return require("codecompanion.adapters").extend("ollama", {
              schema = {
                model = {
                  default = "kwangsuklee/Qwen3.5-9B.Q4_K_M-Claude-4.6-Opus-Reasoning-Distilled-v2:latest",
                },
                num_ctx = {
                  default = 16384,
                },
              },
            })
          end,
        },
      }
    end,
  },


{
  "MeanderingProgrammer/render-markdown.nvim",
  ft = { "markdown", "codecompanion" },
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
  opts = {
   preset = "obsidian", -- или "github"
 
    file_types = { "markdown", "codecompanion" },
    -- 1. Тонкая настройка заголовков (убираем "решетки", ставим иконки)
    heading = {
      enabled = true,
      sign = false,
      position = "overlay", -- перекрывает # красивым фоном
      icons = { "   ", "   ", "   ", "   ", "   ", "   " },
      Ibackgrounds = {
        "RenderMarkdownH1Bg",
        "RenderMarkdownH2Bg",
        "RenderMarkdownH3Bg",
      },
    },
    -- 2. Блоки кода (делаем их как в VS Code/Obsidian)
    code = {
      enabled = true,
      sign = false,
      style = "full",      -- заливка всего блока цветом
      position = "left",   -- прижать к левому краю
      language_pad = 2,    -- отступ для названия языка (python, lua)
      width = "block",     -- растягивать фон только по ширине кода
      left_pad = 2,
    },
    -- 3. Чекбоксы (для To-Do списков в чате)
    checkbox = {
      enabled = true,
      unchecked = { icon = "   " },
      checked = { icon = "   " },
    },
    -- 4. Буллеты (списки)
    bullet = {
        icons = { "●", "○", "◆", "◇" },
    },
  },
},
 {
    'MagicDuck/grug-far.nvim',
        event = "VeryLazy",

    -- Note (lazy loading): grug-far.lua defers all it's requires so it's lazy by default
    -- additional lazy config to defer loading is not really needed...
    config = function()
      vim.g.maplocalleader = ","
      -- optional setup call to override plugin options
      -- alternatively you can set options with vim.g.grug_far = { ... }
      require('grug-far').setup({
        -- options, see Configuration section below
        -- there are no required options atm
      });
    end
  },
  {
  "danymat/neogen",
  config = function()
    require("neogen").setup {
      enabled = true,
      languages = {
        cpp = { template = { annotation_convention = "doxygen" } },
        c = { template = { annotation_convention = "doxygen" } },
      }
    }
  end,
  dependencies = "nvim-treesitter/nvim-treesitter",
},
{
  "L3MON4D3/LuaSnip",
  dependencies = { "rafamadriz/friendly-snippets" },
  config = function()
    require("luasnip.loaders.from_vscode").lazy_load()
  end,
},
{
  "nvimdev/lspsaga.nvim",
  event = "LspAttach",
  config = function()
    require("lspsaga").setup({
      ui = {
        border = "rounded", -- Скругленные углы
        devicon = true,
      },
      hover = {
        max_width = 0.6,
        open_link = "gx",
      },
    })
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
    local ufo = require("ufo")
    ufo.setup(opts)

    vim.api.nvim_create_autocmd("BufReadPost", {
      callback = function()
        ufo.openAllFolds()
      end,
    })
  end,
}

}
