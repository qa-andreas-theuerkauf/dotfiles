require("flash").setup({
 modes = {
    char = {
      enabled = true,
      keys = {
        -- Entferne 'S' aus visual mode, um Konflikt mit nvim-surround zu vermeiden
        ["S"] = false,
      },
    },
  },
})
