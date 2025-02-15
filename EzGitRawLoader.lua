-- Variables:
-- xdLqPt = ScreenGui
-- yRmNvA = Frame
-- gTsKpW = TextBox
-- qZjVrX = TextButton
-- vWqXzL = success
-- mNpYrK = result
-- dKfLmN = SizeButton

local xdLqPt = Instance.new("ScreenGui")
local yRmNvA = Instance.new("Frame")
local gTsKpW = Instance.new("TextBox")
local qZjVrX = Instance.new("TextButton")
local dKfLmN = Instance.new("TextButton")

-- Parent GUI to PlayerGui
xdLqPt.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Frame settings
yRmNvA.Parent = xdLqPt
yRmNvA.Size = UDim2.new(0, 300, 0, 150)
yRmNvA.Position = UDim2.new(0.5, -150, 0.5, -75)
yRmNvA.BackgroundColor3 = Color3.fromRGB(169, 169, 169) -- Gray color
yRmNvA.BorderSizePixel = 2
yRmNvA.Draggable = true
yRmNvA.Active = true

yRmNvA.SizeOptions = {
    Small = UDim2.new(0, 200, 0, 100),
    Medium = UDim2.new(0, 300, 0, 150),
    Large = UDim2.new(0, 400, 0, 200)
}

-- TextBox settings
gTsKpW.Parent = yRmNvA
gTsKpW.Size = UDim2.new(0.9, 0, 0.4, 0)
gTsKpW.Position = UDim2.new(0.05, 0, 0.1, 0)
gTsKpW.PlaceholderText = "Enter script URL"
gTsKpW.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
gTsKpW.Text = ""
gTsKpW.TextScaled = true

-- SubmitButton settings
qZjVrX.Parent = yRmNvA
qZjVrX.Size = UDim2.new(0.9, 0, 0.3, 0)
qZjVrX.Position = UDim2.new(0.05, 0, 0.6, 0)
qZjVrX.Text = "Load Script"
qZjVrX.BackgroundColor3 = Color3.fromRGB(120, 120, 120)
qZjVrX.TextScaled = true

-- SizeButton settings
dKfLmN.Parent = yRmNvA
dKfLmN.Size = UDim2.new(0.9, 0, 0.2, 0)
dKfLmN.Position = UDim2.new(0.05, 0, 0.85, 0)
dKfLmN.Text = "Resize UI"
dKfLmN.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
dKfLmN.TextScaled = true

-- Function to cycle through sizes
local sizeIndex = 1
local sizeKeys = {"Small", "Medium", "Large"}
dKfLmN.MouseButton1Click:Connect(function()
    sizeIndex = sizeIndex % #sizeKeys + 1
    yRmNvA.Size = yRmNvA.SizeOptions[sizeKeys[sizeIndex]]
end)

-- Function to load script
qZjVrX.MouseButton1Click:Connect(function()
    local url = gTsKpW.Text
    if url ~= "" then
        local vWqXzL, mNpYrK = pcall(function()
            return loadstring(game:HttpGet(url, true))()
        end)
        if not vWqXzL then
            warn("Error loading script:", mNpYrK)
        end
    end
end)
