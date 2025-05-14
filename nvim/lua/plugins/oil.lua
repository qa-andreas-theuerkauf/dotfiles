require("oil").setup({
    -- For using netrw alongside with oil (did not work...)
    default_file_explorer = false,
    --Send deleted files to the trash instead of permanently deleting them (:help oil-trash)
    delete_to_trash = true,
    show_hidden = true,
    keymaps = {
        ["<leader>."] = "actions.toggle_hidden"
    }
})

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
