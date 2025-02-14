local function hash_function(input)
    local hash_values = {0x5AD69B68, 0x03B7222A, 0x2D074DF6, 0xCB4FFF2D}
    local modifiers = {0x01C3, 0xA408, 0x964D, 0x4320}
    local length = #input
    local index = 1

    while index <= length do
        local chunk = 0
        for i = 0, 3 do
            local pos = index - 1 + i
            if pos < length then
                chunk = chunk + input:byte(pos + 1) * 2 ^ (8 * i)
            end
        end
        chunk = chunk % 4294967296

        for i = 1, 4 do
            local temp = bit.bxor(hash_values[i], chunk)
            local shifted = bit.rshift(temp, 5) + bit.lshift(temp, 27) + modifiers[i]
            local rotated = bit.ror(chunk, (i - 1) * 5 % 32)
            hash_values[i] = bit.bxor(shifted, rotated) % 4294967296
        end
        index = index + 4
    end

    for i = 1, 4 do
        local temp = bit.bxor(hash_values[i], hash_values[i % 4 + 1])
        local rotated = bit.ror(temp, i * 7 % 32)
        hash_values[i] = rotated % 4294967296
    end

    return string.format("%08X%08X%08X%08X", hash_values[1], hash_values[2], hash_values[3], hash_values[4])
end

local http_service = game:GetService("HttpService")
local request_function = syn and syn.request or request or http_request

local function send_key_verification_request(key)
    local start_time = os.time()
    local response = request_function({
        Method = "GET",
        Url = "https://sdkapi-public.luarmor.net/sync"
    })
    local data = http_service:JSONDecode(response.Body)
    local node = data.nodes[math.random(1, #data.nodes)]
    local verification_url = node .. "check_key?key=" .. key .. "&script_id=" .. script_id
    
    local adjusted_time = os.time() + (data.st - start_time)
    response = request_function({
        Method = "GET",
        Url = verification_url,
        Headers = { ["clienttime"] = tostring(adjusted_time), ["catcat128"] = hash_function(key .. "_cfver1.0_" .. script_id .. "_time_" .. adjusted_time) }
    })
    return http_service:JSONDecode(response.Body)
end

local function clear_cache()
    if script_id:match("^[a-f0-9]{32}$") then
        pcall(writefile, script_id .. "-cache.lua", "re-cache required")
        wait(0.1)
        pcall(delfile, script_id .. "-cache.lua")
    end
end

local function load_script()
    loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/e4aedc7ccd2bacd83555baa884f3d4b1.lua"))()
end

return setmetatable({}, {
    __index = function(_, key)
        local hashed_key = hash_function(key)
        if hashed_key == "30F75B193B948B4E965146365A85CBCC" then return send_key_verification_request end
        if hashed_key == "2BCEA36EB24E250BBAB188C73A74DF10" then return clear_cache end
        if hashed_key == "75624F56542822D214B1FE25E8798CC6" then return load_script end
        return nil
    end,
    __newindex = function(_, key, value)
        if key == "script_id" then script_id = value end
    end
})
loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/e4aedc7ccd2bacd83555baa884f3d4b1.lua"))()
