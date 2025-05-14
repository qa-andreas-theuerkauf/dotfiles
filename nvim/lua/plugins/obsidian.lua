require("obsidian").setup({
  workspaces = {
        {
            name = "Zettelkasten Work",
            path = "~/Work/Knowledge/Zettelkasten",
        },
        {
            name = "Zettelkasten Private",
            path = "~/Private/Knowledge/Zettelkasten"
        }
    },

    notes_subdir = "1 Fleeting Notes/1.1 Inbox/",
    new_notes_location = "notes_subdir",

    ui = { enable = false },
    -- No default yaml-template should be inserted at saving:
    disable_frontmatter = true,
    completion = {
        nvim_cmp = true,
        min_chars = 2
    },
    picker = {
        name = "telescope.nvim"
    },

    -- Does not work as expected:
    --search = {
    --    method = "rg",
    --    args = {"--hidden", "--line-number", "--column", "--smart-case", "--regexp"}
    --},
   
    -- 
    mappings = {
        ["gf"] = {
          action = function()
            local current_line = vim.fn.getline('.')
            local jetbrains_link = current_line:match("%[.-%]%((jetbrains://.+)%)")
            if jetbrains_link then
              vim.fn.system('open "' .. jetbrains_link .. '"')
            else
              return require("obsidian").util.gf_passthrough()
            end
          end,
          opts = { noremap = false, expr = true, buffer = true },
        }
    },
    
    note_id_func = function(title)
        local suffix = title or ""
        if suffix == "" then
            for _ = 1, 4 do
                suffix = suffix .. string.char(math.random(65, 90))
            end
            suffix = tostring(os.date("%Y-%m-%d")) .. "-" .. suffix
        end
        --return tostring(os.date("%Y-%m-%d")) .. "-" .. suffix
        return suffix
    end,

    -- function for `:ObsidianFollowLink`
    follow_url_func = function(url)
        -- Open the URL in the default web browser.
        vim.fn.jobstart({"open", url})  -- Mac OS
        -- vim.fn.jobstart({"xdg-open", url})  -- linux
    end

})

local cmp = require'cmp'

cmp.setup({
    mapping = {
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-e>"] = cmp.mapping.close(),
        ["<CR>"] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Insert,
        },
        ['<C-Space>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.confirm({ select = true })
            else
                fallback()
            end
        end, { "i", "s" }),
    },
    sources = cmp.config.sources({
      { name = 'obsidian' },
      { name = 'obsidian_new' },
      { name = 'obsidian_tags' }
    })
})

-- TODO: image support

-- keymappings
function new_note_with_date_prefix()
    local date_prefix = os.date("%Y-%m-%d")
    vim.ui.input({ prompt = date_prefix .. '-Titel: ' }, function(title)
        if title then
            local full_title = date_prefix .. "-" .. title
            vim.cmd('ObsidianNew ' .. full_title)
            vim.api.nvim_put({''},'l',true,true)
            vim.cmd('startinsert')
        end
    end)
end

function new_note()
    vim.ui.input({ prompt = 'Titel: ' }, function(title)
        if title then
            vim.cmd('ObsidianNew ' .. title)
        else
            vim.cmd('ObsidianNew  ')
        end
        vim.api.nvim_put({''},'l',true,true)
        vim.cmd('startinsert')
    end)
end


vim.api.nvim_set_keymap(
  'n', 
  '<leader>nd', 
  ':lua new_note_with_date_prefix()<CR>', 
  { noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
  'n', 
  '<leader>n', 
  ':lua new_note()<cr>', 
  { noremap = true, silent = true }
)

vim.api.nvim_set_keymap('n', '<leader>ng', ':ObsidianSearch<CR>', { noremap = true, silent = true, desc = '[N]ode [G]rep' })
vim.api.nvim_set_keymap('n', '<leader>qs', ':ObsidianQuickSwitch<CR>', { noremap = true, silent = true, desc = '[Q]uick [S]witch' })





