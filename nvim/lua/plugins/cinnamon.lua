require("cinnamon").setup {
    -- Enable all provided keymaps
    keymaps = {
        basic = true,
        extra = true,
    },
    -- Only scroll the window
    options = { 
        mode = "window",
        always_scroll = true,
        delay = 2
    },
}
