-- Hook loadstring() to Save Decrypted Code
local originalLoadstring = loadstring
local scriptCounter = 1  

_G.safeLoadstring = function(code)
    local filename = string.format("script%d.lua", scriptCounter)
    writefile(filename, code)  
    print("script saved to " .. filename)
    
    scriptCounter = scriptCounter + 1  
    return originalLoadstring(code)
end

setreadonly(getfenv(), false)  
rawset(getfenv(), "loadstring", _G.safeLoadstring)
