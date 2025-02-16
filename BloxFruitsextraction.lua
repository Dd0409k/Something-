local data = "Extracted Data:\n\n"

-- Dump all objects in ReplicatedStorage
data = data .. "ReplicatedStorage Objects:\n"
for _, v in pairs(game:GetService("ReplicatedStorage"):GetChildren()) do  
    data = data .. " - " .. v.Name .. "\n"
end  
data = data .. "\n"

-- Dump all RemoteEvents and RemoteFunctions
data = data .. "RemoteEvents & RemoteFunctions:\n"
for _, v in pairs(getgc(true)) do  
    if typeof(v) == "Instance" and (v:IsA("RemoteEvent") or v:IsA("RemoteFunction")) then  
        data = data .. " - " .. v.Name .. "\n"
    end  
end  

-- Write everything to extracted.txt
writefile("extracted.txt", data)

print("✅ Dump complete! Check 'extracted.txt' for results.")
