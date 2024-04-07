local function filepath()
  local fpath = vim.fn.fnamemodify(vim.fn.expand("%"), ":~:.:h")
  if fpath == "" or fpath == "." then
    return " "
  end

  return string.format(" %%<%s/", fpath)
end

local function filename()
  local fname = vim.fn.expand("%:t")
  if fname == "" then
    return ""
  end
  return fname .. " "
end

local function lsp()
  local count = {}
  local levels = {
    errors = "Error",
    warnings = "Warn",
    info = "Info",
    hints = "Hint",
  }

  for k, level in pairs(levels) do
    count[k] = vim.tbl_count(vim.diagnostic.get(0, { severity = level }))
  end

  local errors = ""
  local warnings = ""
  local hints = ""
  local info = ""

  if count["errors"] ~= 0 then
    errors = "%#DiagnosticVirtualTextError#E:" .. count["errors"] .. "%#Statusline# "
  end
  if count["warnings"] ~= 0 then
    warnings = "%#DiagnosticVirtualTextWarn#W:" .. count["warnings"] .. "%#Statusline# "
  end
  if count["hints"] ~= 0 then
    hints = "%#DiagnosticVirtualTextHint#H:" .. count["hints"] .. "%#Statusline# "
  end
  if count["info"] ~= 0 then
    info = "%#DiagnosticVirtualTextInfo#I:" .. count["info"] .. "%#Statusline# "
  end

  return errors .. warnings .. hints .. info
end

local function lineinfo()
  if vim.bo.filetype == "alpha" then
    return ""
  end
  return " %P %l:%c "
end

local function get_git_branch()
  vim.cmd [[highlight GitIcon guifg=#31748f guibg=#403d52]]

  local fugitive = vim.fn.exists("*FugitiveHead") == 1 and vim.fn.FugitiveHead() or ""
  return fugitive ~= "" and "%#GitIcon#" .. "  " .. "%#Visual#" .. fugitive .. " " or ""
end

Statusline = {}

Statusline.active = function()
  return table.concat({
    get_git_branch(),
    "%#Statusline#",
    filepath(),
    filename(),
    "%=%#StatuslineExtra#",
    "%#VirtualTextInfo#",
    lsp(),
    "%#Statusline#",
    "%#Visual#",
    lineinfo(),
  })
end

function Statusline.inactive()
  return " %F"
end

vim.api.nvim_exec2(
  [[
  augroup Statusline
  au!
  au WinEnter,BufEnter * setlocal statusline=%!v:lua.Statusline.active()
  au WinLeave,BufLeave * setlocal statusline=%!v:lua.Statusline.inactive()
  augroup END
]],
  { output = false }
)
