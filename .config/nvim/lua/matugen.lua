 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#121319',
    base01 = '#1e1f25',
    base02 = '#282a30',
    base03 = '#8d909d',
    base04 = '#c4c6d4',
    base05 = '#e2e2ea',
    base06 = '#e2e2ea',
    base07 = '#e2e2ea',
    base08 = '#ffb4ab',
    base09 = '#fcaaff',
    base0A = '#b9c6ee',
    base0B = '#b2c5ff',
    base0C = '#fcaaff',
    base0D = '#b2c5ff',
    base0E = '#b9c6ee',
    base0F = '#93000a',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  hi('TelescopeNormal',         { fg = '#e2e2ea',          bg = '#121319' })
  hi('TelescopeBorder',         { fg = '#8d909d',             bg = '#121319' })
  hi('TelescopePromptNormal',   { fg = '#e2e2ea',          bg = '#121319' })
  hi('TelescopePromptBorder',   { fg = '#8d909d',             bg = '#121319' })
  hi('TelescopePromptPrefix',   { fg = '#b2c5ff',             bg = '#121319' })
  hi('TelescopePromptCounter',  { fg = '#c4c6d4',  bg = '#121319' })
  hi('TelescopePromptTitle',    { fg = '#121319',             bg = '#b2c5ff' })
  hi('TelescopePreviewTitle',   { fg = '#121319',             bg = '#b9c6ee' })
  hi('TelescopeResultsTitle',   { fg = '#121319',             bg = '#fcaaff' })
  hi('TelescopeSelection',      { fg = '#e2e2ea',          bg = '#282a30' })
  hi('TelescopeSelectionCaret', { fg = '#b2c5ff',             bg = '#282a30' })
  hi('TelescopeMatching',       { fg = '#b2c5ff',             bold = true })
end

 -- Register a signal handler for SIGUSR1 (matugen updates)
 local signal = vim.uv.new_signal()
 signal:start(
   'sigusr1',
   vim.schedule_wrap(function()
     package.loaded['matugen'] = nil
     require('matugen').setup()
   end)
 )

 return M
