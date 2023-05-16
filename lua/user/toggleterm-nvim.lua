local utils = require 'user.utils'

-- toggleterm.nvim
-- https://github.com/akinsho/toggleterm.nvim
vim.cmd 'packadd toggleterm.nvim'
require 'toggleterm'.setup {
  size = function(term)
    if term.direction == "horizontal" then
      return 20
    elseif term.direction == "vertical" then
      return vim.o.columns * 0.35
    end
  end,
  open_mapping = [[<c-\>]],
  hide_numbers = true,
  shade_filetypes = {},
  shade_terminals = true,
  shading_factor = 2,
  start_in_insert = true,
  insert_mappings = true,
  persist_size = false,
  direction = "vertical",
  close_on_exit = true,
  shell = vim.o.shell,
  on_open = function()
    vim.cmd("startinsert!")
  end,
  float_opts = {
    border = "curved",
    winblend = 0,
    highlights = {
      border = "Normal",
      background = "Normal",
    },
  },
}




local function get_current_toggleterm_bufnr()
  local bufnr = vim.api.nvim_get_current_buf()
  local filetype = vim.api.nvim_buf_get_option(bufnr, 'filetype')
  if filetype == 'toggleterm' then
    return bufnr
  else
    return nil
  end
end

local function get_current_toggleterm()
  local bufnr = get_current_toggleterm_bufnr()
  local terms = require("toggleterm.terminal").get_all()

  for _, term in ipairs(terms) do
    if term.bufnr == bufnr then
      return term
    end
  end
end

-- Load the required library for creating new toggle terms
local Terminal = require("toggleterm.terminal").Terminal

-- Define a function to toggle to the next terminal
function SwitchToggleTerm(direction)
  -- If no direction is specified, default to 1
  if direction == nil then
    direction = 1
  end

  -- Get the buffer number of the current toggle term
  local cur_toggleterm_bufnr = get_current_toggleterm_bufnr()

  -- Get all open toggle terms
  local terms = require("toggleterm.terminal").get_all()

  -- Loop through all the terms to find the current one
  for _, term in ipairs(terms) do
    if term.bufnr == cur_toggleterm_bufnr then
      -- Calculate the ID of the next term
      local new_id = term.id + direction

      -- If the new ID is less than 1, wrap around to the end
      if new_id < 1 then
        new_id = #terms
      end
      if new_id == term.id then
        return
      end
      -- Get the next term based on the new ID
      --
      local next_term = require("toggleterm.terminal").get(new_id)
      -- If there is no next term, create a new one
      --
      if next_term == nil then
        Terminal:new({
          direction = term.direction,
          auto_scroll = false,
          start_in_insert = true,
          on_open = function()
            -- Schedule the startinsert command to be executed after 0 seconds
            vim.schedule(function()
              vim.api.nvim_command([[startinsert]])
            end, 0)
          end,
        }):toggle()
      else
        -- If there is a next term, toggle to it and start in insert mode
        next_term:toggle()
        vim.schedule(function()
          vim.api.nvim_command([[startinsert]])
        end, 0)
      end

      -- Close the current term
      term:close()
    end
  end
end

function ToggleDirectionAll()
  local cur_term = get_current_toggleterm()
  local terms = require("toggleterm.terminal").get_all()
  for _, term in ipairs(terms) do
    local direction = term.direction
    if direction == "horizontal" then
      term.direction = "vertical"
    elseif direction == "vertical" then
      term.direction = "float"
    else
      term.direction = "horizontal"
    end
    term:toggle()
  end
  if cur_term ~= nil then
    cur_term:toggle()
    vim.schedule(function()
      vim.api.nvim_command([[startinsert]])
    end, 0)
  end
end

utils.augroup { name = 'UserToggleTermKeymaps', cmds = {
  { 'FileType', {
    pattern = 'toggleterm',
    desc = 'Load floating terminal keymaps.',
    callback = function()
      utils.keymaps { modes = '', opts = { buffer = true, silent = true }, maps = {
        { '<ESC>', '<Cmd>ToggleTerm<CR>' },
      } }
      local opts = { noremap = true }
      -- vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
      vim.api.nvim_buf_set_keymap(0, 't', 'kj', [[<C-\><C-n>]], opts)
      vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
      vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
      vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
      vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
      -- keyboard mappings
      -- vim.api.nvim_buf_set_keymap(0, 't', '<C-a>', [[<cmd>lua ToggleTerm()<CR>]], { noremap = true, silent = true })
      vim.api.nvim_buf_set_keymap(0, 't', '<C-a-h>', [[<cmd>lua SwitchToggleTerm(-1)<CR>]],
        { noremap = true, silent = true })
      vim.api.nvim_buf_set_keymap(0, 't', '<C-a-l>', [[<cmd>lua SwitchToggleTerm(1)<CR>]],
        { noremap = true, silent = true })
      vim.api.nvim_buf_set_keymap(0, 't', '<C-a-t>', [[<cmd>lua ToggleDirectionAll()<CR>]],
        { noremap = true, silent = true })
    end
  } },
  { 'BufEnter', {
    pattern = '*',
    desc = 'Enter insert mode when entering a terminal buffer.',
    callback = function()
      if vim.bo.filetype == 'toggleterm' then
        vim.api.nvim_command([[startinsert]])
      end
    end
  } },
} }
