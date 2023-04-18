function _G.confirm_quit()
	local should_not_quit = vim.fn.getcmdtype() == ":"
		and vim.fn.tabpagenr("$") == 1
		and vim.fn.confirm("Do you want to quit?", "&Yes\n&No", 2) ~= 1
	return tostring(not should_not_quit)
end

local quit_cmds = {
	"q",
	"quit",
	"wq",
	"x",
	"exit",
	"exi",
	"xit",
	"qa",
	"qall",
	"quitall",
	"wqa",
	"wqall",
	"xa",
	-- Left on purpose, in case things break
	-- "xall",
}
-- TODO: Is this the best way to do this?
local template = [[cnoreabbrev <expr> %s luaeval(v:lua.confirm_quit()) ? '%s<cr>' : '<C-c>']]
for _, cmd in ipairs(quit_cmds) do
	vim.cmd(string.format(template, cmd, cmd))
	vim.cmd(string.format(template, cmd .. "!", cmd .. "!"))
end
