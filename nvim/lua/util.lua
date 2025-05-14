-- Insert date at current cursor
vim.keymap.set('n', '<leader>id', "<cmd> lua InsertDateAtCursor()<CR>", {desc ='[I]nsert the current [D]ate at your cursor. Format: yyyy-mm-dd'})

-- Insert file name title for markdown notes
vim.keymap.set('n', '<leader>if', "<cmd> lua InsertFileNameWithoutExtension()<CR>", {desc = '[I]nsert the [F]ile name as markdown top title'})

-- If you get lost in the keymap jungle, use the telescope!
vim.keymap.set('n', '<leader>g?', require('telescope.builtin').keymaps, {desc = 'If you get lost in the keymap jungle, use the telescope!'})

-- Toggle line numbers
vim.keymap.set('n', '<F1>', "<cmd> lua ToggleLineNumbers()<CR>")

-- Print current file dir 
vim.api.nvim_set_keymap('n', '<leader>pf', ':lua PrintCurrentFileDir()<CR>', { noremap = true, silent = true, desc = '[P]rint current [F]ile directory'})

vim.api.nvim_set_keymap('n', '<leader>cd', ':lua OpenTmuxPaneAtCurrentFileDir()<CR>', { noremap = true, silent = true, desc = 'Open tmux pane in [C]urrent file [D]irectory'})

function InsertDateAtCursor()
    local date = InsertCurrentDate()
    vim.api.nvim_put({date .. "  "},'',true,true)
    vim.cmd('startinsert')
end


function InsertCurrentDate()
    local date = os.date("%Y-%m-%d")  -- Format yyyy-mm-dd
    return date
end

function InsertFileNameWithoutExtension()
    local filename = vim.fn.expand('%:t:r')
    vim.api.nvim_put({"# " .. filename},'',true,true)
    vim.api.nvim_put({'',''},'l',true,true)
    vim.cmd('startinsert')
end

function ToggleLineNumbers()
    local num = vim.wo.number -- check if line numbers are currently displayed
    -- Toggle the setting
    vim.wo.number = not num
    --vim.wo.relativenumber = not num
end

function PrintCurrentFileDir()
  local current_file_dir = vim.fn.expand('%:p:h')
  print(current_file_dir)
end

function OpenTmuxPaneAtCurrentFileDir()
  local current_file_dir = vim.fn.expand('%:p:h')
  local escaped_dir = string.gsub(current_file_dir, " ", "\\ ")
  local cmd = 'tmux split-window -h "cd ' .. escaped_dir .. ' && vim -c \':Explore\'"'
  vim.fn.system(cmd)
end
