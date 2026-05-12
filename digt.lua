--
-- just a simple digging turtle.
-- tunnel digging turtle.
--

-- how many blocks to mine forward.
local args = { ... }
local mineLength = tonumber(args[1]) or 5

local function digging()
    -- Dig up and to the sides as well, to clear the path
    turtle.turnLeft();
    turtle.dig()
    turtle.turnRight();
    turtle.turnRight();
    turtle.dig()
    turtle.turnLeft();
end

local function diggingUp()
    turtle.digUp()
    turtle.up()
    turtle.turnLeft()
    turtle.dig()
    turtle.turnRight();
    turtle.turnRight();
    turtle.dig()
    turtle.turnLeft();
    turtle.down()
end

local function moveForward()
    -- Check if there's a block in front
    local hasBlock = turtle.detect()

    if hasBlock then
        -- There IS a block, so we need to dig it
        print("Block detected, fuel level: " .. turtle.getFuelLevel())

        local digSuccess, digData = turtle.dig()

        print("Dig result: " .. tostring(digSuccess), digData and digData.name or "no data")
        if not digSuccess then
            print("Failed to dig - may be protected or undiggable" .. (digData and digData.name or " unknown block"))
            return false
        end

        -- TODO - add a check to see if there's actually a block up or to the sides before trying to dig, to avoid unnecessary fuel usage
        digging()
        diggingUp()
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

-- Loop mineLength times to move forward and mine blocks
for i = 1, mineLength do
    local successInfo, dataInfo = turtle.inspect()
    if moveForward() then
        print("Moved block " .. i .. " of " .. mineLength .. ". " .. (dataInfo.name or "unknown block"))
    else
        print("Failed to move - stopping: " .. (dataInfo.name or "unknown reason"))
        break
    end
end
