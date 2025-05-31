local M = {}

M.status = {
  active = false,
  message = ""
}

function M.start_status()
  -- Instead of fidget.progress.handle.create(), just set status
  M.status.active = true
  M.status.message = "Thinking..."
end

function M.stop_status()
  -- Instead of fidget_progress_handle:finish(), just clear status
  M.status.active = false
  M.status.message = ""
end

function M.get_lualine_status()
  if M.status.active then
    return "🤔 " .. M.status.message
  else
    return ""
  end
end

function M.setup_status()
  local group = vim.api.nvim_create_augroup("CodeCompanionHooks", {})

  vim.api.nvim_create_autocmd({ "User" }, {
    pattern = "CodeCompanionRequest*",
    group = group,
    callback = function(request)
      if request.match == "CodeCompanionRequestStarted" then
        M.start_status() -- Changed from M.start_req_fidget()
      elseif request.match == "CodeCompanionRequestFinished" then
        M.stop_status()  -- Changed from M.stop_req_fidget()
      end
    end,
  })
end

return M
