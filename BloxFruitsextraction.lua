local data = "Extracted LocalScripts:\n\n"

for _, scriptInstance in pairs(getinstances()) do  
    if scriptInstance:IsA("LocalScript") then  
        data = data .. "Found LocalScript: " .. scriptInstance:GetFullName() .. "\n"
    end  
end  

writefile("extracted.txt", data)
print("✅ LocalScripts dumped to extracted.txt")
