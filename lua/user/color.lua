-- Define a function to toggle between light and dark mode
function ToggleBackground()
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

-- Define a function to set the colorscheme and save it
function SetColorscheme(scheme)
  local prebg = vim.o.background
  vim.cmd('colorscheme ' .. scheme)
  -- Save the current colorscheme
  vim.g.colorscheme = scheme
  vim.o.background = prebg
  vim.g.background_mode = prebg
  -- Write the colorscheme to a configuration file
  local config_dir = vim.fn.expand('~/.config/nvim')
  if not vim.fn.isdirectory(config_dir) then
    vim.fn.mkdir(config_dir, 'p')
  end
  local config_file = config_dir .. '/colorscheme'
  local f = io.open(config_file, 'w')
  f:write(vim.g.colorscheme)
  f:close()
end


-- Read the colorscheme from a configuration file, if it exists
local config_file_colorscheme = vim.fn.expand('~/.config/nvim/colorscheme')
if vim.fn.filereadable(config_file_colorscheme) == 1 then
  local f = io.open(config_file_colorscheme, 'r')
  local colorscheme = f:read('*all')
  f:close()
  vim.g.colorscheme = colorscheme:gsub('%s+', '') -- remove any whitespace
  vim.cmd('colorscheme ' .. vim.g.colorscheme)
end

-- Read the background mode from a configuration file, if it exists
local config_file_background_mode = vim.fn.expand('~/.config/nvim/background_mode')
if vim.fn.filereadable(config_file_background_mode) == 1 then
  local f = io.open(config_file_background_mode, 'r')
  local background_mode = f:read('*all')
  f:close()
  vim.g.background_mode = background_mode:gsub('%s+', '') -- remove any whitespace
  vim.o.background = vim.g.background_mode
end
