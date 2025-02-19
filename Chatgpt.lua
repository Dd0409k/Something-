-- Function to extract upvalues properly
local function extract_upvalues(fn)
    if type(fn) ~= "function" then return {} end
    local upvalues = {}

    for i = 1, math.huge do
        local success, name, value = pcall(debug.getupvalue, fn, i)
        if not success or not name then break end

        if value ~= nil and type(value) ~= "table" then  -- Ignore nil and generic tables
            table.insert(upvalues, {name = name, value = value})
        end
    end
    return upvalues
end


-- Scan registry for functions with useful upvalues
local extracted_data = {}
for _, v in pairs(debug.getregistry()) do
    if type(v) == "function" then
        local upvalues = extract_upvalues(v)
        if #upvalues > 0 then
            extracted_data[v] = upvalues
        end
    end
end

-- Save filtered upvalues
local output = ""
for fn, upvalues in pairs(extracted_data) do
    output = output .. tostring(fn) .. ":\n"
    for _, data in ipairs(upvalues) do
        output = output .. "  " .. data.name .. " = " .. tostring(data.value) .. "\n"
    end
end
writefile("filtered_upvalues.lua", output)
print("Filtered upvalues saved.")

-- Identify game-related tables
local function scan_table(tbl, depth)
    if depth > 3 then return end  -- Prevent deep recursion
    for k, v in pairs(tbl) do
        if type(v) == "table" then
            scan_table(v, depth + 1)
        elseif type(v) == "function" then
            local upvalues = extract_upvalues(v)
            if #upvalues > 0 then
                print("Found function with upvalues in table:", k, upvalues)
            end
        elseif type(v) == "string" and v:match("game") then
            print("Possible game-related entry:", k, v)
        end
    end
end

-- Run table scanner on key registry entries
for _, v in pairs(debug.getregistry()) do
    if type(v) == "table" then
        scan_table(v, 0)
    end
end


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

-- Now, run your original script below this

--define ur key with my other code. keyUI.lua 
-- https://raw.githubusercontent.com/Dd0409k/Something-/refs/heads/main/keyUI.lua
-- actual link to the loader
-- Luarmor Loader (Deobfuscated)

local licenseMessage = "This file is licensed with Luarmor. You must use the actual loadstring to execute this script. Do not run this file directly. Always use the loadstring."

local scriptID = "e4aedc7ccd2bacd83555baa884f3d4b1"
local scriptURL = "https://api.luarmor.net/files/v3/l/" .. scriptID .. ".lua"
local cacheFileName = scriptID .. "-cache.lua"

-- Check if script is being loaded correctly
if lrm_load_script then
    lrm_load_script(scriptID)
    while wait(1) do end
end

-- Fast loading system
is_from_loader = { Mode = "fastload" }
local delayTime = 0.03

l_fastload_enabled = function(mode)
    if mode == "flush" then
        wait(delayTime)
        delayTime = delayTime + 2

        local success, response
        local status, err = pcall(function()
            response = game:HttpGet(scriptURL)

            -- Save the downloaded script in a local file
            writefile(cacheFileName, "-- " .. licenseMessage .. "\n\nif not is_from_loader then warn('Use the loadstring, do not run this directly') return end;\n" .. response)
            wait(0.1)
            success = loadstring(response)
                
            writefile("final_extracted_script.lua", response)
            warn("Final script extracted! Check final_extracted_script.lua")
            return

        end)

        -- If loading fails, log the error
        if not status or not success then
            writefile("lrm-err-loader-log-httpresp.txt", tostring(response))
            warn("Error while executing loader. Err: " .. tostring(err) .. " See lrm-err-loader-log-httpresp.txt in your workspace.")
            return
        end

        success(is_from_loader)
    end

    -- Reloading mechanism
    if mode == "rl" then
        writefile(cacheFileName, "recache required")
        wait(0.2)
        delfile(cacheFileName)
    end
end

-- Try loading the cached script
local cachedScript
local cacheStatus, cacheErr = pcall(function()
    cachedScript = readfile(cacheFileName)
    if not cachedScript or #cachedScript < 5 then
        cachedScript = nil
        return
    end
    cachedScript = loadstring(cachedScript)
end)

-- If cache loading fails, fetch the script again
if not cacheStatus or not cachedScript then
    l_fastload_enabled("flush")
    return
end

-- Execute the cached script
cachedScript(is_from_loader)
