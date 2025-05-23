-- vim.opt.statusline = "%30(%=%#LineNr#%.50F [%{strlen(&ft) > 0 ? &ft : 'none'}] %l:%c %p%%%)"
-- vim.opt.statusline = "%f %y %l:%c %P"
-- vim.opt.winbar = "%= %t %="
-- vim.opt.winbar = "%= %P | %l:%c | %{line('$')}"
--vim.opt.winbar = "%= %P | %{line('$')}"
vim.opt.winbar = "%= %P"
-- vim.opt.statusline = "%= %t %= %P | %l:%c | %{line('$')}"

vim.opt.statusline = "%= %t %= [%{line('w0')},%{line('w$')}] / %{line('$')}" 
--vim.opt.statusline = "%{v:lua.ReadingModeStatus()} %= %t %= [%{line('w0')},%{line('w$')}] / %{line('$')}" 
--vim.opt.statusline = "%= %t %= [%{line('w0')},%{line('w$')}] / %{line('$')}" 


