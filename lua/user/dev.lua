local Terminal = require("toggleterm.terminal").Terminal

local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
  return
end

-- Create a new terminal and run a command in it
function OpenTermAndRun(command)
  local term = Terminal:new({
    direction = "vertical",
    auto_scroll = false,
    start_in_insert = true,
    on_open = function(term)
      vim.schedule(function()
        vim.fn.chansend(term.job_id, command .. "\n")
      end)
    end,
  })
  term:toggle()
end

function Dev()
  OpenTermAndRun("npm run dev")
  vim.cmd("wincmd p")
  vim.cmd("NvimTreeOpen")
  vim.cmd("wincmd p")
  vim.cmd("stopinsert")
end
