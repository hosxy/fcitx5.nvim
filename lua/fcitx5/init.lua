local default_configs = require('fcitx5/config')

function autocmd(VimEvent,FileType,FnName)
	vim.api.nvim_command('autocmd '..VimEvent.." "..FileType.." ".."lua "..FnName)
end

function autocmd_im(ImName)
	vim.api.nvim_command('augroup fcitx5')
	autocmd("InsertEnter","*","require('fcitx5/utils').InsertEnter(".."'"..ImName.."'"..")")
	autocmd("InsertLeave","*","require('fcitx5/utils').InsertLeave(".."'"..ImName.."'"..")")
	vim.api.nvim_command('augroup end')
end
	

local setup = function(configs)	
	if configs == nil then
		configs = {}
	end
	setmetatable(configs,default_configs)
	
	if configs.input_method == "fcitx5" or configs.input_method == "fcitx5_rime" then
		autocmd_im(configs.input_method)
	else
		return {setup = setup}
	end
	
	if configs.disable_im == true then
		require('fcitx5/utils').disableIm(configs.input_method)
	end
end

return {setup=setup}
