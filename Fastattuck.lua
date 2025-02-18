local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local VirtualInputManager = game:GetService("VirtualInputManager")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

repeat task.wait() until character and character:FindFirstChild("HumanoidRootPart")
local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
local tool = nil
local attackCooldown = 0.2  -- Adjust for speed and anti-cheat evasion
local attackRange = 50       -- Max range to detect enemies
local lastAttack = tick()

-- Function to get the best weapon/tool
local function getTool()
    if character then
        for _, v in ipairs(character:GetChildren()) do
            if v:IsA("Tool") then
                return v
            end
        end
    end
    return nil
end

-- Function to find the nearest mob
local function getNearestMob()
    local nearest, minDistance = nil, attackRange
    for _, mob in ipairs(workspace:GetChildren()) do
        if mob:IsA("Model") and mob:FindFirstChild("Humanoid") and mob:FindFirstChild("HumanoidRootPart") then
            local distance = (humanoidRootPart.Position - mob.HumanoidRootPart.Position).Magnitude
            if distance < minDistance then
                minDistance = distance
                nearest = mob
            end
        end
    end
    return nearest
end

-- Function to attack the target
local function attackMob(mob)
    tool = getTool()
    if tool and tick() - lastAttack >= attackCooldown then
        humanoidRootPart.CFrame = mob.HumanoidRootPart.CFrame * CFrame.new(0, 0, -2) -- Positions behind enemy
        if tool:FindFirstChild("RemoteFunction") then
            tool.RemoteFunction:InvokeServer("Attack") -- Alternative method for some weapons
        else
            VirtualInputManager:SendKeyEvent(true, "E", false, game) -- Simulate attack key
            task.wait(0.1)
            VirtualInputManager:SendKeyEvent(false, "E", false, game)
        end
        lastAttack = tick()
    end
end

-- Main loop to continuously attack
RunService.RenderStepped:Connect(function()
    local target = getNearestMob()
    if target then
        attackMob(target)
    end
end)
