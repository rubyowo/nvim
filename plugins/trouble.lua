return function()
  local trouble = require("trouble")
  trouble.setup({})

  vim.keymap.set("n", "<leader>tt", function()
    trouble.toggle("diagnostics")
  end, { silent = true })

  vim.keymap.set("n", "[d", function()
    trouble.next({ jump = true })
  end, { silent = true })

  vim.keymap.set("n", "]d", function()
    trouble.prev({ jump = true })
  end, { silent = true })
end
