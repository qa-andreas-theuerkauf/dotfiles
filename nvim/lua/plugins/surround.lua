require("nvim-surround").setup({
  surrounds = {
    -- Custom surround for `x` to produce `**<content>**`
    ["x"] = {
      add = { "**", "**" },
      find = "%*%*.-%*%*", -- optional: um bestehende Umgebungen zu finden
      delete = "^(%*%*)(.-)(%*%*)$",
    },
  },
})
