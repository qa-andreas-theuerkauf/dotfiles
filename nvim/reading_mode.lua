-- My beautiful custom Reading Mode
-- Use this global variable for echoing the reading mode in the status line
vim.g.reading_mode_active = false

function _G.toggle_reading_mode()
    if vim.g.reading_mode_active then
        -- Deaktiviere den Lesemodus
        vim.keymap.del('n', 'N', { silent = true })
        vim.keymap.del('n', 'n', { silent = true })
        vim.keymap.del('n', 'H', { silent = true })
        vim.keymap.del('n', 'L', { silent = true })
        vim.keymap.del('n', '<up>', { silent = true })
        vim.keymap.del('n', '<down>', { silent = true })
        vim.g.reading_mode_active = false
        _G.ReadingModeStatus()
    else
        -- Aktiviere den Lesemodus
        vim.keymap.set('n', 'N', '<C-u>', { silent = true, desc = "Scroll up half a page" })
        -- d is not suited because it is laggy
        vim.keymap.set('n', 'n', '<C-d>', { silent = true, desc = "Scroll down half a page" })
        vim.keymap.set('n', 'H', '<C-o>', { silent = true, desc = "Go to last location" })
        vim.keymap.set('n', 'L', '<C-i>', { silent = true, desc = "Go to next location" })
        vim.keymap.set('n', '<up>', '<C-y>', { silent = true, desc = "Move screen one line up" })
        vim.keymap.set('n', '<down>', '<C-e>', { silent = true, desc = "Move screen one line down" })
        vim.g.reading_mode_active = true
        _G.ReadingModeStatus()
    end
end

-- Toggle reading mode
vim.api.nvim_set_keymap('n', '<leader>r', ":lua toggle_reading_mode()<CR>", {noremap=false})

function _G.ReadingModeStatus()
  if vim.g.reading_mode_active then
    vim.cmd('echo ""')
    return ' -- LESEN --'
  else
    vim.cmd('echo ""')
    return ''
  end
end
