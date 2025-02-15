-- Spoof HWID
local spoofedHWID = "1739608430.6159837"  -- Replace with your actual HWID if needed
writefile("Hoho_Intro.txt", spoofedHWID)

-- Define your key
script_key = "FhsQAnNvjsjQIBpwjFLWrNdQSwNDfrAA";

-- Fetch script
local script_content = game:HttpGet("https://api.luarmor.net/files/v3/loaders/e4aedc7ccd2bacd83555baa884f3d4b1.lua")

-- Save script to a file
writefile("final_extracted_script.lua", script_content)

print("Script extracted successfully!")
