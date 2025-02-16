print("Extracting LocalScripts...")

for _, scriptInstance in pairs(getinstances()) do  
    if scriptInstance:IsA("LocalScript") then  
        print("Found LocalScript: " .. scriptInstance:GetFullName())  
    end  
end  

print("✅ Done extracting LocalScript names.")
print("Extracting function sources...")

for _, v in pairs(getgc(true)) do  
    if type(v) == "function" and not is_synapse_function(v) then  
        local info = debug.getinfo(v)  
        if info and info.source then  
            print("Function from: " .. info.source)  
        end  
    end  
end  

print("✅ Done extracting function sources.")
