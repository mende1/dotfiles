--[[
 THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT
 `lvim` is the global options object
]]

-- vim options
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.relativenumber = true
vim.opt.timeoutlen = 400
vim.cmd("set clipboard=unnamedplus")

-- general
lvim.log.level = "info"
lvim.format_on_save = {
  enabled = true,
  pattern = "*.lua",
  timeout = 1000,
}
lvim.lsp.diagnostics.virtual_text = true

-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false

-- keymappings <https://www.lunarvim.org/docs/configuration/keybindings>
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.insert_mode["jj"] = "<ESC>"

lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"
lvim.keys.normal_mode["<S-x>"] = ":BufferKill<CR>"
-- lvim.lsp.buffer_mappings.normal_mode['H'] = { vim.lsp.buf.hover, "Show documentation" }

-- -- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["W"] = { "<cmd>noautocmd w<cr>", "Save without formatting" }
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
lvim.builtin.which_key.mappings["P"] = {
  "<cmd>lua require'telescope'.extensions.project.project{}<CR>", "Projects"
}

-- -- Change theme settings
-- lvim.colorscheme = "lunar"

-- After changing plugin config exit and reopen LunarVim, Run :PackerSync
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.terminal.open_mapping = "<C-t>"
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

-- Automatically install missing parsers when entering buffer
lvim.builtin.treesitter.auto_install = true

-- lvim.builtin.treesitter.ignore_install = { "haskell" }

-- -- generic LSP settings <https://www.lunarvim.org/docs/languages#lsp-support>

-- --- disable automatic installation of servers
-- lvim.lsp.installer.setup.automatic_installation = false

-- ---configure a server manually. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---see the full default list `:lua =lvim.lsp.automatic_configuration.skipped_servers`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---`:LvimInfo` lists which server(s) are skipped for the current filetype
-- lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
--   return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- -- linters and formatters <https://www.lunarvim.org/docs/languages#lintingformatting>
-- local formatters = require "lvim.lsp.null-ls.formatters"
-- formatters.setup {
--   { command = "stylua" },
--   {
--     command = "prettier",
--     extra_args = { "--print-width", "100" },
--     filetypes = { "typescript", "typescriptreact" },
--   },
-- }
-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   { command = "flake8", filetypes = { "python" } },
--   {
--     command = "shellcheck",
--     args = { "--severity", "warning" },
--   },
-- }

-- -- Additional Plugins <https://www.lunarvim.org/docs/plugins#user-plugins>
lvim.plugins = {
  --     {
  --       "folke/trouble.nvim",
  --       cmd = "TroubleToggle",
  --     },
  -- }
  {
    "tzachar/cmp-tabnine",
    run = "./install.sh",
    requires = "hrsh6th/nvim-cmp",
    event = "InsertEnter",
  },
  {
    "andweeb/presence.nvim",
    config = function()
      require("presence"):setup({
        main_image = "file"
      })
    end,
  },
  {
    "rmagatti/goto-preview",
    config = function()
      require('goto-preview').setup {
        width = 120; -- Width of the floating window
        height = 25; -- Height of the floating window
        default_mappings = false; -- Bind default mappings
        debug = false; -- Print debug information
        opacity = nil; -- 0-100 opacity level of the floating window where 100 is fully transparent.
        post_open_hook = nil -- A function taking two arguments, a buffer and a window to be ran as a hook.
        -- You can use "default_mappings = true" setup option
        -- Or explicitly set keybindings
        -- vim.cmd("nnoremap gpd <cmd>lua require('goto-preview').goto_preview_definition()<CR>")
        -- vim.cmd("nnoremap gpi <cmd>lua require('goto-preview').goto_preview_implementation()<CR>")
        -- vim.cmd("nnoremap gP <cmd>lua require('goto-preview').close_all_win()<CR>")
      }
    end
  },
}

-- -- Autocommands (`:help autocmd`) <https://neovim.io/doc/user/autocmd.html>
vim.api.nvim_create_autocmd("FileType", {
  pattern = "zsh",
  callback = function()
    -- let treesitter use bash highlight for zsh files as well
    require("nvim-treesitter.highlight").attach(0, "bash")
  end,
})

-- -- Diagnostics in Lualine
local utils = require("lualine.utils.utils")
local highlight = require("lualine.highlight")

local diagnostics_message = require("lualine.component"):extend()

diagnostics_message.default = {
  colors = {
    error = utils.extract_color_from_hllist(
      { "fg", "sp" },
      { "DiagnosticError", "LspDiagnosticsDefaultError", "DiffDelete" },
      "#e32636"
    ),
    warning = utils.extract_color_from_hllist(
      { "fg", "sp" },
      { "DiagnosticWarn", "LspDiagnosticsDefaultWarning", "DiffText" },
      "#ffa500"
    ),
    info = utils.extract_color_from_hllist(
      { "fg", "sp" },
      { "DiagnosticInfo", "LspDiagnosticsDefaultInformation", "DiffChange" },
      "#ffffff"
    ),
    hint = utils.extract_color_from_hllist(
      { "fg", "sp" },
      { "DiagnosticHint", "LspDiagnosticsDefaultHint", "DiffAdd" },
      "#273faf"
    ),
  },
}
function diagnostics_message:init(options)
  diagnostics_message.super:init(options)
  self.options.colors = vim.tbl_extend("force", diagnostics_message.default.colors, self.options.colors or {})
  self.highlights = { error = "", warn = "", info = "", hint = "" }
  self.highlights.error = highlight.create_component_highlight_group(
    { fg = self.options.colors.error },
    "diagnostics_message_error",
    self.options
  )
  self.highlights.warn = highlight.create_component_highlight_group(
    { fg = self.options.colors.warn },
    "diagnostics_message_warn",
    self.options
  )
  self.highlights.info = highlight.create_component_highlight_group(
    { fg = self.options.colors.info },
    "diagnostics_message_info",
    self.options
  )
  self.highlights.hint = highlight.create_component_highlight_group(
    { fg = self.options.colors.hint },
    "diagnostics_message_hint",
    self.options
  )
end

function diagnostics_message:update_status()
  local r, _ = unpack(vim.api.nvim_win_get_cursor(0))
  local diagnostics = vim.diagnostic.get(0, { lnum = r - 1 })
  if #diagnostics > 0 then
    local diag = diagnostics[1]
    for _, d in ipairs(diagnostics) do
      if d.severity < diag.severity then
        diagnostics = d
      end
    end
    local icons = { " ", " ", " ", " " }
    local hl = { self.highlights.error, self.highlights.warn, self.highlights.info, self.highlights.hint }
    return highlight.component_format_highlight(hl[diag.severity]) .. icons[diag.severity] .. " " .. diag.message
  else
    return ""
  end
end

lvim.builtin.lualine.sections.lualine_c = {
  {
    diagnostics_message,
    colors = {
      error = "#BF616A",
      warn = "#10a7c5",
      info = "#A3BE8C",
      hint = "#88C0D0",
    },
  },
}

require('lspconfig').emmet_ls.setup {}
