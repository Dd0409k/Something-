local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui")

-- Create the UI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = PlayerGui

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 300, 0, 200)
Frame.Position = UDim2.new(0.5, -150, 0.5, -100)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.Parent = ScreenGui

local TextBox = Instance.new("TextBox")
TextBox.Size = UDim2.new(1, -20, 0.6, 0)
TextBox.Position = UDim2.new(0, 10, 0, 10)
TextBox.Text = "-- Enter Lua code here"
TextBox.ClearTextOnFocus = false
TextBox.MultiLine = true
TextBox.TextScaled = false
TextBox.TextColor3 = Color3.new(1, 1, 1)
TextBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
TextBox.Parent = Frame

local ExecuteButton = Instance.new("TextButton")
ExecuteButton.Size = UDim2.new(1, -20, 0.2, 0)
ExecuteButton.Position = UDim2.new(0, 10, 0.7, 0)
ExecuteButton.Text = "Execute"
ExecuteButton.TextColor3 = Color3.new(1, 1, 1)
ExecuteButton.BackgroundColor3 = Color3.fromRGB(20, 150, 20)
ExecuteButton.Parent = Frame

-- Execution logic
ExecuteButton.MouseButton1Click:Connect(function()
    local code = TextBox.Text
    local success, errorMessage = pcall(function()
        local func = loadstring(code)()
        if func then
            func()
        else
            warn("Error: Could not compile code")
        end
    end)

    if not success then
        warn("Execution error: " .. errorMessage)
    end
end)
