local script_key = "HRAWEPWBGEEFjuKmiNtdbRFiWLnzOzDX" -- Store key
local url = "https://api.luarmor.net/files/v3/loaders/e4aedc7ccd2bacd83555baa884f3d4b1.lua"

local headers = {
    ["User-Agent"] = "Mozilla/5.0",
    ["key"] = script_key
}

local response = request({
    Url = url,
    Method = "GET",
    Headers = headers
})

if response and response.StatusCode == 200 then
    writefile("extracted.txt", response.Body)
    print("Script saved successfully.")
else
    warn("Failed to fetch script. Status:", response and response.StatusCode or "Unknown")
end
