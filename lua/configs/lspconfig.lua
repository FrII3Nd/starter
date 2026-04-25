local configs = require "nvchad.configs.lspconfig"

local function setup_smart_compile_commands()
  local root = vim.fn.getcwd()
  local handle = io.popen('find ' .. root .. '/cmake-build-* -name compile_commands.json 2>/dev/null | head -n 1')
  local found_path = handle:read("*a"):gsub("%s+", "")
  handle:close()

  if found_path ~= "" then
    os.execute('ln -sf ' .. found_path .. ' ' .. root .. '/compile_commands.json')
    print("LSP: Linked compile_commands from " .. found_path)
  end
end

-- Вызываем функцию при старте
setup_smart_compile_commands()

local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
},
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.lsp.config("clangd", {
  cmd = {
    "clangd",
    "--offset-encoding=utf-16",
    "--query-driver=/opt/Xilinx/Vitis/2024.2/gnu/aarch64/**/**/**/*g++,/opt/Xilinx/Vitis/2024.2/gnu/aarch32/**/*g++,/opt/Xilinx/Vitis/2024.2/gnu/riscv/**/**/**/*g++",
    "--background-index",
    "--clang-tidy",
    "--header-insertion=iwyu",
    "--header-insertion-decorators"
  },
  options = {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
    cmd = { "clangd", "--background-index", "--clang-tidy" },
  },

  filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
})

vim.lsp.enable "clangd"
vim.lsp.enable "lua_ls"
vim.g.clang_format_style = 'file'
vim.g.clang_format_fallback_style = 'llvm'
vim.g.clang_format_binary = "/home/linuxbrew/.linuxbrew/bin/clang-format"

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    configs.on_attach(client, args.buf)
  end,
})

vim.api.nvim_create_user_command("Format", function(args)
  require("conform").format({ args = args.fargs, async = args.bang })
end, { nargs = "*", bang = true, desc = "Format buffer using conform" })


