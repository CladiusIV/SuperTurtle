-- Super Turtle main file. This is the main entry point for the Super Turtle script.
-- It sets up the mod, registers event handlers, and initializes the Super Turtle functionality.
-- yeah... digdug... I'm old lol... I don't know, just a fun name for a mining turtle script.

local function hasMiningTool()
    -- Check if the selected item is a mining tool
    local item = turtle.getItemDetail(turtle.getSelectedSlot())
    if item and item.name then
        -- Check for common mining tools
        if item.name:find("pickaxe") or item.name:find("axe") or item.name:find("shovel") or item.name:find("hoe") then
            return true
        end
    end
    return false
end

local function checkFuel()
    local fuel = turtle.getFuelLevel()
    print("Current fuel level: " .. fuel)

    -- Check if fuel is low (less than 20)
    if fuel < 20 then
        print("Warning: Low fuel!")
        return false
    end
    return true
end

local function refuelFromCoal()
    -- Get the last inventory slot (16 in ComputerCraft)
    local lastSlot = 16

    -- Check what's in the last slot
    local item = turtle.getItemDetail(lastSlot)

    -- Verify there's coal in the last slot
    if not item then
        print("Error: No item in the last inventory slot!")
        return false
    end

    if not item.name:find("coal") then
        print("Error: No coal in the last inventory slot! Found: " .. item.name)
        return false
    end

    -- Get fuel level before refueling
    local fuelBefore = turtle.getFuelLevel()

    -- Select the last slot and refuel
    turtle.select(lastSlot)
    local success, err = turtle.refuel()

    if not success then
        print("Error: Failed to refuel - " .. err)
        return false
    end

    -- Get fuel level after refueling
    local fuelAfter = turtle.getFuelLevel()
    local fuelAdded = fuelAfter - fuelBefore

    print("Refuel successful! Added " .. fuelAdded .. " fuel")
    print("Fuel level: " .. fuelBefore .. " → " .. fuelAfter)

    return true
end

local function moveForward()
    -- Check fuel before moving
    if not checkFuel() then
        print("Attempting to refuel...")
        if not refuelFromCoal() then
            print("Error: Not enough fuel to continue!")
            return false
        end
    end

    -- Check if turtle has a mining tool
    if not hasMiningTool() then
        print("Error: No mining tool equipped!")
        return false
    end

    -- Check if there's a block in front
    local success, block = turtle.detect()

    if not success then
        print("Error: Failed to detect block in front!")
        return false
    end

    if block then
        -- If there's a solid block, mine it first
        local digSuccess = turtle.dig()
        if not digSuccess then
            print("Error: Failed to dig block - it may be protected or undiggable!")
            return false
        end
    end

    -- Now advance forward
    local moveSuccess, err = turtle.forward()
    if not moveSuccess then
        print("Error moving forward: " .. err)
        return false
    end
    return true
end

-- Loop 15 times to move forward and mine blocks
for i = 1, 15 do
    if moveForward() then
        print("Moved block " .. i .. " of 15")
    else
        print("Failed to move - stopping")
        break
    end
end

print("Finished mining tunnel!")
