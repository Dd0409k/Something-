local file = io.open("extract.txt", "w")  
file:write("Extracted LocalScripts:\n\n")

for _, scriptInstance in pairs(getinstances()) do  
    if scriptInstance:IsA("LocalScript") then  
        file:write("Found LocalScript: " .. scriptInstance:GetFullName() .. "\n")  
    end  
end  

file:close()  
print("✅ Script names dumped to extract.txt")  
local file = io.open("extract.txt", "w")  
file:write("Extracted Functions from Memory:\n\n")

for _, v in pairs(getgc(true)) do  
    if type(v) == "function" and not is_synapse_function(v) then  
        local info = debug.getinfo(v)  
        if info and info.source then  
            file:write("Function from: " .. info.source .. "\n")  
        end  
    end  
end  

file:close()  
print("✅ Function sources dumped to extract.txt")  
