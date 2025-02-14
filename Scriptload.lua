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

local plr = Players.LocalPlayer
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

-- Directly load the script without checking for a key
local api = loadstring(game:HttpGet("https://sdkapi-public.luarmor.net/library.lua"))()
api.script_id = isSupport
api.load_script()
