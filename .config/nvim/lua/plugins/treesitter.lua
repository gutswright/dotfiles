return {
  {
    "nvim-treesitter/nvim-treesitter", build = ":TSUpdate", 
    config = function()
      require("nvim-treesitter.configs").setup({
        -- These are just a list of parsers:
        ensure_installed = { "lua", "vim", "javascript", "html", "css", "python", "dockerfile", "fish", "json", "kotlin", "hcl", "markdown", "markdown_inline", "powershell", "rust", "sql", "ssh_config", "svelte", "swift", "terraform", "typescript", "typst", "zig"},
        highlight = { enable = true},
        indent = { enable = true },
      })
  end,
  }
}
