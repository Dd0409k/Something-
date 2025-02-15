-- Spoof HWID to match the original one
local spoofedHWID = "1739608430.6159837"  -- Replace this with the HWID linked to your key
writefile("Hoho_Intro.txt", spoofedHWID) -- Overwrite with the spoofed HWID

--define ur key 
script_key = "gFQOGGyXJZXDmoZLFIONUkkXLLljRJzi";

-- actual link to the game
loadstring(game:HttpGet("https://raw.githubusercontent.com/Dd0409k/Something-/refs/heads/main/realdirect.lua"))()
