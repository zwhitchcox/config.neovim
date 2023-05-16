local function PersistBackground()
  local config_dir = vim.fn.expand('~/.config/nvim')
  if not vim.fn.isdirectory(config_dir) then
    vim.fn.mkdir(config_dir, 'p')
  end
  local config_file = config_dir .. '/background_mode'
  local f = io.open(config_file, 'w')
  if f == nil then
    return
  end
  f:write(vim.g.background_mode)
  f:close()
  config_file = config_dir .. '/colorscheme'
  local f = io.open(config_file, 'w')
  if f == nil then
    return
  end
  f:write(vim.g.colorscheme)
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
end

local function Init()
  -- Read the colorscheme from a configuration file, if it exists
  local config_file_colorscheme = vim.fn.expand('~/.config/nvim/colorscheme')
  if vim.fn.filereadable(config_file_colorscheme) == 1 then
    local f = io.open(config_file_colorscheme, 'r')
    local colorscheme = f:read('*all')
    f:close()
    if f == nil then
      return
    end
    vim.g.colorscheme = colorscheme:gsub('%s+', '') -- remove any whitespace
    vim.cmd('colorscheme ' .. vim.g.colorscheme)
  end

  -- Read the background mode from a configuration file, if it exists
  local config_file_background_mode = vim.fn.expand('~/.config/nvim/background_mode')
  if vim.fn.filereadable(config_file_background_mode) == 1 then
    local f = io.open(config_file_background_mode, 'r')
    local background_mode = f:read('*all')
    if f == nil then
      return
    end
    f:close()
    vim.g.background_mode = background_mode:gsub('%s+', '') -- remove any whitespace
    vim.o.background = vim.g.background_mode
  end
end

function SetLight()
  vim.cmd('colorscheme gruvbox')
  vim.cmd('set background=light')
  vim.g.background_mode = 'light'
  vim.g.colorscheme = 'gruvbox'
end

function SetDark()
  vim.cmd('colorscheme tokyonight')
  vim.cmd('set background=dark')
  vim.g.background_mode = 'dark'
  vim.g.colorscheme = 'gruvbox'
end

function CheckColorScheme()
  local handle = io.popen("dbus-send --session --print-reply=literal --reply-timeout=1000 --dest=org.freedesktop.portal.Desktop /org/freedesktop/portal/desktop org.freedesktop.portal.Settings.Read string:'org.freedesktop.appearance' string:'color-scheme'")
  local result = handle:read("*a")
  handle:close()

  if string.match(result, 'uint32 1') then
    SetDark()
  elseif string.match(result, 'uint32 0') then
    SetLight()
  end
end

vim.cmd([[
  function! CheckColorSchemeWrapper(timer_id)
    lua CheckColorScheme()
  endfunction

  call timer_start(1000, 'CheckColorSchemeWrapper', {'repeat': -1})
]])
function ToggleBackground()
  if vim.g.background_mode == 'light' then
    SetDark()
  else
    SetLight()
  end
  PersistBackground()
end

Init()
