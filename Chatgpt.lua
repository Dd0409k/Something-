-- [Block the Kick Function] override the Kick function to prevent blacklisting:
-- Override Kick function
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Check if Kick exists and override it safely
if LocalPlayer and typeof(LocalPlayer.Kick) == "function" then
    local originalKick = LocalPlayer.Kick
    LocalPlayer.Kick = function(self, reason)
        warn("[BLOCKED] Kick attempted: " .. tostring(reason))
        return
    end
end

-- [Prevent Error Messages from Showing] Since the script modifies UI to show a blacklist message, override the function that changes text.
pcall(function()
    local errorPrompt = game:GetService("CoreGui").RobloxPromptGui.promptOverlay.ErrorPrompt
    errorPrompt.TitleFrame.ErrorTitle.Text = "Bypassed"
    errorPrompt.MessageArea.ErrorFrame.ErrorMessage.Text = "No blacklist detected."
end)
-- [Hook loadstring() to Dump Decrypted Code]
local originalLoadstring = loadstring
local scriptCounter = 1  -- Counter for unique filenames

loadstring = function(code)
    local filename = string.format("decrypted_script%d.lua", scriptCounter)
    writefile(filename, code)  -- Save decrypted script
    print("Decrypted script saved to " .. filename)
    scriptCounter = scriptCounter + 1  -- Increment counter for next script
    return originalLoadstring(code)
end
-- [Dump the Final, Decrypted Code] The second script{second loadstring it loads}(decrypted_script2.lua) still contains the Luraph wrapper, meaning it’s not fully decrypted yet.
local originalSetfenv = setfenv
setfenv = function(f, env)
    writefile("final_decrypted_script.lua", debug.getinfo(f).source)
    print("Final decrypted script saved!")
    return originalSetfenv(f, env)
end

-- Now, run your original script below this

--define ur key with my other code. keyUI.lua 
script_key = "eXHLLNuTEjXMVCHtqqQYSgDOlMIAUvmi"
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
