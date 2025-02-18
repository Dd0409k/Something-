--local originalKick = game:GetService("Players").LocalPlayer.Kick
--game:GetService("Players").LocalPlayer.Kick = function(...)
--    warn("Blacklist detected, blocking kick...")
--end
local player = game:GetService("Players").LocalPlayer

-- Override Kick function
if player and player.Kick then
    player.Kick = function(self, reason)
        warn("Blocked Kick: " .. tostring(reason))
    end
end
