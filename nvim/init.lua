vim.g.mapleader = ","

vim.api.nvim_create_autocmd({'BufWinEnter'}, {
  desc = 'Go to last cursor position',
  pattern = '*',
  command = 'silent! normal! g`"zv',
})

local options = {
    backup = false,
    clipboard = "unnamedplus",                        -- copy all to clipboard
    cmdheight = 2,                                    -- height of command line
    colorcolumn = "80",
    copyindent = true,                                -- make 'autoindent' use existing indent structure
    cursorline = true,                                -- highlight the screen line of the cursor
    expandtab = true,                                 -- expand <Tab> to spaces in Insert mode
    fileencoding = "utf-8",                           -- encoding for a local file
    fileencodings = "utf8,koi8r,cp1251,cp866,ucs-2le",-- список предполагаемых кодировок, в порядке предпочтения
    fileformat = "unix",                              -- eol format
    fileformats = "unix,dos",
    foldcolumn = "2",                                 -- width of the column with folds
    hidden = true,
    history = 5000,
    hlsearch = true,                                  -- highlight last used search pattern
    ignorecase = true,                                -- ignore case in search patterns
    incsearch = true,                                 -- do incremental searching
    infercase = true,                                 -- adjust case of match for keyword completion
    linebreak = true,                                 -- don't split words
    list = true,                                      -- show tabs, trail spaces and other
    listchars = "tab:>·,trail:-,extends:},precedes:{,nbsp:%",
    mouse = "a",                                      -- allow the mouse to be used in neovim
    number = true,                                    -- numbers at the left side
    pumheight = 10,                                   -- popup menu height
    relativenumber = true,                            -- set relative numbered lines
    ruler = true,                                     -- show the cursor position all the time
    scrolloff = 4,
    shiftround = true,                                -- round to 'shiftwidth' for '<<' and '>>'
    shiftwidth = 4,                                   -- the number of spaces inserted for each indentation
    showbreak = "~::",                                -- string to put before wrapped screen lines
    showtabline = 2,                                  -- always show tabs
    sidescrolloff = 8,                                -- minimal number of screen columns either side of cursor if wrap is `false`
    signcolumn = "yes",                               -- always show the sign column, otherwise it would shift the text each time
    smartcase = true,                                 -- override 'ignorecase' when pattern has uppercase
    smartindent = true,                               -- do clever autoindenting
    tabstop = 8,                                      -- number of spaces a <Tab> in the text stands for
    termguicolors = true,                             -- set term gui colors (most terminals support this)
    undofile = true,
    updatetime = 300,
    wildignorecase = true,                            -- ignore case when completing file names
    writebackup = false,
}

for k, v in pairs(options) do
    vim.opt[k] = v
end

require("plugins")

vim.opt.secure = true
vim.opt.exrc = true

