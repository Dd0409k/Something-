-- Script to test if LocalScripts are vulnerable to extraction

-- Open file to dump extracted scripts
local file = io.open("extract.txt", "w")
file:write("Extracted LocalScripts:\n\n")

-- Find all LocalScripts running on the client
for _, scriptInstance in pairs(getinstances()) do
    if scriptInstance:IsA("LocalScript") then
        file:write("Found LocalScript: " .. scriptInstance:GetFullName() .. "\n")
        
        -- Attempt to print the script's source code
        local success, sourceCode = pcall(function()
            return scriptInstance.Source
        end)

        if success then
            file:write("Extracted Code:\n" .. sourceCode .. "\n\n")
        else
            file:write("⚠️ Failed to access script source (protected)\n\n")
        end
    end
end

-- Close file
file:close()

-- How to Protect Your Game:
-- 1. Move critical scripts to ServerScriptService (clients cannot access them).
-- 2. Use ModuleScripts stored in ServerStorage and require them from ServerScripts.
-- 3. Minimize client-side scripts and avoid storing sensitive data in them.
-- 4. Use server-side validation for all RemoteEvents/RemoteFunctions.
