local utils = {}
utils.im_status = false  --false:inactive, true:active

local function dbus_cmd_fcitx5(cmd)
	return "dbus-send --session --print-reply=literal --type=method_call --dest=org.fcitx.Fcitx5 /controller org.fcitx.Fcitx.Controller1."..cmd
end

local function dbus_cmd_fcitx5_rime(cmd)
	return "dbus-send --session --print-reply=literal --type=method_call --dest=org.fcitx.Fcitx5 /rime org.fcitx.Fcitx.Rime1."..cmd
end


utils.ImStatus = function(ImName)
	if ImName == "fcitx5" then
		local status = string.match(io.popen(dbus_cmd_fcitx5("State")):read("*a"),"(%d)%c")
		if status == '2' then
			return true
		else
			return false
		end
	elseif ImName == "fcitx5_rime" then
		local status =  string.match(io.popen(dbus_cmd_fcitx5_rime("IsAsciiMode")):read("*a"),"%s(%l+)%c")
		if status == "false" then
			return true
		else
			return false
		end
	end
end


utils.enableIm = function(ImName)
	if ImName == "fcitx5" then
		os.execute(dbus_cmd_fcitx5("Activate"))
	elseif ImName == "fcitx5_rime" then
		os.execute(dbus_cmd_fcitx5_rime("SetAsciiMode boolean:false"))
	end
end

utils.disableIm = function(ImName)
	if ImName == "fcitx5" then
		os.execute(dbus_cmd_fcitx5("Deactivate"))
	elseif ImName == "fcitx5_rime" then
		os.execute(dbus_cmd_fcitx5_rime("SetAsciiMode boolean:true"))
	end		
end


utils.InsertEnter = function(ImName)
    if utils.im_status == true then
        utils.enableIm(ImName)
    end
end

utils.InsertLeave = function(ImName)
    utils.im_status = utils.ImStatus(ImName)
    if utils.im_status == true then
        utils.disableIm(ImName)
    end
end

return utils
