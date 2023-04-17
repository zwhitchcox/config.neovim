-- lsp_lines.nvim
-- https://git.sr.ht/~whynothugo/lsp_lines.nvim
vim.cmd 'packadd lsp_lines.nvim'

require'lsp_lines'.setup()

vim.diagnostic.config({ virtual_lines = { only_current_line = true } })

function _G.copy_diagnostics_to_clipboard_all()
  local diagnostics = vim.diagnostic.get(0)
  local diagnostic_lines = {}

  for _, diagnostic in ipairs(diagnostics) do
    local line = diagnostic.lnum + 1
    local col = diagnostic.col + 1
    local message = diagnostic.message
    local severity = vim.diagnostic.severity[diagnostic.severity]:lower()
    table.insert(diagnostic_lines, string.format("%s:%d:%d: %s: %s", vim.fn.expand("%"), line, col, severity, message))
  end

  local diagnostics_text = table.concat(diagnostic_lines, "\n")
  vim.fn.setreg("+", diagnostics_text)
  print("Diagnostics copied to clipboard")
end


function _G.copy_diagnostics_to_clipboard_current_line()
  local current_line = vim.api.nvim_win_get_cursor(0)[1]
  local diagnostics = vim.diagnostic.get(0)
  local diagnostic_lines = {}

  for _, diagnostic in ipairs(diagnostics) do
    local line = diagnostic.lnum + 1
    if line == current_line then
      local col = diagnostic.col + 1
      local message = diagnostic.message
      local severity = vim.diagnostic.severity[diagnostic.severity]:lower()
      table.insert(diagnostic_lines, string.format("%s:%d:%d: %s: %s", vim.fn.expand("%"), line, col, severity, message))
    end
  end

  local diagnostics_text = table.concat(diagnostic_lines, "\n")
  if #diagnostic_lines > 0 then
    vim.fn.setreg("+", diagnostics_text)
    print("Diagnostics for the current line copied to clipboard")
  else
    print("No diagnostics found on the current line")
  end
end


local function get_visual_selection()
    local _, start_line, start_col, _ = unpack(vim.fn.getpos("'<"))
    local _, end_line, end_col, _ = unpack(vim.fn.getpos("'>"))
    start_line, start_col, end_line, end_col = start_line - 1, start_col - 1, end_line - 1, end_col - 1
    local lines = vim.api.nvim_buf_get_lines(0, start_line, end_line + 1, false)
    if #lines == 0 then
        return ""
    end
    lines[1] = string.sub(lines[1], start_col + 1)
    local n = #lines
    lines[n] = string.sub(lines[n], 1, end_col)
    return table.concat(lines, "\n")
end

function _G.copy_selected_code_and_diagnostics_to_clipboard()
  -- Get the selected code
  local selected_code = get_visual_selection()

  -- Get the start and end lines of the selected code
  local start_line, end_line = vim.fn.getpos("'<")[2], vim.fn.getpos("'>")[2]

  -- Get the diagnostics and filter them by the selected lines
  local diagnostics = vim.diagnostic.get(0)
  local selected_diagnostics = {}

  for _, diagnostic in ipairs(diagnostics) do
    local line = diagnostic.lnum + 1
    if line >= start_line and line <= end_line then
      local col = diagnostic.col + 1
      local message = diagnostic.message
      local severity = vim.diagnostic.severity[diagnostic.severity]:lower()
      table.insert(selected_diagnostics, string.format("%s:%d:%d: %s: %s", vim.fn.expand("%"), line, col, severity, message))
    end
  end

  local diagnostics_text = table.concat(selected_diagnostics, "\n")

  -- Combine the selected code and the diagnostics
  local clipboard_text = selected_code .. "\n\n" .. diagnostics_text

  if #selected_diagnostics > 0 then
    vim.fn.setreg("+", clipboard_text)
    print("Selected code and diagnostics copied to clipboard")
  else
    print("No diagnostics found within the selected lines")
  end
end
