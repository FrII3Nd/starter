require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", "<leader>fc", "<cmd>Telescope commands<cr>", { desc = "Telescope Find commands" })
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "<leader>gg", "<cmd>LazyGit<cr>", { desc = "LazyGit (GUI)" })

map("n", "<leader>oo", "<cmd>OverseerToggle!<cr>", { desc = "Overseer Toggle" })

map("n", "<leader>fm", "<cmd>Format<cr>", { desc = "Format file with conform" })

map("n", "<leader>cg", "<cmd>CMakeGenerate<cr>", { desc = "CMake Generate" })
map("n", "<leader>cb", "<cmd>CMakeBuild<cr>", { desc = "CMake Build" })
map("n", "<leader>cc", "<cmd>CMakeClean<cr>", { desc = "CMake Clean" })
map("n", "<leader>ct", "<cmd>CMakeSelectBuildTarget<cr>", { desc = "CMake Select Target" })
map("n", "<leader>cp", "<cmd>CMakeSelectBuildPreset<cr>", { desc = "CMake Select Build Preset" })

map("n", "<leader>ba", ":%bd<CR>", { desc = "Close all buffers" })

map("n", "<leader>bo", ":%bd|e#|bd#<CR>", { desc = "Close all buffers except current" })
map("n", "<leader>df", function()
  require("neogen").generate()
end, { desc = "Neogen: Generate docs" })
map("i", "<Tab>", function()
  if require("neogen").jumpable() then
    require("neogen").jump_next()
  else
    return "<Tab>"
  end
end, { expr = true, desc = "Neogen: Jump next field" })

map("i", "<S-Tab>", function()
  if require("neogen").jumpable(1) then
    require("neogen").jump_prev()
  else
    return "<S-Tab>"
  end
end, { expr = true, desc = "Neogen: Jump prev field" })

map("n", "K", "<cmd>Lspsaga hover_doc<CR>", { desc = "LSP: Hover Docs (Saga)" })


-- Normal and Visual mode mappings
vim.keymap.set({ "n", "v" }, "<leader>ac", "<cmd>CodeCompanionChat Toggle<cr>", { desc = "Toggle AI Chat" })
vim.keymap.set({ "n", "v" }, "<leader>aa", "<cmd>CodeCompanionActions<cr>", { desc = "AI Actions Menu" })
vim.keymap.set({ "n", "v" }, "<leader>ai", "<cmd>CodeCompanion<cr>", { desc = "Inline AI Prompt" })

-- Visual mode specific: Add selected code to the chat
vim.keymap.set("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { desc = "Add selection to AI Chat" })

vim.keymap.set({ "n", "v" }, "<leader>fr", "<cmd>GrugFarWithin<cr>", { desc = "Find & Replace" })



