local log = "Remote Event & Function Log:\n\n"

local function logData(name, ...)
    local args = {...}
    local argStr = ""

    for i, v in pairs(args) do
        argStr = argStr .. string.format("[%d]: %s\n", i, tostring(v))
    end

    log = log .. string.format("🔥 Event Triggered: %s\n%s\n", name, argStr)
    writefile("remote_log.txt", log)
end

-- Hook into all RemoteEvents
for _, v in pairs(getgc(true)) do  
    if typeof(v) == "Instance" and v:IsA("RemoteEvent") then  
        v.OnClientEvent:Connect(function(...)  
            logData("[Client] RemoteEvent - " .. v.Name, ...)  
        end)
    end  
end  

-- Hook into all RemoteFunctions
for _, v in pairs(game:GetService("ReplicatedStorage"):GetChildren()) do  
    if v:IsA("RemoteFunction") then  
        local oldInvokeServer = v.InvokeServer
        v.InvokeServer = function(self, ...)
            logData("[Client] RemoteFunction - " .. v.Name, ...)
            return oldInvokeServer(self, ...)
        end
    end  
end  

print("✅ Remote logger is running. Check 'remote_log.txt' for data.")
