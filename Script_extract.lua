script_key = "HRAWEPWBGEEFjuKmiNtdbRFiWLnzOzDX"; -- store key
local response = game:HttpGet(https://api.luarmor.net/files/v3/loaders/e4aedc7ccd2bacd83555baa884f3d4b1.lua) --define variable with the script
writefile("extracted.lua", response.Body) -- write it on a file locally 
