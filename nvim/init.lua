-- ensure the packer plugin manager is installed
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.cmd([[packadd packer.nvim]])
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()
require("packer").startup(function(use)
  -- Packer can manage itself
  use("wbthomason/packer.nvim")
  -- Collection of common configurations for the Nvim LSP client
  use("neovim/nvim-lspconfig")
  -- Visualize lsp progress
  use({
    "j-hui/fidget.nvim",
    config = function()
      require("fidget").setup()
    end
  })

  -- Autocompletion framework
  use("hrsh7th/nvim-cmp")
  use({
    -- cmp LSP completion
    "hrsh7th/cmp-nvim-lsp",
    -- cmp Snippet completion
    "hrsh7th/cmp-vsnip",
    -- cmp Path completion
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-buffer",
    after = { "hrsh7th/nvim-cmp" },
    requires = { "hrsh7th/nvim-cmp" },
  })
  -- See hrsh7th other plugins for more great completion sources!
  -- Snippet engine
  use('hrsh7th/vim-vsnip')
  -- Adds extra functionality over rust analyzer
  use("simrat39/rust-tools.nvim")

  -- TreeSitter
  use('nvim-treesitter/nvim-treesitter')

  -- Optional
  use("nvim-lua/popup.nvim")
  use("nvim-lua/plenary.nvim")
  -- use("nvim-telescope/telescope.nvim")
  use({ 'junegunn/fzf', run = './install --bin'})
  use('junegunn/fzf.vim')

  -- Some color scheme other then default
  -- use("arcticicestudio/nord-vim")
  use('junegunn/seoul256.vim')
end)

-- the first run will install packer and our plugins
if packer_bootstrap then
  require("packer").sync()
  return
end

vim.g.seoul256_background = 324
vim.api.nvim_command [[colorscheme seoul256]]

-- Remove background from colorschemes so it is transparent
vim.cmd [[hi! Normal ctermbg=NONE guibg=NONE]]

vim.env.FZF_DEFAULT_COMMAND = 'rg --files --glob "!.git/*"'

-- Set completeopt to have a better completion experience
-- :help completeopt
-- menuone: popup even when there's only one match
-- noinsert: Do not insert text until a selection is made
-- noselect: Do not auto-select, nvim-cmp plugin will handle this for us.
vim.o.completeopt = "menuone,noinsert,noselect"

-- Appearance
------------------------------------------------------------------------
-- relative line numbering, yo
-- number and relativenumber are window options. So doing vim.o.relativenumber = true
-- will not work
vim.wo.relativenumber = true
-- but we don't want pure relative line numbering. The line where the cursor is
-- should show absolute line number
vim.wo.number = true
-- show a bar on column 120. Going beyond 120 chars per line gets hard to read.
-- I have a linting rule in most of my projects to keep line limit to 120 chars.
-- I had no idea that colorcolumn is a window option
-- Tip: One way to find whether an option is global or window or buffer
-- try vim.o.<option_name> = 'blah' and run ex command :luafile %
-- It will tell you what the real type of the option_name should be
vim.wo.colorcolumn = "120"

-- maintain undo history between sessions
vim.cmd([[
set undofile
]])

-- Editing
-----------------------
-- doing vim.o.tabstop does not work. tabstop only works as a buffer option when trying to set with meta accessors
-- ideally, i guess they should be set per buffer depending on the type of file
-- vim.cmd [[set tabstop=4]]
-- vim.cmd [[set shiftwidth=4]]
-- vim.cmd [[set smarttab]]
-- vim.cmd [[autocmd FileType javascript setlocal ts=4 sts=4 sw=4]]
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.smarttab = true
-- don't want case sensitive searches
vim.o.ignorecase = true
-- but still want search to be smart. If i type a upper case thing, do a case
-- sensitive blah
vim.o.smartcase = true

-- Avoid showing extra messages when using completion
vim.opt.shortmess = vim.opt.shortmess + "c"
vim.opt.guicursor = ""
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Keymappings
-----------------------
-- Map leader key
vim.g.mapleader = ','

