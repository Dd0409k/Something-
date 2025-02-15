local script_key = "HRAWEPWBGEEFjuKmiNtdbRFiWLnzOzDX" -- Store key
local url = "https://api.luarmor.net/files/v3/loaders/e4aedc7ccd2bacd83555baa884f3d4b1.lua?key=" .. script_key

local response = game:HttpGet(url) -- Fetch the script

if response then
    writefile("extracted.txt", response) -- Save to a file
    print("Script saved successfully.")
else
    warn("Failed to fetch script.")
end
