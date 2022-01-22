local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
  return
end

toggleterm.setup({
  size = 20,
  open_mapping = [[<c-\>]],
  hide_numbers = true,
  shade_filetypes = {},
  shade_terminals = true,
  shading_factor = 2,
  start_in_insert = true,
  insert_mappings = true,
  persist_size = true,
  direction = "float",
  close_on_exit = true,
  shell = vim.o.shell,
  float_opts = {
    border = "curved",
    winblend = 0,
    highlights = {
      border = "Normal",
      background = "Normal",
    },
  },
})

function _G.set_terminal_keymaps()
  local opts = {noremap = true}
  vim.api.nvim_buf_set_keymap(0, 't', 'jk', [[<C-\><C-n>]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
end

vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

local Terminal = require("toggleterm.terminal").Terminal

local function create_terminal(options)
  local default_opts = { hidden = true }
  local opts = vim.tbl_extend('force', default_opts, options);
  return Terminal:new(vim.tbl_extend('force', opts, {
    on_open = function(term)
      -- Make Ctrl-z minimize/close the terminal
      vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<C-z>", "<cmd>close<CR>", {noremap = true, silent = true})
      -- Map "q" in normal mode to close terminal
      vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", [[<cmd>close<CR>]], {noremap = true, silent = true})
      if (opts.on_open) then
        opts.on_open(term)
      end
    end,
  }))
end

local lazygit = create_terminal({ cmd = "lazygit", dir = "git_dir" })

function _LAZYGIT_TOGGLE()
  lazygit:toggle()
end

local node = create_terminal({ cmd = "node" })

function _NODE_TOGGLE()
  node:toggle()
end
