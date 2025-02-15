-- Variables:
-- xdLqPt = ScreenGui
-- yRmNvA = Frame
-- gTsKpW = TextBox
-- qZjVrX = TextButton
-- dKfLmN = SizeButton
-- cBxNzO = CloseButton
-- vWqXzL = success
-- mNpYrK = result

local xdLqPt = Instance.new("ScreenGui")
local yRmNvA = Instance.new("Frame")
local gTsKpW = Instance.new("TextBox")
local qZjVrX = Instance.new("TextButton")
local dKfLmN = Instance.new("TextButton")
local cBxNzO = Instance.new("TextButton")

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

local sizeOptions = {
    Small = {Size = UDim2.new(0, 200, 0, 100), TextSize = 14},
    Medium = {Size = UDim2.new(0, 300, 0, 150), TextSize = 18},
    Large = {Size = UDim2.new(0, 400, 0, 200), TextSize = 22}
}

-- Close Button settings
cBxNzO.Parent = yRmNvA
cBxNzO.Size = UDim2.new(0, 25, 0, 25)
cBxNzO.Position = UDim2.new(1, -30, 0, 5)
cBxNzO.Text = "X"
cBxNzO.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
cBxNzO.TextScaled = true
cBxNzO.MouseButton1Click:Connect(function()
    xdLqPt:Destroy()
end)

-- TextBox settings
gTsKpW.Parent = yRmNvA
gTsKpW.Size = UDim2.new(0.9, 0, 0.3, 0)
gTsKpW.Position = UDim2.new(0.05, 0, 0.1, 0)
gTsKpW.PlaceholderText = "Enter script URL"
gTsKpW.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
gTsKpW.Text = ""
gTsKpW.TextScaled = true

-- SubmitButton settings
qZjVrX.Parent = yRmNvA
qZjVrX.Size = UDim2.new(0.9, 0, 0.3, 0)
qZjVrX.Position = UDim2.new(0.05, 0, 0.5, 0)
qZjVrX.Text = "Load Script"
qZjVrX.BackgroundColor3 = Color3.fromRGB(120, 120, 120)
qZjVrX.TextScaled = true

-- SizeButton settings
dKfLmN.Parent = yRmNvA
dKfLmN.Size = UDim2.new(0.9, 0, 0.2, 0)
dKfLmN.Position = UDim2.new(0.05, 0, 0.75, 0)
dKfLmN.Text = "Resize UI"
dKfLmN.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
dKfLmN.TextScaled = true

-- Function to cycle through sizes
local sizeIndex = 1
local sizeKeys = {"Small", "Medium", "Large"}
dKfLmN.MouseButton1Click:Connect(function()
    sizeIndex = sizeIndex % #sizeKeys + 1
    local selectedSize = sizeOptions[sizeKeys[sizeIndex]]
    yRmNvA.Size = selectedSize.Size
    gTsKpW.TextSize = selectedSize.TextSize
    qZjVrX.TextSize = selectedSize.TextSize
    dKfLmN.TextSize = selectedSize.TextSize
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
