-- just a simple digging turtle.
-- single command turtle.

local function moveForward()
    -- Check if there's a block in front
    local hasBlock = turtle.detect()

    if hasBlock then
        -- There IS a block, so we need to dig it
        print("Block detected, fuel level: " .. turtle.getFuelLevel())

        local digSuccess, digData = turtle.dig()

        print("Dig result: " .. tostring(digSuccess), digData and digData.name or "no data")
        if not digSuccess then
            print("Failed to dig - may be protected or undiggable")
            return false
        end
        print("Mined block successfully")
    else
        print("No block in front, moving forward")
    end

    -- Now advance forward
    local moveSuccess, err = turtle.forward()
    if not moveSuccess then
        print("Error moving forward: " .. (err or "unknown reason"))
        return false
    end
    return true
end

-- Loop 15 times to move forward and mine blocks
for i = 1, 15 do
    local successInfo, dataInfo = turtle.inspect()
    if moveForward() then
        print("Moved block " .. i .. " of 15. " .. (dataInfo.name or "unknown block"))
    else
        print("Failed to move - stopping: " .. (dataInfo.name or "unknown reason"))
        break
    end
end
