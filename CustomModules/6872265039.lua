--This watermark is used to delete the file if its cached, remove it to make the file persist after commits.
--This watermark is used to delete the file if its cached, remove it to make the file persist after commits.
local function vapeGithubRequest(scripturl)
	if not isfile("vape/"..scripturl) then
		local suc, res = pcall(function() return game:HttpGet("https://raw.githubusercontent.com/amrho94/AbyssVape/"..readfile("vape/commithash.txt").."/"..scripturl, true) end)
		if not suc or res == "404: Not Found" then return nil end
		if scripturl:find(".lua") then res = "--This watermark is used to delete the file if its cached, remove it to make the file persist after commits.\n"..res end
		writefile("vape/"..scripturl, res)
	end
	return readfile("vape/"..scripturl)
end

shared.CustomSaveVape = 6872274481
if isfile("vape/CustomModules/6872274481.lua") then
	local source = readfile("vape/CustomModules/6872274481.lua")
	source = source:gsub("if KnitGotten then break end", "if KnitGotten and KnitClient then break end")
	source = source:gsub("until KnitGotten\n\trepeat task%.wait%(%) until debug%.getupvalue%(KnitClient%.Start, 1%)", "until KnitGotten and KnitClient\n\tlocal knitStarted\n\tlocal knitStartTimeout = tick() + 10\n\trepeat\n\t\ttask.wait()\n\t\tlocal suc, res = pcall(function() return KnitClient.Start and debug.getupvalue(KnitClient.Start, 1) end)\n\t\tknitStarted = suc and res\n\tuntil knitStarted or tick() > knitStartTimeout")
	loadstring(source)()
else
	local publicrepo = vapeGithubRequest("CustomModules/6872274481.lua")
	if publicrepo then
		loadstring(publicrepo)()
	end
end
