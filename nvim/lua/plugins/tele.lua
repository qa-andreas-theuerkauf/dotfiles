-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- Searching files and directories
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>se', require('telescope.builtin').oldfiles, { desc = '[S]earch r[E]cently opened files' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[R]esume' })
vim.keymap.set('n', '<leader>sb', require('telescope.builtin').buffers, { desc = '[S]earch existing [B]uffers' })
vim.keymap.set('n', '<leader>sc', '<cmd> lua FindFilesInCurrentFileDirectory()<CR>', { noremap = true, silent = true, desc = '[Search] Files in [C]urrent directory' })
vim.keymap.set('n', '<leader>sd', "<cmd>lua FindDirectories()<CR>", { desc = '[S]earch [D]irectories' }) 
vim.keymap.set('n', '<leader>dd', "<cmd>lua FindDirectoriesInCurrentFileDirectory()<CR>", { desc = 'Search [D]irectories in current [D]irecory' }) 

-- Reverse file name + path order (important for small displays)
local telescope = require('telescope')
telescope.setup {
  defaults = {
    path_display = function(opts, path)
      local reversed_path = path:match("^.+/(.+)$") -- Extrahiere den Dateinamen
      local rest_path = path:match("(.+)/.+$") -- Extrahiere den Pfad ohne Dateiname
      
      if rest_path then

        local parts = {}
        for part in rest_path:gmatch("[^/]+") do
          table.insert(parts, part)
        end

        -- Holen der letzten zwei Pfadteile
        local num_parts = #parts
        local last_two_parts_reversed = ""
        if num_parts > 1 then
          last_two_parts_reversed = parts[num_parts] .. " < " .. parts[num_parts - 1]
        elseif num_parts == 1 then
          last_two_parts_reversed = parts[num_parts]
        end

        return reversed_path .. " (" .. last_two_parts_reversed .. ")"
      else
        return reversed_path
      end
    end
  }
}

-- Helper for opening the standard Netrw explorer
-- vim.keymap.set('n', '<leader>ex', ':Ex %:p:h<CR>', { noremap = true, silent = true, desc = 'Open Netrw [EX]plorer in current directory'})

function FindFilesInCurrentFileDirectory()
    local current_file_directory = vim.fn.expand('%:p:h')
    require('telescope.builtin').find_files({ cwd = current_file_directory })
end

function FindDirectories()
    require('telescope.builtin').find_files({ find_command = {'find', '.', '-type', 'd' }})
end

function FindDirectoriesInCurrentFileDirectory()
    local current_file_directory = vim.fn.expand('%:p:h')
    require('telescope.builtin').find_files({
        cwd = current_file_directory,
        find_command = {'find', '.', '-type', 'd' }
    })
end

-- Link picker
local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local conf = require('telescope.config').values
local previewers = require('telescope.previewers')

local function get_links_in_buffer()
    local links = {}
    for line_num = 1, vim.fn.line('$') do
        local line = vim.fn.getline(line_num)
        -- Regex für Links (Markdown oder URLs)
        for url in line:gmatch('%b[]%b()') do
            table.insert(links, { url = url, line_num = line_num })
        end
    end
    return links
end

-- link_text = [text](url)
local function open_link(link_text)
    local url = link_text:match('%((.-)%)')

    -- Auf verschiedenen Plattformen unterschiedliche Befehle verwenden
    local open_cmd
    if vim.fn.has('mac') == 1 then
        open_cmd = 'open'
    elseif vim.fn.has('unix') == 1 then
        open_cmd = 'xdg-open'
    elseif vim.fn.has('win32') == 1 then
        open_cmd = 'start'
    else
        print("Unsupported OS")
        return
    end

    -- Öffne den Link
    vim.fn.jobstart({open_cmd, url}, { detach = true })
end

function _G.open_links_picker()
    local links = get_links_in_buffer()
    
    if #links == 0 then
        print("No links found in the current buffer.")
        return
    end

    pickers.new({}, {
        prompt_title = "Links in Current Buffer",
        finder = finders.new_table({
            results = links,
            entry_maker = function(entry)
                return {
                    value = entry.url,
                    display = entry.url,
                    ordinal = entry.url,
                    line_num = entry.line_num,
                }
            end,
        }),
        sorter = conf.generic_sorter({}), 
        attach_mappings = function(prompt_bufnr, map)
            actions.select_default:replace(function()
                local selection = action_state.get_selected_entry()
                actions.close(prompt_bufnr)
                -- Springe zur ausgewählten Zeile
                local target_line = math.min(selection.line_num, vim.api.nvim_buf_line_count(0))
                vim.api.nvim_win_set_cursor(0, {target_line, 0})
            end)

            map('i', '<C-o>', function()
                local current_picker = action_state.get_current_picker(prompt_bufnr)
                local links = current_picker:get_multi_selection()
                local has_multi_selection = (next(links) ~= nil)

                if(has_multi_selection) then
                    for _, link_entry in ipairs(links) do
                        open_link(link_entry.value)
                    end
                else
                    local selection = action_state.get_selected_entry()
                    if selection then
                        open_link(selection.value)
                    end
                end
            end)

            map('i', '<C-p>', function()
                local picker = action_state.get_current_picker(prompt_bufnr)
                local manager = picker.manager

                for entry in manager:iter() do
                    open_link(entry.value)
                end
            end)
 
            return true
        end,
    }):find()
end

vim.api.nvim_set_keymap('n', '<leader>fl', ':lua _G.open_links_picker()<CR>', { noremap = true, silent = true })


