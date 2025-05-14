require("gp").setup({
    openai_api_key = {"op", "read", "op://api-integrations/gp-nvim-chatgpt-api-key/password"},
    chat_free_cursor = true,

    hooks = {
		-- example of adding command which opens new chat dedicated for translation
		GermanToChineseTranslator = function(gp, params)
		local translator_system_prompt = "You are a Translator, please translate between German and Chinese."
		gp.cmd.ChatNew(params, translator_system_prompt)
        end,

        -- terminal command helper
        TerminalCommandHelper = function(gp, params)
        local terminal_system_prompt = "You are a Command Line Expert, please suggest the best fitting command for the console. I use iTerm2 on MacOs with zsh.\n\n"
            .. "Please AVOID COMMENTARY OUTSIDE OF THE SNIPPET RESPONSE.\n"
        gp.cmd.ChatNew(params, terminal_system_prompt)
        end
    }
})

-- Keymaps go here
local function keymapOptions(desc)
    return {
        noremap = true,
        silent = true,
        nowait = true,
        desc = "GPT prompt " .. desc,
    }
end

vim.keymap.set({"n", "i"}, "<C-g>c", "<cmd>GpChatNew<cr>", keymapOptions("New Chat"))
vim.keymap.set({"n", "i"}, "<C-g>f", "<cmd>GpChatFinder<cr>", keymapOptions("Chat Finder"))
vim.keymap.set({"n", "i", "v", "x"}, "<C-g>s", "<cmd>GpStop<cr>", keymapOptions("Stop"))

-- the following function does not work, because `new_chat` does not accept a path as argument
-- function _G.create_project_chat()
    -- -- Hole das aktuelle Arbeitsverzeichnis
    -- local current_dir = vim.fn.getcwd()
-- 
    -- -- Definiere den Pfad zum Chat-Ordner relativ zum aktuellen Verzeichnis
    -- local chat_dir = current_dir .. "/gp/chat"
-- 
    -- -- Erstelle den Chat-Ordner, falls er nicht existiert
    -- if vim.fn.isdirectory(chat_dir) == 0 then
        -- vim.fn.mkdir(chat_dir, "p")
    -- end
-- 
    -- -- Definiere den Dateinamen für den Chat (z.B., mit Zeitstempel)
    -- local chat_file = chat_dir .. "/" .. os.date("%Y-%m-%d_%H-%M-%S") .. ".md"
    -- print(chat_file)
-- 
    -- -- Erstelle und öffne die Chat-Datei mit gp.nvim
    -- require('gp').new_chat(chat_file)
-- end
-- 
-- vim.api.nvim_set_keymap('n', '<leader>nc', ":lua _G.create_project_chat()<CR>", { noremap = true, silent = true })
