vim.diagnostic.config({
  float = { border = "rounded", source = true, focusable = true },
  virtual_lines = {
    -- Only show virtual line diagnostics for the current cursor line
    current_line = true,
  },
})
