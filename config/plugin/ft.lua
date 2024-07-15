vim.filetype.add({
  extension = {
    jq = "jq",
  },
  filename = {
    [".Justfile"] = "just",
    [".justfile"] = "just",
    ["Justfile"] = "just",
    ["justfile"] = "just",
  },
})
