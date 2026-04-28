return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    build = ':TSUpdate',
    config = function()
      -- require('nvim-treesitter.configs').setup({
      require('nvim-treesitter.config').setup({
        ensure_installed = {
          'lua',
          'vim',
          'javascript',
          'html',
          'css',
          'python',
          'dockerfile',
          'fish',
          'json',
          'kotlin',
          'hcl',
          'markdown',
          'markdown_inline',
          'powershell',
          'rust',
          'sql',
          'ssh_config',
          'svelte',
          'terraform',
          'typescript',
          'typst',
          'zig',
          'cpp',
        },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },
}