-- copy selection
vim.keymap.set('', '<leader>c', '"+y')
-- open fzf
vim.keymap.set('n', '<C-p>', '<cmd>Files<CR>')
-- Write file with Ctrl + s
vim.keymap.set("i", "<C-s>", "<Esc>:w<CR>i", {noremap = true})
vim.keymap.set("n", "<C-s>", ":w<CR>", {noremap = true})
-- Open a new tab
vim.keymap.set('n', '<C-w>t', '<cmd>tabnew<CR>')
vim.keymap.set('n', '<C-j>', '<C-w>j', {noremap = true})
vim.keymap.set('n', '<C-k>', '<C-w>k', {noremap = true})
vim.keymap.set('n', '<C-h>', '<C-w>h', {noremap = true})
vim.keymap.set('n', '<C-l>', '<C-w>l', {noremap = true})
-- wrap selection in {}, [], (), <>, "", or ''
vim.keymap.set('v', '{', "x<Esc>i{}<Esc>hp", {noremap = true})
vim.keymap.set('v', '[', "x<Esc>i[]<Esc>hp", {noremap = true})
vim.keymap.set('v', '(', "x<Esc>i()<Esc>hp", {noremap = true})
vim.keymap.set('v', '<leader><', "x<Esc>i<><Esc>hp", {noremap = true})
vim.keymap.set('v', '"', 'x<Esc>i""<Esc>hp', {noremap = true})
vim.keymap.set('v', "'", "x<Esc>i''<Esc>hp", {noremap = true})
-- vim.keymap.set('n', '<C-w>T', '<cmd>tabclose<CR>')
-- vim.keymap.set('n', '<S-Down>', '<C-w>2<')
-- vim.keymap.set('n', '<S-Left>', '<C-w>2-')
-- vim.keymap.set('n', '<S-Right>', '<C-w>2+')
-- vim.keymap.set('n', '<S-Up>', '<C-w>2>')
-- vim.keymap.set('n', '<leader>cc', '"+yy')
-- vim.keymap.set('n', '<leader>e', trim_whitespaces)
-- vim.keymap.set('n', '<leader>t', '<cmd>terminal<CR>')
-- vim.keymap.set('n', '<leader>u', '<cmd>update<CR>')
-- vim.keymap.set('n', '<leader>x', '<cmd>conf qa<CR>')
-- vim.keymap.set('n', 'H', 'zh')
-- vim.keymap.set('n', 'L', 'zl')
-- vim.keymap.set('n', 'yow', toggle_wrap)
-- vim.keymap.set('t', '<ESC>', escape_term, {expr = true})
-- vim.keymap.set('t', 'jj', escape_term, {expr = true})

local function on_attach(client, buffer)
  -- This callback is called when the LSP is atttached/enabled for this buffer
  -- we could set keymaps related to LSP, etc here.
end

-- Configure LSP through rust-tools.nvim plugin.
-- rust-tools will configure and enable certain LSP features for us.
-- See https://github.com/simrat39/rust-tools.nvim#configuration
local opts = {
  tools = {
    runnables = {
      use_telescope = true,
    },
    inlay_hints = {
      auto = true,
      show_parameter_hints = false,
      parameter_hints_prefix = "",
      other_hints_prefix = "",
    },
  },

  -- all the opts to send to nvim-lspconfig
  -- these override the defaults set by rust-tools.nvim
  -- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
  server = {
    -- on_attach is a callback called when the language server attachs to the buffer
    on_attach = on_attach,
    settings = {
      -- to enable rust-analyzer settings visit:
      -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
      ["rust-analyzer"] = {
        -- enable clippy on save
        checkOnSave = {
          command = "clippy",
        },
      },
    },
  },
}

require("rust-tools").setup(opts)

-- TypeScript lspconfig
local status, nvim_lsp = pcall(require, "lspconfig")
if (not status) then return end

local protocol = require('vim.lsp.protocol')

local on_attach = function(client, bufnr)
  -- format on save
  if client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = vim.api.nvim_create_augroup("Format", { clear = true }),
      buffer = bufnr,
      callback = function() vim.lsp.buf.formatting_seq_sync() end
    })
  end
end

-- TypeScript
nvim_lsp.tsserver.setup {
  on_attach = on_attach,
  filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
  cmd = { "typescript-language-server", "--stdio" }
}

-- TreeSitter
local status, ts = pcall(require, "nvim-treesitter.configs")
if (not status) then return end

ts.setup {
  highlight = {
    enable = true,
    disable = {},
  },
  indent = {
    enable = true,
    disable = {},
  },
  ensure_installed = {
    "tsx",
    "toml",
    "fish",
    "php",
    "json",
    "yaml",
    "swift",
    "css",
    "html",
    "lua"
  },
  autotag = {
    enable = true,
  },
}

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }

-- Setup Completion
-- See https://github.com/hrsh7th/nvim-cmp#basic-configuration
local cmp = require("cmp")
cmp.setup({
  preselect = cmp.PreselectMode.None,
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    -- Add tab support
    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
    ["<Tab>"] = cmp.mapping.select_next_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    }),
  },

  -- Installed sources
  sources = {
    { name = "nvim_lsp" },
    { name = "vsnip" },
    { name = "path" },
    { name = "buffer" },
  },
})

