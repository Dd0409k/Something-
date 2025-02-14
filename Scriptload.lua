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
    -- Spoof HWID to match the original one
    local spoofedHWID = "1739495808.5848384"  -- Replace this with the HWID linked to your key
    writefile("Hoho_Intro.txt", spoofedHWID) -- Overwrite with the spoofed HWID
    
    -- Load script as usual
    local api = loadstring(game:HttpGet("https://sdkapi-public.luarmor.net/library.lua"))()
    api.script_id = isSupport
    
    local checking_key = false
    local do_check_key = function(key)
        if checking_key then return end
        checking_key = true
        key = key:gsub("[\r\n%z]", " "):gsub("[ \t]", ""):gsub("[ \n]", ""):gsub("[ \t]+%f[\r\n%z]", "")
        local status = {code = "KEY_VALID", message = "Key accepted"}


        StarterGui:SetCore("SendNotification",{
            Title = "Key System",
            Text = "[".. status.code .. "] " .. status.message,
            Icon = "rbxassetid://16276677105"
        })

        if (status.code == "KEY_VALID") then			
            script_key = key;
            getfenv(0).script_key = key;
            getfenv(1).script_key = key;
            writefile("HohoKeyV4.txt", key)
            wait(.25)
            api.load_script()
        end
        checking_key = false
    end

    -- Auto-submit the key
    local key = "HRAWEPWBGEEFjuKmiNtdbRFiWLnzOzDX" -- Replace with your actual key
    do_check_key(key)
end
