-- Attempt to Use Debug Hooks to Extract True Code
for i = 1, 1000 do  -- Limit loop to prevent infinite errors
    local success, info = pcall(debug.getinfo, i, "S")
    if not success or not info then break end
    print(info.source)
    writefile("true_executed.lua", info.source)
end

-- Dumping upvalues
local function dump_upvalues(fn)
    if type(fn) ~= "function" then return end
    for i = 1, 100 do  -- Prevent infinite loops
        local success, name, value = pcall(debug.getupvalue, fn, i)
        if not success or not name then break end
        local pront = "Upvalue: " .. tostring(name) .. " = " .. tostring(value)
        print(pront)
        writefile("upvalues.lua", pront)
    end
end

for _, v in pairs(debug.getregistry()) do
    if type(v) == "function" then
        dump_upvalues(v)
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

-- Hook loadstring() to Dump Decrypted Code
local originalLoadstring = loadstring
local scriptCounter = 1  

_G.safeLoadstring = function(code)
    local filename = string.format("decrypted_script%d.lua", scriptCounter)
    writefile(filename, code)  
    print("Decrypted script saved to " .. filename)
    
    scriptCounter = scriptCounter + 1  
    return originalLoadstring(code)
end

setreadonly(getfenv(), false)  -- Allow modifying global environment
rawset(getfenv(), "loadstring", _G.safeLoadstring)


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
