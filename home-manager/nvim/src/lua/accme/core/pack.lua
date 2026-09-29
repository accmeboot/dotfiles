-- Plugin manager glue. Required before `accme.plugins`: with a lockfile
-- present the very first `vim.pack.add()` installs every plugin in it, so
-- build hooks registered later never fire on a fresh machine.

vim.api.nvim_create_autocmd("PackChanged", {
	group = vim.api.nvim_create_augroup("accme_pack_build", { clear = true }),
	callback = function(ev)
		local name = ev.data.spec.name

		if ev.data.kind == "delete" then
			return
		elseif name == "nvim-treesitter" then
			vim.cmd.packadd("nvim-treesitter")
			require("nvim-treesitter").update()
		end
	end,
})

vim.api.nvim_create_user_command("PackUpdate", function(cmd)
	vim.pack.update(#cmd.fargs > 0 and cmd.fargs or nil)
end, {
	nargs = "*",
	complete = function()
		return vim.tbl_map(function(plugin)
			return plugin.spec.name
		end, vim.pack.get(nil, { info = false }))
	end,
	desc = "Update all plugins, or only the named ones",
})

vim.api.nvim_create_user_command("PackClean", function()
	local unused = vim.iter(vim.pack.get(nil, { info = false }))
		:filter(function(plugin)
			return not plugin.active
		end)
		:map(function(plugin)
			return plugin.spec.name
		end)
		:totable()

	if #unused == 0 then
		vim.notify("PackClean: nothing to remove")
		return
	end

	local prompt = ("Remove %d unused plugin(s)?\n%s"):format(#unused, table.concat(unused, "\n"))
	if vim.fn.confirm(prompt, "&Yes\n&No", 2) == 1 then
		vim.pack.del(unused)
	end
end, { desc = "Delete plugins that are on disk but no longer used" })
