-- Get more info for each option using `:help options`
-- Pretty sure a lot of these options are outtaded or no longer needed
-- but these are the options I've collected over the past 10+ years

local options = {
  autoindent = true, -- Auto indent new lines
  background = "dark", -- I use a dark background
  backspace = { "indent", "eol", "start" }, -- Backspace over everything in insert mode
  backup = false, -- Don't make backups
  cmdheight = 2, -- Give more space for displaying messages.
  colorcolumn = "100", -- Color the 100th column
  completeopt = { "menuone", "noselect" }, -- mostly just for cmp
  conceallevel = 0, -- so that `` is visible in markdown files
  cursorline = true, -- Show line where cursor is
  expandtab = true,
  fileencoding = "utf-8", -- Always use UTF8 encodding
  formatoptions = "qrn1", -- Misc formating options
  gdefault = true, -- Globally replace be default
  hidden = true, -- Don't unload buffers when leaving them
  hlsearch = true, -- Highlight found search results
  ignorecase = true, -- Ignore case when searching
  incsearch = true, -- Start searching after first letter
  laststatus = 2, -- Always show the status line
  linebreak = true, -- Don't break lines in the middle of words
  list = true, -- Show unprintable characters
  listchars = (
    "tab:▸ ," .. -- Char representing a tab
    "extends:❯," .. -- Char representing an extending line
    "nbsp:␣," .. -- Non breaking space
    "precedes:❮," .. -- Char representing an extending line in the other direction
    "trail:·" -- Show trailing spaces as dots
  ),
  number = true, -- Show current line number
  numberwidth = 2, -- Two columns for the number
  pastetoggle = "<F3>", -- Go into paste mode with F3
  pumheight = 10, -- pop up menu height
  relativenumber = true, -- Use relative line numbers
  ruler = true, -- Show current cursor position
  scrolloff = 8, -- Min. lines to keep above or below the cursor when scrolling
  shiftwidth = 2, -- Number of spaces for auto indent
  showbreak = "↪" , -- Show wraped lines with this char
  showmatch = true, -- Show the matching paren when hovering over one
  showmode = false, -- Don't show current mode, let airline handle that
  -- Always show the signcolumn, otherwise it would shift the text each time
  -- diagnostics appear/become resolved.
  sidescrolloff = 8, -- Same as scolloff
  signcolumn = "yes",
  smartcase = true, -- Be case sensitive when there are capital letters
  softtabstop = 2, -- ...
  splitbelow = true, -- Split below be default
  splitright = true, -- Split to the right by default
  swapfile = false, -- Don't make swap files
  synmaxcol = 300, -- do not highlith very long lines
  tabstop = 2, -- 2 space indents by default
  termguicolors = true,
  textwidth = 79, -- Wrap text around the 79 column
  timeoutlen = 100, -- time to wait for a mapped sequence to complete (in milliseconds)
  title = true, -- Show title
  undofile = true, -- Save a file of all of the undos
  undolevels = 1000, -- Maximum number of changes that can be undone
  -- Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
  -- delays and poor user experience.
  updatetime = 300,
  visualbell = true, -- Disable annoying beep
  -- winminwidth = 5, -- Windows can not get smaller than 5 columns
  -- winwidth = 110, -- Windows are set to 110 columns by default
  wrap = false, -- Don't wrap lines
  writebackup = false, -- Don't make backups
}

-- c - don't give |ins-completion-menu| messages. For example,
--     "-- XXX completion (YYY)", "match 1 of 2", "The only match",
--     "Pattern not found", "Back at original", etc.
-- s - don't give "search hit BOTTOM, continuing at TOP" or "search
--     hit TOP, continuing at BOTTOM" messages; when using the search
--     count do not show "W" after the count message
-- I - don't give the intro message when starting Vim :intro.
vim.opt.shortmess:append "csI"
-- Add dash (-) to keywords for better "word" (w) movement
vim.cmd [[set iskeyword+=-]]
-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
vim.opt.whichwrap:append "<>[]hl"

for k, v in pairs(options) do
  vim.opt[k] = v
end
