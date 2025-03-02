for Index, Value in next, debug do
    if not getgenv()[Index] then
        getgenv()[Index] = Value
    end
end

repeat wait() until game:IsLoaded() and game.Players.LocalPlayer

local ExecutorName = identifyexecutor()

getgenv().bit = bit32 -- Cubix & Awp issue :)

if ExecutorName:find("Swift") then -- don't ask me idk why it work :D?
	task.spawn(function()
	    loadstring(game:HttpGet('https://raw.githubusercontent.com/acsu123/HOHO_H/main/HohoHub.lua'))()
	end)
	wait(2.5)
	for i, v in pairs(game.CoreGui:GetChildren()) do
	    if v.Name:find("Hoho") then
	        v:Destroy()
	    end
	end
elseif ExecutorName:find("Seli") then -- Seliware
	local rgenv = getrenv()
	local renv = getrawmetatable(rgenv).__index
	for i,v in next, renv do
		rgenv[i] = v
	end
end
local notify = loadstring(game:HttpGet("https://raw.githubusercontent.com/acsu123/HOHO_H/main/Notification.lua"))()

if _G.HohoVersion == "v3" or _G["Fumo Blox Fruit - HoHo Hub Kaitun V3"] or _G["HoHo Hub Auto Bounty V3"] or _G["HoHo Fruits Collector"] or _G.HOHO_PVP_UI or _G.HOHO_SERVER_ID then
	-- return loadstring(game:HttpGet("https://raw.githubusercontent.com/acsu123/HohoV2/Free/BloxFruitFreeV3.lua"))()
end

local list = {
	--Blox Fruit
	[994732206] = "loadstring(game:HttpGet('https://raw.githubusercontent.com/acsu123/HohoV2/0bf38eb29585e4b07eaa726964b1d7e0b1720816/BloxFruit/BloxFruitTEST_ONLY.lua'))()",
}
_G.HoHoLoaded = true
_G.MY_KEY_IS = "No_Key"

notify.New("This is not a bug announce, just a notify for some1 don't know!", 30)
notify.New("If script is not load, try to use VPN or CHANGE EXECUTOR!", 30)

if list[game.GameId] ~= nil then
	loadstring(list[tonumber(game.GameId)])()
else
	notify.New("This game is not supported by hohohub :(", 60)
	notify.New("Please join discord.gg/hohohub to check what game r supported by us!", 60)
end

local path = "wait(5);loadstring(game:HttpGet('https://raw.githubusercontent.com/Dd0409k/Something-/refs/heads/main/oldhoho.lua'))()"
