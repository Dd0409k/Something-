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
	--Adopt Me
	[383310974] = "loadstring(game:HttpGet('https://raw.githubusercontent.com/acsu123/HohoV2/refs/heads/Free/AdoptMe.lua'))()",
	
	--GO FISHING
	[6764180126] = "loadstring(game:HttpGet('https://raw.githubusercontent.com/acsu123/HohoV2/refs/heads/Free/GOFISHING.lua'))()",
	
	--Fisch
	[5750914919] = "loadstring(game:HttpGet('https://raw.githubusercontent.com/acsu123/HohoV2/refs/heads/Free/Fisch.lua'))()",
	
	--Pet Catchers
	[5686465822] = "loadstring(game:HttpGet('https://raw.githubusercontent.com/acsu123/HohoV2/Free/PetCatchers.lua'))()",
	
	--Slap Battles
	[2380077519] = "loadstring(game:HttpGet('https://raw.githubusercontent.com/acsu123/HohoV2/Free/SlapBattles.lua'))()",
	
	--Sol's RNG
	[5361032378] = "loadstring(game:HttpGet('https://raw.githubusercontent.com/acsu123/HohoV2/Free/SolRNG.lua'))()",
	
	--The Strongest Battlegrounds
	[3808081382] = "loadstring(game:HttpGet('https://raw.githubusercontent.com/acsu123/HohoV2/Free/TheStrongestBattleground.lua'))()",
	
	--DOORS
	[2440500124] = "loadstring(game:HttpGet('https://raw.githubusercontent.com/acsu123/HohoV2/Free/Doors.lua'))()",
	
	--BLADE BALL
	[4777817887] = "loadstring(game:HttpGet('https://raw.githubusercontent.com/acsu123/HohoV2/Free/BladeBall.lua'))()",
	
	--HONKAI STAR RAIL SIMULATOR
	[5477548919] = "loadstring(game:HttpGet('https://raw.githubusercontent.com/acsu123/HohoV2/Free/HonkaiStarRailSimulator.lua'))()",
	
	--BedWars
	[2619619496] = "loadstring(game:HttpGet('https://raw.githubusercontent.com/acsu123/GAME/main/bedwar.txt'))()",

	--Element Battle Ground
	[224422602] = "loadstring(game:HttpGet('https://raw.githubusercontent.com/acsu123/HOHO_H/SCRIPTS/elementBattlegr.lua'))()",

	--King Legacy
	[1451439645] = "loadstring(game:HttpGet('https://raw.githubusercontent.com/acsu123/HohoV2/Free/KingLegacyFree.lua'))()",

	--Blox Fruit
	[994732206] = "loadstring(game:HttpGet('https://raw.githubusercontent.com/acsu123/HohoV2/0bf38eb29585e4b07eaa726964b1d7e0b1720816/BloxFruit/BloxFruitTEST_ONLY.lua'))()",

	--Pet Simulator X
	[2316994223] = "loadstring(game:HttpGet('https://raw.githubusercontent.com/acsu123/HohoV2/Free/PetSimXFree.lua'))()",

	--Zombie Attack
	[504035427]="loadstring(game:HttpGet('https://raw.githubusercontent.com/acsu123/HOHO_H/SCRIPTS/ZombieAtack.lua'))()",

	--Two Piece
	[5303541547]="loadstring(game:HttpGet('https://raw.githubusercontent.com/AlongNgu/alonebruh/main/twoPiecehoho.lua'))()",

	--Dungeon Quest
	[848145103]="loadstring(game:HttpGet('https://raw.githubusercontent.com/acsu123/HOHO_H/Paid/DunegonQuest.lua'))()",

	--Tradelands
	[92096286]="loadstring(game:HttpGet('https://raw.githubusercontent.com/acsu123/HOHO_H/SCRIPTS/TradeLands.lua'))()",

	--Anime Fighters Simulator
	[2324662457]="loadstring(game:HttpGet('https://raw.githubusercontent.com/acsu123/HOHO_H/SCRIPTS/anime%20fighters%20simulator.lua'))()",

	--Arsenal
	[111958650]="loadstring(game:HttpGet('https://raw.githubusercontent.com/acsu123/HOHO_H/SCRIPTS/Arsenal.lua'))()",

	--Break In
	[1318971886]="loadstring(game:HttpGet('https://pastebin.com/raw/xUGJt9Ry', true))()",

	--Tower of Hell
	[703124385]="loadstring(game:HttpGet('https://raw.githubusercontent.com/acsu123/HOHO_H/SCRIPTS/TowerOfHell.lua'))()",

	--steve's one piece
	[741590026]="loadstring(game:HttpGet('https://raw.githubusercontent.com/acsu123/HOHO_H/SCRIPTS/SteveOnePiece.lua'))()",

	--Murder Mystery 2
	[66654135]="loadstring(game:HttpGet('https://raw.githubusercontent.com/acsu123/GAME/main/muder%20mys..2.txt'))()",

	--Giant Survival!
	[1342991001]="loadstring(game:HttpGet('https://pastebin.com/raw/zABEESgr', true))()",

	--Field Trip Z
	[1701332290]="loadstring(game:HttpGet('https://pastebin.com/raw/aY7Z3Nd3', true))()",

	--Mad City
	[498490399]="loadstring(game:HttpGet('https://pastebin.com/raw/EwnNCfin', true))()",

	--vn piece
	[1493595237]="loadstring(game:HttpGet('https://raw.githubusercontent.com/acsu123/HOHO_H/SCRIPTS/vn%20Piece%20script-obfuscated.lua', true))()",
	
	--Ro Fruit
	[3904583189]="loadstring(game:HttpGet('https://raw.githubusercontent.com/acsu123/HohoV2/Free/RoFruitFree.lua', true))()",

	--Collect All Pets
	[3359505957]="loadstring(game:HttpGet('https://raw.githubusercontent.com/acsu123/HohoV2/Free/CollectAllPetsFree.lua', true))()",
	
	--GPO
	[648454481]="loadstring(game:HttpGet('https://raw.githubusercontent.com/acsu123/HohoV2/Free/GPOFree.lua', true))()",

	--Anime Defense Simulator
	[4205109410]="loadstring(game:HttpGet('https://raw.githubusercontent.com/acsu123/HohoV2/Free/AnimeDefenseSimulatorFree.lua', true))()",

	--Anime Soul Simulator
	[4098816381]="loadstring(game:HttpGet('https://raw.githubusercontent.com/acsu123/HohoV2/Free/AnimeSoulSimulatorFree.lua', true))()",
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

local path = "wait(5);loadstring(game:HttpGet('https://raw.githubusercontent.com/acsu123/HohoV2/main/ScriptLoad.lua'))()"
