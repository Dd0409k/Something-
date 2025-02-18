local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local VirtualInputManager = game:GetService("VirtualInputManager")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
local tool = character:FindFirstChildOfClass("Tool") or player.Backpack:FindFirstChildOfClass("Tool")

local attackCooldown = 0.2  -- Adjust for speed while avoiding detection
local attackRange = 50       -- Distance for detecting nearby mobs
local lastAttack = tick()

local function getNearestMob()
    local nearest, minDistance = nil, attackRange
    for _, mob in ipairs(workspace:GetChildren()) do
        if mob:IsA("Model") and mob:FindFirstChild("Humanoid") and mob:FindFirstChild("HumanoidRootPart") then
            local distance = (humanoidRootPart.Position - mob.HumanoidRootPart.Position).magnitude
            if distance < minDistance then
                minDistance = distance
                nearest = mob
            end
        end
    end
    return nearest
end

local function attackMob(mob)
    if tool and tick() - lastAttack >= attackCooldown then
        humanoidRootPart.CFrame = mob.HumanoidRootPart.CFrame * CFrame.new(0, 0, -2) -- Slightly behind to avoid suspicion
        VirtualInputManager:SendKeyEvent(true, "E", false, game) -- Simulate keypress for attacking
        task.wait(0.1)
        VirtualInputManager:SendKeyEvent(false, "E", false, game)
        lastAttack = tick()
    end
end

RunService.RenderStepped:Connect(function()
    local target = getNearestMob()
    if target then
        attackMob(target)
    end
end)
