-- buffers
vim.api.nvim_set_keymap("n", "tn", ":enew<enter>", {noremap=false})
vim.api.nvim_set_keymap("n", "tj", ":bprev<enter>", {noremap=false})
vim.api.nvim_set_keymap("n", "tk", ":bnext<enter>", {noremap=false})
vim.api.nvim_set_keymap("n", "td", ":bdelete<enter>", {noremap=false})

-- navigation
vim.api.nvim_set_keymap('n', '<C-n>', '<C-d>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-p>', '<C-u>', {noremap = true, silent = true})
-- vim.api.nvim_set_keymap('n', '<Up>', '5k', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<Down>', '5j', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<leader><Up>', 'H', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<leader><Down>', 'L', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>k', '50k', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>j', '50j', { noremap = true, silent = true })

-- hyperlinks
-- insert hyperlink with custom title
-- bad performence, why?
vim.api.nvim_set_keymap('n', '<leader>hl', "diWa[](<ESC>pa)<ESC>F[a", {noremap=false})

-- highlighting off toggle
vim.api.nvim_set_keymap('n', '<leader>nh', ":nohlsearch<enter>", {noremap=false})

-- toggle relative line numbers
-- vim.api.nvim_set_keymap('n', '<leader>ln', ":set relativenumber!<enter>", {noremap=false})

function _G.insert_shortened_url()
    local url = vim.fn.getreg('+')
    if not url or url == '' then
        print("Clipboard is empty or contains invalid data.")
        return
    end
    print("Clipboard content:", url)
    
    local hyperlink_text_regex = "https?://([%w%.%-]+)"
    local domain = url:match(hyperlink_text_regex)
    print("Domain:", domain)
    local reversed_domain = _G.reverse_domain(domain)

    local markdown_link = string.format("[%s: ](%s)", reversed_domain, url)
    vim.api.nvim_put({markdown_link}, 'c', true, true)
end

-- Function to reverse the domain
function _G.reverse_domain(domain)
    -- Split the domain into parts by "."
    local parts = {}
    for part in domain:gmatch("[^%.]+") do
        table.insert(parts, 1, part)  -- Insert at the beginning to reverse the order
    end

    -- Join the parts back together in reverse order
    return table.concat(parts, '.')
end

-- insert hyperlink with custom title
-- works also with multiple urls in clipboard, separated by '\n'
vim.api.nvim_set_keymap('n', '<leader>hlt', "diWa[](<ESC>pa)<ESC>F[a", {noremap=false})

function _G.insert_shortened_url()
    local url = vim.fn.getreg('+')
    if not url or url == '' then
        print("Clipboard is empty or contains invalid data.")
        return
    end
    print("Clipboard content:", url)
    
    local hyperlink_text_regex = "https?://([%w%.%-]+)"
    local domain = url:match(hyperlink_text_regex)
    print("Domain:", domain)
    local reversed_domain = _G.reverse_domain(domain)

    local markdown_link = string.format("[%s: ](%s)", reversed_domain, url)
    vim.api.nvim_put({markdown_link}, 'c', true, true)
end

-- Function to reverse the domain
function _G.reverse_domain(domain)
    -- Split the domain into parts by "."
    local parts = {}
    for part in domain:gmatch("[^%.]+") do
        table.insert(parts, 1, part)  -- Insert at the beginning to reverse the order
    end

    -- Join the parts back together in reverse order
    return table.concat(parts, '.')
end

function _G.insert_shortened_url()
    local url = vim.fn.getreg('+')
    if not url or url == '' then
        print("Clipboard is empty or contains invalid data.")
        return
    end
    print("Clipboard content:", url)
    
    local hyperlink_text_regex = "https?://([%w%.%-]+)"
    local domain = url:match(hyperlink_text_regex)
    print("Domain:", domain)
    local reversed_domain = _G.reverse_domain(domain)

    local markdown_link = string.format("[%s: ](%s)", reversed_domain, url)
    vim.api.nvim_put({markdown_link}, 'c', true, true)
end

-- Function to reverse the domain
function _G.reverse_domain(domain)
    -- Split the domain into parts by "."
    local parts = {}
    for part in domain:gmatch("[^%.]+") do
        table.insert(parts, 1, part)  -- Insert at the beginning to reverse the order
    end

    -- Join the parts back together in reverse order
    return table.concat(parts, '.')
end

-- insert hyperlink with custom title and reversed domain
-- works also with multiple urls in clipboard, separated by '\n'
vim.api.nvim_set_keymap('n', '<leader>hldt', ":lua _G.insert_shortened_url()<CR><ESC>F]i", {noremap=false})

function _G.insert_shortened_url_with_last_part()
    local urls = vim.fn.getreg('+')
    if not urls or urls == '' then
        print("Clipboard is empty or contains invalid data.")
        return
    end
    print("Clipboard content:", urls)

    _G.vim_insert_shortened_urls_with_last_part(urls)
end

function _G.vim_insert_shortened_urls_with_last_part(urls)
    local formatted_urls = {}
    for url in urls:gmatch("[^\n]+") do
        table.insert(formatted_urls, _G.get_shortened_urls_with_last_part(url))
    end
    vim.api.nvim_put(formatted_urls, 'c', true, true)
end

function _G.get_shortened_urls_with_last_part(url)
    local domain_regex = "https?://([%w%.%-]+)"
    local last_part_regex = ".*/([^/]+)$"
        
    local domain = url:match(domain_regex)
    local last_part = url:match(last_part_regex)
    print("Domain:", domain)
    print("Last part:", last_part_regex)
    local reversed_domain = _G.reverse_domain(domain)
        
    return string.format("[%s: %s](%s)", reversed_domain, last_part, url)
end

-- insert hyperlink with reversed domain and last part as title
-- works also with multiple urls in clipboard, separated by '\n'
vim.api.nvim_set_keymap('n', '<leader>hld', ":lua _G.insert_shortened_url_with_last_part()<CR><ESC>o<ESC>", {noremap=false})

function _G.insert_hyperlink_last_part()
    local url = vim.fn.getreg('+')
    if not url or url == '' then
        print("Clipboard is empty or contains invalid data.")
        return
    end
    print("Clipboard content:", url)
    
    local last_part_regex = ".*/([^/]+)$"

    local last_part = url:match(last_part_regex)
    print("Last part:", last_part_regex)

    local markdown_link = string.format("[%s](%s)", last_part, url)
    vim.api.nvim_put({markdown_link}, 'c', true, true)
end

-- insert hyperlink with last part as title
vim.api.nvim_set_keymap('n', '<leader>hlp', ":lua _G.insert_hyperlink_last_part()<CR><ESC>o<ESC>", {noremap=false})

-- yank URL-part from markdown-link. Needed for opening in non-default-browser

-- Reading Mode
_G.reading_mode = false

function _G.toggle_reading_mode()
    if reading_mode then
        -- Deaktiviere den Lesemodus
        vim.keymap.del('n', 'n', { silent = true })
        vim.keymap.del('n', 'N', { silent = true })
        print("Reading Mode: OFF")
    else
        -- Aktiviere den Lesemodus
        vim.keymap.set('n', 'n', '<C-u>', { silent = true, desc = "Scroll up half a page" })
        -- d is not suited because it is laggy
        vim.keymap.set('n', 'N', '<C-d>', { silent = true, desc = "Scroll down half a page" })
        print("Reading Mode: ON")
    end
    reading_mode = not reading_mode
end

-- Toggle reading mode
vim.api.nvim_set_keymap('n', '<leader>r', ":lua toggle_reading_mode()<CR>", {noremap=false})
