local GameId = game.GameId
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local CoreGui = game:GetService("CoreGui")
local Debris = game:GetService("Debris")
local StarterGui = game:GetService("StarterGui")
local ContentProvider = game:GetService("ContentProvider")

repeat task.wait() until game:IsLoaded() and Players.LocalPlayer

plr = Players.LocalPlayer

local isSupport = nil
local GameList = {
	[994732206] = "e4aedc7ccd2bacd83555baa884f3d4b1", -- Blox Fruit
}

for id, scriptid in pairs(GameList) do
	if id == GameId then
		isSupport = scriptid
	end
end

if _G.loadCustomId then
	isSupport = _G.loadCustomId
end

if not isSupport then
	loadstring(game:HttpGet('https://raw.githubusercontent.com/acsu123/HohoV2/refs/heads/main/ScriptLoadButOlder.lua'))()
	wait(9e9)
end

INFO_DOT25_QUAD = TweenInfo.new(.25,Enum.EasingStyle.Quad)

function CoreGuiAdd(gui)
    repeat wait() until pcall(function()
        gui.Parent = CoreGui
    end)
end

PreloadID = {
	"rbxassetid://4560909609",
	"rbxassetid://12187376174",
}
UI_LOCK = true

function isNotLocked(v)
	if not v:GetAttribute("Locked") and UI_LOCK == false then
		return true
	end
end

do 
    local preload_content = {}
    for i,v in pairs(HOHO_Passcheck:GetDescendants()) do
        table.insert(preload_content,v)
    end
    for i,v in pairs(PreloadID) do
        table.insert(preload_content,v)
    end
    ContentProvider:PreloadAsync(preload_content)
    task.wait(.5)
    for i = 1, #preload_content do
        local asset = preload_content[i]
        local progress = i / #preload_content
        TweenService:Create(Content,TweenInfo.new(.1,Enum.EasingStyle.Quad),{Size = UDim2.new(progress,0,1,0)}):Play()
        task.wait(math.random(1,5)/50)
    end
    task.wait(.5)
    task.spawn(request, {  
	Url = 'http://127.0.0.1:6463/rpc?v=1',
        Method = 'POST',
        Headers = {
            ['Content-Type'] = 'application/json',
            ['origin'] = 'https://ptb.discord.com',
        },
        Body = HttpService:JSONEncode({
            ['args'] = {
            ['code'] = 'hohohub',
            ['sex'] = '?species=Goblin&realm=Toril'
        },
        ['cmd'] = 'INVITE_BROWSER',
        ['nonce'] = 'OwO'
    })})
    local api = loadstring(game:HttpGet("https://sdkapi-public.luarmor.net/library.lua"))()
    api.script_id = isSupport

    wait(.25)
    api.load_script()
end
