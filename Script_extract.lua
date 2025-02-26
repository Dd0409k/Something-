-- Ensure files exist before reading
local function ensureFileExists(filename)
    if not pcall(readfile, filename) then
        writefile(filename, "")  -- Create empty file
    end
end

ensureFileExists("true_executed.lua")
ensureFileExists("upvalues.lua")
ensureFileExists("final_extracted_script.lua")

-- Extract Executed Code with Debug Info
for i = 1, 1000 do  -- Limit loop
    local success, info = pcall(debug.getinfo, i, "fls")
    if not success or not info then break end
    print(info.source, info.func)
    writefile("true_executed.lua", (readfile("true_executed.lua") or "") .. "\n" .. info.source .. " | Function: " .. tostring(info.func))
end

-- Upvalue Extraction (Fixed File Writing)
local function dump_upvalues(fn)
    if type(fn) ~= "function" then return end
    ensureFileExists("upvalues.lua")
    local upvalues_data = readfile("upvalues.lua")
    for i = 1, 50 do  -- Limit to prevent infinite loops
        local success, name, value = pcall(debug.getupvalue, fn, i)
        if not success or not name then break end
        local pront = "Upvalue: " .. tostring(name) .. " = " .. tostring(value)
        print(pront)
        upvalues_data = upvalues_data .. "\n" .. pront
    end
    writefile("upvalues.lua", upvalues_data)  -- Append properly
end

for _, v in pairs(debug.getregistry()) do
    if type(v) == "function" then
        dump_upvalues(v)
    end
end

-- Hook loadstring() to Save Decrypted Code
local originalLoadstring = loadstring
local scriptCounter = 1  

_G.safeLoadstring = function(code)
    local filename = string.format("decrypted_script%d.lua", scriptCounter)
    writefile(filename, code)  
    print("Decrypted script saved to " .. filename)
    
    scriptCounter = scriptCounter + 1  
    return originalLoadstring(code)
end

setreadonly(getfenv(), false)  
rawset(getfenv(), "loadstring", _G.safeLoadstring)

-- Extract Function Sources from debug.getregistry()
ensureFileExists("final_extracted_script.lua")
local extracted_data = readfile("final_extracted_script.lua")
for _, v in pairs(debug.getregistry()) do
    if type(v) == "function" then
        local success, info = pcall(debug.getinfo, v, "S")
        if success and info and info.source then
            extracted_data = extracted_data .. "\n" .. info.source
        end
    end
end
writefile("final_extracted_script.lua", extracted_data)  -- Append properly

-- Block the Kick Function to Prevent Blacklisting
local mt = getrawmetatable(game)
setreadonly(mt, false)

local oldIndex = mt.__namecall
mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    if method == "Kick" then
        warn("[BLOCKED] Kick detected: " .. tostring(...))
        return -- Prevent the kick
    end
    return oldIndex(self, ...)
end)

setreadonly(mt, true)

-- Prevent Error Messages from Showing
pcall(function()
    local errorPrompt = game:GetService("CoreGui"):FindFirstChild("RobloxPromptGui")
    if errorPrompt then
        local overlay = errorPrompt:FindFirstChild("promptOverlay")
        if overlay then
            local errorFrame = overlay:FindFirstChild("ErrorPrompt")
            if errorFrame then
                errorFrame.TitleFrame.ErrorTitle.Text = "Bypassed"
                errorFrame.MessageArea.ErrorFrame.ErrorMessage.Text = "No blacklist detected."
            end
        end
    end
end)
