local originalKick = game:GetService("Players").LocalPlayer.Kick
game:GetService("Players").LocalPlayer.Kick = function(...)
    warn("Blacklist detected, blocking kick...")
end
