-- t : Auto-wrap text
-- c : Auto-wrap comments
-- a : Automatic formatting
-- r : Automatically insert comment leader in insertion mode with `Enter`
-- o : Automatic insertion of comment leader via `o` and `O`
-- q : Format comments via `gq`
-- n : Continuation of enumerated list text wrapping
-- M : Do not insert black character after joining two lines
-- see: `:help fo-table`
vim.api.nvim_create_autocmd("FileType", { 
	pattern = "*",
    command = "set formatoptions=tcoq",
})

-- Set highlight on search
vim.o.hlsearch = false

-- For my sanity
vim.opt.errorbells = false

-- Indenting
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
-- vim.opt.smartindent = true -- orientiert sich an `{`, `}`
vim.opt.autoindent = true

-- number bar sizing
-- vim.opt.number = true
-- vim.opt.numberwidth = 5
-- sign column trick for spacing at the right of the line number
-- I can't believe I have to do this... and then it does not work!
-- vim.opt.signcolumn = "yes:2"
-- instead use relative number to make space on the right of the line number (at least in the current line)
-- vim.opt.relativenumber = true

-- highlighting of current cursor line
vim.opt.cursorline = false

-- status line
-- vim.opt.statusline = "%f %l/%L"

vim.g.mapleader = " "

vim.o.clipboard = 'unnamedplus'

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menu,menuone,noselect'

vim.o.ignorecase = true
vim.o.smartcase = true

-- Do not show complete hyperlinks for better readability
vim.o.conceallevel = 2
-- Conceal text only in normal and command line mode
vim.opt.concealcursor = 'nc'

-- Set colorscheme
--vim.cmd.colorscheme "catppuccin-latte"
--vim.cmd.colorscheme "tokyonight-moon"
--vim.cmd.colorscheme "tokyonight"
--vim.cmd.colorscheme "tokyonight"
vim.o.background = "light"

--require('tokyonight').setup({
--    style = 'day',
--    -- I find the normal background highlighting for code blocks too hard to read
--    on_colors = function(colors)
--        colors.terminal_black = "#000000"
--    end
--})

-- make the dark mode macOS-mode-dependent
local function get_system_theme()
  local dark_theme = os.execute([[defaults read -g AppleInterfaceStyle 2>/dev/null]]) == 0
  return dark_theme and "dark" or "light"
end

function set_colorscheme()
  local theme = get_system_theme()
  if theme == "dark" then
    vim.cmd[[colorscheme tokyonight-moon]]
  else
    vim.cmd[[colorscheme edelweiss]]
 end
    print("Colorscheme changed")
end

set_colorscheme()

--vim.cmd([[
--  autocmd FocusGained * lua set_colorscheme()
--]])


