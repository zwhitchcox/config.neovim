-- Define a function to toggle between light and dark mode
function ToggleBackground()
  vim.cmd('colorscheme gruvbox')
  -- Save the current background mode
  if vim.o.background == 'light' then
    vim.o.background = 'dark'
    vim.g.background_mode = 'dark'
  else
    vim.o.background = 'light'
    vim.g.background_mode = 'light'
  end
  -- Write the background mode to a configuration file
  local config_dir = vim.fn.expand('~/.config/nvim')
  if not vim.fn.isdirectory(config_dir) then
    vim.fn.mkdir(config_dir, 'p')
  end
  local config_file = config_dir .. '/background_mode'
  local f = io.open(config_file, 'w')
  f:write(vim.g.background_mode)
  f:close()
end

-- Read the background mode from a configuration file, if it exists
local config_file = vim.fn.expand('~/.config/nvim/background_mode')
if vim.fn.filereadable(config_file) == 1 then
  local f = io.open(config_file, 'r')
  local background_mode = f:read('*all')
  f:close()
  vim.g.background_mode = background_mode:gsub('%s+', '') -- remove any whitespace
  vim.o.background = vim.g.background_mode
end
