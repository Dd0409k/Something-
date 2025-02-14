-- Spoof HWID to match the original one
local spoofedHWID = "1739547781.5328193"  -- Replace this with the HWID linked to your key
writefile("Hoho_Intro.txt", spoofedHWID) -- Overwrite with the spoofed HWID

--define ur key 
script_key = "ezkcfPhJGknkroDLzvlAXZciLBhNFDOH";

-- actual link to the game
loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/e4aedc7ccd2bacd83555baa884f3d4b1.lua"))()
