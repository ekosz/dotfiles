-- Helper function to shorten rest of file
local function map (mode, input, output, options)
  options = options or {}
  local default_opts = { noremap = true, silent = true }
  local opts = vim.tbl_extend('force', default_opts, options)

  vim.api.nvim_set_keymap(mode, input, output, opts)
end

-- Set leader key to ","
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- Closes the current buffer, or if there are no bufers, quits instead
function _G.close_or_quit(force)
  if (force) then
    -- If we're asked to force quit, do just that
    vim.cmd "q!"
    return
  end

  local win_count = vim.fn.winnr('$')

  -- If there is more than one window/pane open, then just do normal q to close the window
  if win_count > 1 then
    vim.cmd "q"
    return
  end

  local ok, _ = pcall(vim.cmd, "Bdelete!")
  if not ok then
    -- vim-bbye not loaded, fallback to normal quit
    vim.cmd "q"
  end

  local buf_count = 0
  for buffer = 1, vim.fn.bufnr('$') do
    if vim.fn.buflisted(buffer) == 1 then
      buf_count = buf_count + 1
    end
  end

  if buf_count == 0 then
    -- No more buffers, time to quit
    vim.cmd "q"
  end
end

vim.cmd [[command -bang -nargs=0 CloseOrQuit lua close_or_quit("<bang>" == "!")]]

-- Mapping cannot(?) be done in lua
vim.cmd [[
  " Remap :E to :e
  cnoreabbrev <expr> E getcmdtype() == ":" && getcmdline() == "E" ? "e" : "E"
  " Remap :W to :w
  cnoreabbrev <expr> W getcmdtype() == ":" && getcmdline() == "W" ? "w" : "W"
  " Remap :q to :CloseOrQuit
  cnoreabbrev <expr> q getcmdtype() == ":" && getcmdline() == "q" ? "CloseOrQuit" : "q"
]]

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- NORMAL --
-- Disable annoying key
map("n", "Q", "<Nop>")
-- Make Y work as expected
map("n", "Y", "y$")
-- Always use very magic regex mode when searching
map("n", "/", "/\\v")
map("n", "?", "?\\v")
-- Resize windows with the arrow keys
map("n", "<up>", ":resize +2<CR>")
map("n", "<down>", ":resize -2<CR>")
map("n", "<left>", ":vertical resize -2<CR>")
map("n", "<right>", ":vertical resize +2<CR>")
-- Don't need help
map("n", "<F1>", "<ESC>")

-- INSERT --
-- Don't need help
map("i", "<F1>", "<ESC>")
-- Don't use those stupid arrow keys!
map("i", "<up>", "<nop>")
map("i", "<down>", "<nop>")
map("i", "<left>", "<nop>")
map("i", "<right>", "<nop>")
-- Fast escapes
map("i", "jj", "<ESC>")
map("i", "jk", "<ESC>")
map("i", "kj", "<ESC>")
-- Better window navigation
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- Visual --
-- Always use very magic regex mode when searching
map("v", "/", "/\\v")
-- Don't need help
map("v", "<F1>", "<ESC>")
-- Stay in indent mode
map("v", "<", "<gv")
map("v", ">", ">gv")
-- Don't lose current copy register when pasting in visual mode
map("v", "p", '"_dP')
