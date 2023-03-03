vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1



-- ======= PLUGINS ======= --
local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local install_plugins = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    print('Installing packer...')
    local packer_url = 'https://github.com/wbthomason/packer.nvim'
    vim.fn.system({'git', 'clone', '--depth', '1', packer_url, install_path})
    print('Done.')

    vim.cmd('packadd packer.nvim')
    install_plugins = true
end
require('packer').startup(function(use)
    -- patterned like `use 'github-user/repo'`
    -- ============== PLUGIN MANAGER ============== --
    use {'wbthomason/packer.nvim'}
    -- ======= THEMING ======= --
    use {'akinsho/bufferline.nvim'}
    use {'joshdick/onedark.vim' }
    use {'kyazdani42/nvim-web-devicons'}
    use {'nvim-lualine/lualine.nvim'} -- Status bar
    -- ============= FILE EXPLORER ============= --
    --use {'kyazdani42/nvim-tree.lua'}
    -- ========== LSP SUPPORT ========== --
    use {'neovim/nvim-lspconfig'}
    use {'williamboman/mason.nvim'}
    -- =========== AUTOCOMPLETE ============ --
    use {'hrsh7th/nvim-cmp'}
    use {'hrsh7th/cmp-nvim-lsp'}
    -- ======== SNIPPETS ======== --
    use {'L3MON4D3/LuaSnip'}
    -- ========== NAVIGATION ========== --
    use {'psliwka/vim-smoothie'}
    if install_plugins then
        require('packer').sync() end
end)
if install_plugins then
    print("Installing plugins...\nWait until complete then restart nvim.")
    return -- Avoid configuring plugins which are not yet installed
end



-- ============== PLUGIN CONFIGS ============== --
require("lualine").setup({
    options = {
        icons_enabled = false,
        section_separators = '',
        component_separators = '|',
    }
})

require("bufferline").setup({
    options = {
        mode = 'buffers',
        offsets = {
            {filetype = 'NvimTree'}
        },
    },
    highlights = {
        buffer_selected = {
            italic = false
        },
        indicator_selected = {
            fg = {attribute = 'fg', highlight = "Function"},
            italic = false
        }
    }
})

--require('nvim-tree').setup({
--    hijack_cursor = false,
--    -- open_on_setup = true,
--    -- open_on_setup_file = true,
--    -- open_on_tab = true,
--    on_attach = function(bufnr)
--        local bufmap = function(lhs, rhs, desc)
--            vim.keymap.set('n', lhs, rhs, {buffer = bufnr, desc = desc})
--        end
--        local api = require('nvim-tree.api')
--        bufmap('L', api.node.open.edit, 'Expand folder or go to file')
--        bufmap('H', api.node.navigate.parent_close, 'Close parent folder')
--        bufmap('gh', api.tree.toggle_hidden_filter, 'Toggle hidden files')
--    end
--})

require('mason').setup()
--require('lspconfig').pyright.setup({})
-- source: https://github.com/neovim/nvim-lspconfig
-- Mappings.
-- See `:help diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end
local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}
--
-- ensure dependencies are installed (eg. `sudo npm i -g pyright` for pyright)
require('lspconfig')['pyright'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
}

require('luasnip.loaders.from_vscode').lazy_load()

-- nvim-cmp (autocomplete)
vim.opt.completeopt = {'menu', 'menuone', 'noselect'}
local cmp = require('cmp')
local luasnip = require('luasnip')
local select_opts = {behavior = cmp.SelectBehavior.Select}
cmp.setup({
    snipper = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end
    },
    sources = {
        {name = 'path'},
        {name = 'nvim_lsp', keyword_length = 3},
        {name = 'buffer', keyword_length = 3},
        {name = 'luasnip', keyword_length = 2},
    },
    formatting = {
        fields = {'menu', 'abbr', 'kind'},
        format = function(entry, item)
            local menu_icon = {
                nvim_lsp = 'λ',
                luasnip = '⋗',
                buffer = 'Ω',
                path = '🖫',
            }
            item.menu = menu_icon[entry.source.name]
            return item
        end
    },
    -- See :help cmp-mapping
    mapping = {
        ['<Up>'] = cmp.mapping.select_prev_item(select_opts),
        ['<Down>'] = cmp.mapping.select_next_item(select_opts),
        ['<C-p>'] = cmp.mapping.select_prev_item(select_opts),
        ['<C-n>'] = cmp.mapping.select_next_item(select_opts),
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({select = false}),
        ['<C-d>'] = cmp.mapping(function(fallback)
            if luasnip.jumpable(1) then
                luasnip.jump(1)
            else
                fallback()
            end
        end, {'i', 's'}),
        ['<C-b>'] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, {'i', 's'}),
        ['<Tab>'] = cmp.mapping(function(fallback)
            local col = vim.fn.col('.') - 1
            if cmp.visible() then
                cmp.select_next_item(select_opts)
            elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
                fallback()
            else
                cmp.complete()
            end
        end, {'i', 's'}),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item(select_opts)
            else
                fallback()
            end
        end, {'i', 's'}),
    },
})



-- ========== LSP CONFIG ========== --
local lspconfig = require('lspconfig')
local lsp_defaults = lspconfig.util.default_config
lsp_defaults.capabilities = vim.tbl_deep_extend(
    'force',
    lsp_defaults.capabilities,
    require('cmp_nvim_lsp').default_capabilities()
)



-- ======================== DIAGNOSTIC CUSTOMIZATION ======================== --
local sign = function(opts)
    vim.fn.sign_define(opts.name, {
        texthl = opts.name,
        text = opts.text,
        numhl = ''
    })
end
sign({name = 'DiagnosticSignError', text = '✘'})
sign({name = 'DiagnosticSignWarn', text = '▲'})
sign({name = 'DiagnosticSignHint', text = '⚑'})
sign({name = 'DiagnosticSignInfo', text = ''})
vim.diagnostic.config({
    virtual_text = false,
    severity_sort = true,
    float = {
        border = 'rounded',
        source = 'always',
        header = '',
        prefix = '',
    },
})
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
    vim.lsp.handlers.hover,
    {border = 'rounded'}
)
vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
    vim.lsp.handlers.signature_help,
    {border = 'rounded'}
)



-- ===== LINES ===== --
vim.opt.number = true -- display absolute line numbers
vim.opt.relativenumber = true -- combines with above to make hybrid



-- ====== SEARCH ====== --
vim.opt.hlsearch = true -- highlight
vim.opt.ignorecase = true -- case insensitive searches...
vim.opt.smartcase = true -- ...except where uppercase in query



-- ===================== SPACING & INDENTATION ===================== --
vim.opt.autoindent = true
vim.opt.breakindent = true -- preserve indentation of 'virtual lines' w/ wrap
vim.opt.expandtab = true -- convert tab to the corresponding amount of spaces
vim.opt.shiftwidth = 4 -- amount of characters to indent a line (default: 8)
vim.opt.tabstop = 4 -- amount of space <tab> occupies (default: 8)
vim.opt.wrap = true -- wrap text if offscreen



-- ======= DISPLAY ======= --
vim.opt.termguicolors = true -- enable hexadecimal colors
vim.cmd('colorscheme industry')
vim.cmd('hi Normal guibg=NONE ctermbg=NONE') -- transparent backgrounnd
vim.wo.colorcolumn = '80'
vim.opt.cursorline = false



-- =========== KEYBINDINGS =========== --
-- vim.keymap.set({mode}, {lhs}, {rhs}, {opts})
-- TODO find suitable key to rebind middle mouse for clipboard pasting
