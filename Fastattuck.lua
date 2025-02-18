local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local UIS = game:GetService("UserInputService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

repeat task.wait() until character and character:FindFirstChild("HumanoidRootPart")
local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
local attackCooldown = 0.2  -- Adjust speed safely
local attackRange = 50       -- Max range for detecting enemies
local lastAttack = tick()

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

-- Function to simulate a tap (M1 for mobile)
local function simulateTap()
    local viewportSize = workspace.CurrentCamera.ViewportSize
    local tapPosition = Vector2.new(viewportSize.X / 2, viewportSize.Y / 2) -- Center of the screen

    VirtualInputManager:SendTouchEvent(tapPosition.X, tapPosition.Y, 0, true, game, 1) -- Press
    task.wait(0.1)
    VirtualInputManager:SendTouchEvent(tapPosition.X, tapPosition.Y, 0, false, game, 1) -- Release
end

-- Function to attack the target
local function attackMob(mob)
    if tick() - lastAttack >= attackCooldown then
        humanoidRootPart.CFrame = mob.HumanoidRootPart.CFrame * CFrame.new(0, 0, -2) -- Position safely
        simulateTap() -- Simulate mobile attack
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
