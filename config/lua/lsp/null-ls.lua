local null_present, null = pcall(require, "null-ls")

if not null_present then
  return
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local sources = {
  -- general
  null.builtins.formatting.treefmt.with({
    condition = function(utils)
      return utils.root_has_file("treefmt.toml")
    end,
  }),

  -- nix
  null.builtins.formatting.nixfmt,
  null.builtins.diagnostics.statix,
  null.builtins.diagnostics.deadnix,

  -- node/web
  null.builtins.formatting.prettier.with({
    filetypes = {
      "html",
      "astro",
      "vue",
    },
  }),

  -- shell
  null.builtins.formatting.shfmt,

  -- lua
  null.builtins.formatting.stylua,

  -- python
  null.builtins.formatting.black,
  null.builtins.formatting.isort,

  -- docs
  null.builtins.diagnostics.alex,
  null.builtins.diagnostics.proselint,
}

null.setup({
  sources = sources,
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({
            bufnr = bufnr,
            filter = function(c)
              return c.name == "null-ls"
            end,
          })
        end,
      })
    end
  end,
})

local toggle_formatters = function()
  null.toggle({ methods = null.methods.FORMATTING })
end

vim.api.nvim_create_user_command("ToggleFormatters", toggle_formatters, {})
