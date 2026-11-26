local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    "rebelot/kanagawa.nvim",
    "neovim/nvim-lspconfig",
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = true,
        opts = {},
    },
    "folke/neodev.nvim",
    "mfussenegger/nvim-lint",
    {
        "stevearc/conform.nvim",
        opts = {},
    },
    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim", -- required
            "sindrets/diffview.nvim", -- optional - diff integration
            "ibhagwan/fzf-lua", -- optional - fzf-lua picker
        },
        opts = {
            integrations = {
                fzf_lua = true,
            },
        },
    },
    "lewis6991/gitsigns.nvim",
    {
        "Saghen/blink.cmp",
        dependencies = { "saghen/blink.lib" },
        build = function()
            require("blink.cmp").build():pwait()
        end,
    },
    "ibhagwan/fzf-lua",
})

vim.cmd.colorscheme("kanagawa-dragon")

require("neodev").setup()
require("gitsigns").setup()
require("lualine").setup({
    sections = { lualine_x = { "lsp_status", "filetype" } },
})
require("mason").setup()
-- Fuzzy finding (fzf-lua replaces telescope)
local fzf_lua = require("fzf-lua")
vim.keymap.set("n", "<leader>ff", function()
    fzf_lua.files({})
end, { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", function()
    fzf_lua.live_grep()
end, { desc = "Live grep" })
vim.keymap.set("n", "<leader>fb", function()
    fzf_lua.buffers()
end, { desc = "Buffers" })
vim.keymap.set("n", "<leader>fh", function()
    fzf_lua.help_tags()
end, { desc = "Help tags" })

local conform = require("conform")
conform.setup({
    formatters_by_ft = {
        cmake = { "cmake_format" },
        javascript = { "prettier" },
        json = { "jq" },
        lua = { "stylua" },
        python = { "isort", "autopep8" },
        typescript = { "prettier" },
    },
})

vim.api.nvim_create_user_command("Format", function(args)
    local range = nil
    if args.count ~= -1 then
        local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
        range = {
            start = { args.line1, 0 },
            ["end"] = { args.line2, end_line:len() },
        }
    end
    require("conform").format({ async = true, lsp_fallback = true, range = range })
end, { range = true })

vim.keymap.set({ "n", "v" }, "<leader>f", ":Format<CR>", {})

-- Completion: replaces nvim-cmp + vim-vsnip + cmp-git + cmp-cmdline.
-- v2 defaults take no <CR> (accept is <C-y>); restore the old cmp feel with documented action names.
-- Brackets balance natively on accept (auto_brackets, default on) - no autopairs confirm_done hook to re-point.
require("blink.cmp").setup({
    keymap = {
        ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
        ["<CR>"] = { "accept", "fallback" },
    },
})

-- LSP: server configs come from nvim-lspconfig (auto-merged into vim.lsp.config).
-- mason installs the packages; the core enables the servers for their filetypes.
local mason_lspconfig = require("mason-lspconfig")
mason_lspconfig.setup({
    ensure_installed = {
        "bashls",
        "clangd",
        "cssls",
        "docker_compose_language_service",
        "dockerls",
        "html",
        "jsonls",
        "lua_ls",
        "marksman",
        "pyright",
        "rust_analyzer",
        "taplo",
        "ts_ls",
        "yamlls",
    },
})

vim.lsp.enable({
    "bashls",
    "clangd",
    "cssls",
    "docker_compose_language_service",
    "dockerls",
    "html",
    "jsonls",
    "lua_ls",
    "marksman",
    "pyright",
    "rust_analyzer",
    "taplo",
    "ts_ls",
    "yamlls",
})

require("lint").linters_by_ft = {
    markdown = { "vale" },
    python = { "pylint" },
}

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }
        vim.keymap.set("n", "<F2>", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "<F3>", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "<F4>", ":LspClangdSwitchSourceHeader<CR>", opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
        vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set({ "n", "v" }, "<leader>a", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "<leader>lf", function()
            vim.lsp.buf.format()
        end, opts)
    end,
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    callback = function()
        -- try_lint without arguments runs the linters defined in `linters_by_ft`
        -- for the current filetype
        require("lint").try_lint()
    end,
})

vim.diagnostic.config({
    virtual_lines = true,
})

vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
    callback = function()
        vim.diagnostic.open_float(nil, { focus = false })
    end,
})
