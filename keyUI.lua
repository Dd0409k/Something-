local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local TextBox = Instance.new("TextBox")
local SubmitButton = Instance.new("TextButton")

ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
Frame.Parent = ScreenGui
TextBox.Parent = Frame
SubmitButton.Parent = Frame

-- UI Properties
Frame.Size = UDim2.new(0, 300, 0, 150)
Frame.Position = UDim2.new(0.5, -150, 0.5, -75)
Frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Frame.Draggable = true
Frame.Active = true
Frame.Selectable = true

TextBox.Size = UDim2.new(0.8, 0, 0.3, 0)
TextBox.Position = UDim2.new(0.1, 0, 0.2, 0)
TextBox.PlaceholderText = "Enter script_key"
TextBox.Text = ""

SubmitButton.Size = UDim2.new(0.8, 0, 0.3, 0)
SubmitButton.Position = UDim2.new(0.1, 0, 0.6, 0)
SubmitButton.Text = "Submit"

-- Button Functionality
SubmitButton.MouseButton1Click:Connect(function()
    local script_key = TextBox.Text
    ScreenGui:Destroy() -- Remove UI
    
    -- Run your script here
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Dd0409k/Something-/refs/heads/main/Chatgpt.lua"))()
end)
