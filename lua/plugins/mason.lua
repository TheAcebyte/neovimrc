return {
  {
    "mason-org/mason.nvim",
    opts = {},
    config = function()
      require("mason").setup()
    end,
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {},
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
    config = function()
      require("mason-lspconfig").setup({
        automatic_enable = true,
        ensure_installed = {
          "lua_ls",
          "ts_ls",
          "jsonls",
          "tailwindcss",
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = false,
        update_in_insert = true,
        severity_sort = true,
        float = {
          max_width = 80,
          max_height = 100,
          focusable = true,
          source = "always",
          prefix = " ",
          scope = "line",
          border = "rounded",
        },
      })

      local function custom_diagnostic_float()
        local bufnr, winnr = vim.diagnostic.open_float(nil, opts)

        if winnr then
          vim.api.nvim_win_set_option(winnr, "winhighlight", "NormalFloat:Normal")
          vim.api.nvim_win_set_option(winnr, "wrap", true)
          vim.api.nvim_win_set_option(winnr, "linebreak", true)
        end
      end

      vim.keymap.set("n", "<leader>ld", "K", { remap = true, desc = "LSP documentation" })
      vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, { desc = "LSP rename" })
      vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, { desc = "LSP code actions" })
      vim.keymap.set("n", "<leader>lf", custom_diagnostic_float, { desc = "LSP float diagnostics" })
      vim.keymap.set("n", "<leader>lg", "<C-]>", { desc = "LSP Go to definition" })
    end,
  },
  {
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason-org/mason.nvim",
      "nvimtools/none-ls.nvim",
    },
    config = function()
      require("mason-null-ls").setup({
        automatic_installation = false,
        ensure_installed = {
          "stylua",
          "prettier",
        },
      })
    end,
  },
  {
    "nvimtools/none-ls.nvim",
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.prettier,
        },
      })

      vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, { desc = "Global format" })
    end,
  },
}
