local isfile = isfile or function(file)
	local suc, res = pcall(function()
		return readfile(file)
	end)
	return suc and res ~= nil and res ~= ""
end

loadfile = loadfile or function(file)
	return loadstring(readfile(file))
end

if isfile("vape/MainScript.lua") then
	return loadfile("vape/MainScript.lua")()
end

return loadstring(game:HttpGet("https://raw.githubusercontent.com/amrho94/AbyssVape/main/MainScript.lua", true))()
